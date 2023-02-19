import 'api_keys.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class Providers {
  static VectorTileProvider stadiaMaps() => _provider('stadia-maps',
      'https://tiles.stadiamaps.com/data/openmaptiles/{z}/{x}/{y}.pbf?api_key=$apiKeyToken');
  static VectorTileProvider thunderForestOutdoorsV2() => _provider(
      'thunderforest',
      'https://a.tile.thunderforest.com/thunderforest.outdoors-v2/{z}/{x}/{y}.vector.pbf?apikey=$apiKeyToken');
  static VectorTileProvider mapTiler() => _provider('maptiler',
      'https://api.maptiler.com/tiles/v3/{z}/{x}/{y}.pbf?key=$apiKeyToken');

  static NetworkVectorTileProvider _provider(String id, String urlTemplate) =>
      NetworkVectorTileProvider(
          maximumZoom: 14, urlTemplate: urlTemplateWithApiKey(id, urlTemplate));
}

String apiKey(String id) {
  final apiKey = apiKeys()[id];
  if (apiKey == null || apiKey.isEmpty) {
    throw 'No API key available for $id, update api_keys.dart with your API key!';
  }
  return apiKey;
}

String urlTemplateWithApiKey(String id, String urlTemplate) {
  return urlTemplate.replaceAll(
      RegExp(RegExp.escape(apiKeyToken)), Uri.encodeQueryComponent(apiKey(id)));
}

const apiKeyToken = '{key}';
