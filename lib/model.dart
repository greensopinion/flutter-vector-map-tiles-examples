import 'package:flutter/widgets.dart';
import 'package:vector_map_examples/examples/dynamic.dart';
import 'package:vector_map_examples/loadable.dart';
import 'package:vector_map_examples/providers.dart';
import 'package:vector_map_examples/remote_theme.dart';
import 'examples/basic.dart';
import 'examples/thunderforest.dart';

class Model {
  final List<ExampleModel> examples = [
    ExampleModel(
        'Basic',
        'Demonstrates the most basic use with the default theme.',
        (_) => const BasicExample()),
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
