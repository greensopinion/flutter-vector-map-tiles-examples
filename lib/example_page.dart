import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_map_examples/loadable.dart';

import 'model.dart';

class ExamplePage extends StatelessWidget {
  final ExampleModel example;
  const ExamplePage({super.key, required this.example});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(example.name)),
      body: SafeArea(child: _mainContent(context)));

  Widget _mainContent(BuildContext context) => Loadable(
      loader: _clearCache, builder: (context, _) => example.builder(context));
}

Future _clearCache() async {
  final tmp = await getTemporaryDirectory();
  final tilesDir = Directory('${tmp.path}/.vector_map');
  if (await tilesDir.exists()) {
    await tilesDir.delete(recursive: true);
  }
  return true;
}
