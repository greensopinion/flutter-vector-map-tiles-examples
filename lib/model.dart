import 'package:flutter/widgets.dart';
import 'package:vector_map_examples/examples/light_custom_theme.dart';

import 'examples/dynamic.dart';
import 'examples/maptiler.dart';
import 'examples/stadiamaps.dart';
import 'examples/thunderforest.dart';
import 'loadable.dart';
import 'providers.dart';
import 'remote_theme.dart';

class Model {
  final List<ExampleModel> examples = [
    ExampleModel(
        'Stadia Maps',
        'Demonstrates Stadia Maps with the default theme.',
        (_) => const StadiaMapsExample()),
    ExampleModel(
        'MapTiler',
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
        'Klokantech Basic',
        'Demonstrates using a theme loaded via URL.',
        (_) => _urlRemote(
            'https://cdn.jsdelivr.net/gh/openmaptiles/klokantech-basic-gl-style@v1.9/style.json',
            sourceId: 'maptiler')),
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
            'https://tiles.stadiamaps.com/styles/alidade_smooth.json',
            sourceId: 'stadia-maps',
            keyParameter: 'api_key')),
    ExampleModel(
        'Stadia Maps Outdoors',
        'Demonstrates using Stadia Maps with Outdoors loaded via URL.',
        (_) => _urlRemote('https://tiles.stadiamaps.com/styles/outdoors.json',
            sourceId: 'stadia-maps', keyParameter: 'api_key')),
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
  ]..sort((a, b) => a.name.compareTo(b.name));
}

class ExampleModel {
  final String name;
  final String description;
  final WidgetBuilder builder;

  ExampleModel(this.name, this.description, this.builder);
}

Widget _urlRemote(String url, {String? sourceId, String? keyParameter}) {
  return Loadable(
      loader: () => loadRemoteTheme(url,
          key: sourceId == null ? null : apiKey(sourceId),
          keyParameter: keyParameter),
      builder: (_, remoteTheme) =>
          DynamicStyleExample(remoteTheme: remoteTheme));
}

Widget _mapboxRemote(String styleId) {
  return Loadable(
      loader: () => loadRemoteTheme(urlTemplateWithApiKey('mapbox',
          'mapbox://styles/mapbox/$styleId?access_token=$apiKeyToken')),
      builder: (_, remoteTheme) =>
          DynamicStyleExample(remoteTheme: remoteTheme));
}
