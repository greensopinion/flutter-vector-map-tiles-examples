import 'package:flutter/widgets.dart';
import 'package:vector_map_examples/examples/light_custom_theme.dart';
import 'package:vector_map_examples/examples/multi_layer.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

import 'examples/dynamic.dart';
import 'examples/maptiler.dart';
import 'examples/stadiamaps.dart';
import 'examples/thunderforest.dart';
import 'loadable.dart';
import 'providers.dart';

class Model {
  final List<ExampleModel> examples = [
    ExampleModel(
        'Default Theme: Stadia Maps',
        'Demonstrates Stadia Maps with the default theme.',
        (_) => const StadiaMapsExample()),
    ExampleModel(
        'Default Theme: MapTiler',
        'Demonstrates use of MapTiler with the default theme.',
        (_) => const MaptilerExample()),
    ExampleModel(
        'Thunderforest',
        'Demonstrates Thunderforest with a custom theme, includes hillshade and terrain contours.',
        (_) => const ThunderforestExample()),
    ExampleModel('Mapbox Outdoors', 'Demonstrates using Mapbox outdoors theme.',
        (_) => _mapboxRemote('outdoors-v12')),
    ExampleModel('Mapbox Streets', 'Demonstrates using Mapbox streets theme.',
        (_) => _mapboxRemote('streets-v12')),
    ExampleModel('Mapbox Light', 'Demonstrates using Mapbox light theme.',
        (_) => _mapboxRemote('light-v11')),
    ExampleModel('Mapbox Dark', 'Demonstrates using Mapbox dark theme.',
        (_) => _mapboxRemote('dark-v11')),
    ExampleModel('Custom Theme', 'Demonstrates using a custom theme.',
        (_) => const LightCustomThemeExample()),
    ExampleModel(
        'MapTiler Dark',
        'Demonstrates using MapTiler with the Dark theme loaded via URL.',
        (_) => _maptilerRemote('basic-v2-dark')),
    ExampleModel(
        'MapTiler Light',
        'Demonstrates using MapTiler with the Light theme loaded via URL.',
        (_) => _maptilerRemote('basic-v2-light')),
    ExampleModel(
        'MapTiler Basic',
        'Demonstrates using MapTiler with the Light theme loaded via URL.',
        (_) => _maptilerRemote('basic-v2')),
    ExampleModel(
        'MapTiler Outdoor V2',
        'Demonstrates using MapTiler with the Outdoor V2 theme loaded via URL.',
        (_) => _maptilerRemote('outdoor-v2')),
    ExampleModel(
        'MapTiler Streets',
        'Demonstrates using MapTiler with the Streets theme loaded via URL.',
        (_) => _maptilerRemote('streets-v2')),
    ExampleModel(
        'MapTiler Winter V2',
        'Demonstrates using MapTiler with the Winter V2 theme loaded via URL.',
        (_) => _maptilerRemote('winter-v2')),
    ExampleModel(
        'Dark Matter',
        'Demonstrates using a theme loaded via URL.',
        (_) => _urlRemote(
            'https://cdn.jsdelivr.net/gh/openmaptiles/dark-matter-gl-style@v1.8/style.json',
            sourceId: 'maptiler')),
    ExampleModel(
        'OSM Bright',
        'Demonstrates using a theme loaded via URL.',
        (_) => _urlRemote(
            'https://cdn.jsdelivr.net/gh/openmaptiles/osm-bright-gl-style@v1.9/style.json',
            sourceId: 'maptiler')),
    ExampleModel(
        'OSM Liberty',
        'Demonstrates using a theme loaded via URL.',
        (_) => _urlRemote('https://maputnik.github.io/osm-liberty/style.json',
            sourceId: 'maptiler')),
    ExampleModel(
        'Toner',
        'Demonstrates using MapTiler with Toner theme loaded via URL.',
        (_) => _urlRemote(
            'https://cdn.jsdelivr.net/gh/openmaptiles/toner-gl-style@339e5b7/style.json',
            sourceId: 'maptiler')),
    ExampleModel(
        'Positron',
        'Demonstrates using MapTiler with Positron theme loaded via URL.',
        (_) => _urlRemote(
            'https://cdn.jsdelivr.net/gh/openmaptiles/positron-gl-style@v1.8/style.json',
            sourceId: 'maptiler')),
    ExampleModel(
        'Stadia Maps Alidade Smooth',
        'Demonstrates using Stadia Maps with Alidade Smooth loaded via URL.',
        (_) => _urlRemote(
            'https://tiles.stadiamaps.com/styles/alidade_smooth.json?api_key={key}',
            sourceId: 'stadia-maps')),
    ExampleModel(
        'Stadia Maps Outdoors',
        'Demonstrates using Stadia Maps with Outdoors loaded via URL.',
        (_) => _urlRemote(
            'https://tiles.stadiamaps.com/styles/outdoors.json?api_key={key}',
            sourceId: 'stadia-maps')),
    ExampleModel(
        'OS Open Zoomstack - Outdoor',
        'Demonstrates using OS Open Zoomstack with Outdoor theme loaded via URL.',
        (_) => _urlRemote(
            'https://s3-eu-west-1.amazonaws.com/tiles.os.uk/v2/styles/open-zoomstack-outdoor/style.json')),
    ExampleModel(
        'OS Open Zoomstack - Road',
        'Demonstrates using OS Open Zoomstack with Road theme loaded via URL.',
        (_) => _urlRemote(
            'https://s3-eu-west-1.amazonaws.com/tiles.os.uk/v2/styles/open-zoomstack-road/style.json')),
    ExampleModel(
        'OS Open Zoomstack - Light',
        'Demonstrates using OS Open Zoomstack with Light theme loaded via URL.',
        (_) => _urlRemote(
            'https://s3-eu-west-1.amazonaws.com/tiles.os.uk/v2/styles/open-zoomstack-light/style.json')),
    ExampleModel(
        'OS Open Zoomstack - Night',
        'Demonstrates using OS Open Zoomstack with Night theme loaded via URL.',
        (_) => _urlRemote(
            'https://s3-eu-west-1.amazonaws.com/tiles.os.uk/v2/styles/open-zoomstack-night/style.json')),
    ExampleModel(
        'Multi Layer',
        'Demonstrates using maps with multiple layers. A base layer is rendered with a raster style providing land and transport lines. A top layer is provided that renders either raster or vector providing labels and buildings.',
        (_) => const MultiLayerExample(key: Key('multi_layer_example'))),
  ]..sort((a, b) => a.name.compareTo(b.name));
}

class ExampleModel {
  final String name;
  late final String navigationPath;
  final String description;
  final WidgetBuilder builder;

  ExampleModel(this.name, this.description, this.builder)
      : navigationPath = name.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
}

Widget _urlRemote(String url,
    {String? sourceId, TileOffset tileOffset = TileOffset.DEFAULT}) {
  return Loadable(
      loader: () => StyleReader(
              uri: url,
              apiKey: sourceId == null ? null : apiKey(sourceId),
              logger: const Logger.console())
          .read(),
      builder: (_, remoteTheme) => DynamicStyleExample(
            style: remoteTheme,
            tileOffset: tileOffset,
            uri: url,
            apiKey: sourceId == null ? null : apiKey(sourceId),
          ));
}

Widget _mapboxRemote(String styleId) =>
    _urlRemote('mapbox://styles/mapbox/$styleId?access_token={key}',
        sourceId: 'mapbox', tileOffset: TileOffset.mapbox);

Widget _maptilerRemote(String styleId) =>
    _urlRemote('https://api.maptiler.com/maps/$styleId/style.json?key={key}',
        sourceId: 'maptiler');
