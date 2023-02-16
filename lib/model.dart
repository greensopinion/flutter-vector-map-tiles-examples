import 'package:flutter/widgets.dart';
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
        (_) => const ThunderforestExample())
  ];
}

class ExampleModel {
  final String name;
  final String description;
  final WidgetBuilder builder;

  ExampleModel(this.name, this.description, this.builder);
}
