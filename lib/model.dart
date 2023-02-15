import 'package:flutter/widgets.dart';

class Model {
  final List<ExampleModel> examples = [
    ExampleModel('Placeholder', 'A placeholder to demonstrate an example.',
        (_) => Text('This is a placeholder'))
  ];
}

class ExampleModel {
  final String name;
  final String description;
  final WidgetBuilder builder;

  ExampleModel(this.name, this.description, this.builder);
}
