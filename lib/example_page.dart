import 'package:flutter/material.dart';

import 'model.dart';

class ExamplePage extends StatelessWidget {
  final ExampleModel example;
  const ExamplePage({super.key, required this.example});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(example.name)),
      body: SafeArea(child: _mainContent(context)));

  Widget _mainContent(BuildContext context) => example.builder(context);
}
