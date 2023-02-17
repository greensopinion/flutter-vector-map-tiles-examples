import 'dart:convert';

import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

class RemoteTheme {
  final Theme theme;
  final TileProviders providers;
  final LatLng? center;
  final double? zoom;

  RemoteTheme(this.theme, this.providers, {this.center, this.zoom});
}

Future<RemoteTheme> loadRemoteTheme(String url,
    {String? key, String? keyParameter}) async {
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
      var entryUrl = entry.value['url'] as String;
      if (entryUrl.startsWith('mapbox://')) {
        entryUrl = _httpSourceUrlFromMapboxScheme(entryUrl, _parameters(url));
      } else {
        if (keyParameter != null && !entryUrl.contains(_keyToken)) {
          entryUrl = _appendKeyToken(entryUrl, keyParameter);
        }
        entryUrl = _replaceKey(entryUrl, key);
      }
      final entryJson = jsonDecode(await _httpGet(entryUrl));
      final entryTiles = entryJson['tiles'];
      final maxzoom = entryJson['maxzoom'] as int? ?? 14;
      if (entryTiles is List && entryTiles.isNotEmpty) {
        var tileUrl = entryTiles[0] as String;
        if (keyParameter != null) {
          if (!tileUrl.contains(_keyToken) &&
              key != null &&
              !tileUrl.contains(Uri.encodeQueryComponent(key))) {
            tileUrl = _appendKeyToken(tileUrl, keyParameter);
          }
          tileUrl = _replaceKey(tileUrl, key);
        }
        providers[entry.key] = NetworkVectorTileProvider(
            urlTemplate: tileUrl, maximumZoom: maxzoom);
      }
    }
    if (providers.isEmpty) {
      throw 'Unexpected response';
    }
    final center = json['center'];
    LatLng? centerPoint;
    if (center is List && center.length == 2) {
      centerPoint =
          LatLng((center[1] as num).toDouble(), (center[0] as num).toDouble());
    }
    double? zoom = (json['zoom'] as num?)?.toDouble();
    if (zoom != null && zoom < 2) {
      zoom = null;
      centerPoint = null;
    }
    return RemoteTheme(ThemeReader(logger: const Logger.console()).read(json),
        TileProviders(providers),
        center: centerPoint, zoom: zoom);
  }
  throw 'Unexpected response';
}

String _appendKeyToken(String url, String keyParameter) {
  String newUrl = url;
  if (newUrl.contains('?')) {
    newUrl = '$newUrl&';
  } else {
    newUrl = '$newUrl?';
  }
  return '$newUrl$keyParameter=$_keyToken';
}

String _replaceKey(url, String? key) {
  return url.replaceAll(
      RegExp(RegExp.escape(_keyToken)), Uri.encodeQueryComponent(key ?? ''));
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

const String _keyToken = '{key}';
