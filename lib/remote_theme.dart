import 'dart:convert';

import 'package:http/http.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

class RemoteTheme {
  final Theme theme;
  final TileProviders providers;

  RemoteTheme(this.theme, this.providers);
}

Future<RemoteTheme> loadRemoteTheme(String url, {String? key}) async {
  if (url.startsWith('mapbox:')) {
    url = _httpUrlFromMapboxScheme(url);
  }
  final json = jsonDecode(await _httpGet(url));
  final sources = json['sources'];
  if (sources is Map) {
    Map<String, VectorTileProvider> providers = {};
    final sourceEntries = sources.entries
        .where((s) => s.value['type'] == 'vector' && s.value['url'] is String)
        .toList();
    for (final entry in sourceEntries) {
      var entryUrl = entry.value['url'];
      if (entryUrl.startsWith('mapbox://')) {
        entryUrl = _httpSourceUrlFromMapboxScheme(entryUrl, _parameters(url));
      } else {
        entryUrl = _replaceKey(entryUrl, key);
      }
      final entryJson = jsonDecode(await _httpGet(entryUrl));
      final entryTiles = entryJson['tiles'];
      final maxzoom = entryJson['maxzoom'] as int? ?? 14;
      if (entryTiles is List && entryTiles.isNotEmpty) {
        providers[entry.key] = NetworkVectorTileProvider(
            urlTemplate: entryTiles[0], maximumZoom: maxzoom);
      }
    }
    if (providers.isEmpty) {
      throw 'Unexpected response';
    }
    return RemoteTheme(ThemeReader(logger: const Logger.console()).read(json),
        TileProviders(providers));
  }
  throw 'Unexpected response';
}

String _replaceKey(url, String? key) {
  return url.replaceAll(
      RegExp(RegExp.escape('{key}')), Uri.encodeQueryComponent(key ?? ''));
}

Future<String> _httpGet(String url) async {
  final response = await get(Uri.parse(url));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw 'HTTP ${response.statusCode}: ${response.body}';
  }
}

String _parameters(String url) {
  final match = RegExp(r'(.+?)\?(.+)').firstMatch(url);
  if (match == null) {
    return '';
  }
  return match.group(2)!;
}

String _httpSourceUrlFromMapboxScheme(String url, String parameters) {
  final match = RegExp(r'mapbox://(.+)').firstMatch(url);
  if (match == null) {
    throw 'Unexpected format: $url';
  }
  final style = match.group(1);
  return 'https://api.mapbox.com/v4/$style.json?secure&$parameters';
}

String _httpUrlFromMapboxScheme(String url) {
  final match = RegExp(r'mapbox://styles/([^/]+)/(.+?)\?(.+)').firstMatch(url);
  if (match == null) {
    throw 'Unexpected format: $url';
  }
  final username = match.group(1);
  final styleId = match.group(2);
  final parameters = match.group(3);
  return 'https://api.mapbox.com/styles/v1/$username/$styleId?$parameters';
}
