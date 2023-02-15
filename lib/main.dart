import 'package:flutter/material.dart';
import 'package:vector_map_examples/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vector_map_tiles examples',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: Map.fromEntries(Model().examples.map(
          (e) => MapEntry(e.name, ((context) => _ExamplePage(example: e))))),
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
            'vector_map_tiles examples',
          )),
          body: const MainPage()),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(8),
        children: Model()
            .examples
            .map((e) => Card(
                child: ListTile(
                    onTap: () => Navigator.pushNamed(context, e.name),
                    title: Text(e.name),
                    subtitle: Text(e.description))))
            .toList(),
      );
}

class _ExamplePage extends StatelessWidget {
  final ExampleModel example;

  const _ExamplePage({super.key, required this.example});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(example.name)),
      body: example.builder(context));
}
