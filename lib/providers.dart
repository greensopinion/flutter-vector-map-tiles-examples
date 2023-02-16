import 'api_keys.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class Providers {
  static VectorTileProvider stadiaMaps() => _provider('stadia-maps',
      'https://tiles.stadiamaps.com/data/openmaptiles/{z}/{x}/{y}.pbf?api_key=$apiKeyToken');
  static VectorTileProvider thunderForestOutdoorsV2() => _provider(
      'thunderforest',
      'https://a.tile.thunderforest.com/thunderforest.outdoors-v2/{z}/{x}/{y}.vector.pbf?apikey=$apiKeyToken');

  static NetworkVectorTileProvider _provider(String id, String urlTemplate) =>
      NetworkVectorTileProvider(
          maximumZoom: 14,
          urlTemplate: _urlTemplateWithApiKey(id, urlTemplate));

  static String _urlTemplateWithApiKey(String id, String urlTemplate) {
    final apiKey = apiKeys()[id];
    if (apiKey == null || apiKey.isEmpty) {
      throw 'No API key available for $id, update api_keys.dart with your API key!';
    }
    return urlTemplate.replaceAll(RegExp(RegExp.escape(apiKeyToken)), apiKey);
  }
}

const apiKeyToken = '{apiKey}';
