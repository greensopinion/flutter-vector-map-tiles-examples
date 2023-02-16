import 'package:flutter/widgets.dart';

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
        'Demonstrates using thunderforest tile provider. Includes hillshade and terrain contours.',
        (_) => const ThunderforestExample()),
    ExampleModel('Mapbox Outdoors', 'Demonstrates using Mapbox outdoors theme.',
        (_) => _mapboxRemote('outdoors-v12')),
    ExampleModel('Mapbox Streets', 'Demonstrates using Mapbox streets theme.',
        (_) => _mapboxRemote('streets-v12')),
    ExampleModel('Mapbox Light', 'Demonstrates using Mapbox light theme.',
        (_) => _mapboxRemote('light-v11')),
    ExampleModel('Mapbox Dark', 'Demonstrates using Mapbox dark theme.',
        (_) => _mapboxRemote('dark-v11')),
  ];
}

class ExampleModel {
  final String name;
  final String description;
  final WidgetBuilder builder;

  ExampleModel(this.name, this.description, this.builder);
}

Widget _mapboxRemote(String styleId) {
  return Loadable(
      loader: () => loadRemoteTheme(urlTemplateWithApiKey('mapbox',
          'mapbox://styles/mapbox/$styleId?access_token=$apiKeyToken')),
      builder: (_, remoteTheme) =>
          DynamicStyleExample(remoteTheme: remoteTheme));
}
