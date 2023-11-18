import 'package:flutter/material.dart';

import 'example_page.dart';
import 'model.dart';

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
      routes: Map.fromEntries(Model().examples.map((e) =>
          MapEntry(e.navigationPath, ((context) => ExamplePage(example: e))))),
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
            'vector_map_tiles examples',
          )),
          body: const SafeArea(child: MainPage())),
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
                    onTap: () => Navigator.pushNamed(context, e.navigationPath),
                    title: Text(e.name),
                    subtitle: Text(e.description))))
            .toList(),
      );
}
