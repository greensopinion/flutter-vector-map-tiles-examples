import 'package:flutter/material.dart';

import 'model.dart';

class ExamplePage extends StatefulWidget {
  final ExampleModel example;
  const ExamplePage({super.key, required this.example});

  @override
  State<StatefulWidget> createState() => _ExamplePage();
}

class _ExamplePage extends State<ExamplePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(widget.example.name)),
      body: SafeArea(child: _mainContent(context)));

  Widget _mainContent(BuildContext context) => widget.example.builder(context);
}
