import 'package:flutter/material.dart' hide Theme;
import 'package:vector_map_tiles/vector_map_tiles.dart';

import '../map.dart';

class DynamicStyleExample extends StatelessWidget {
  final Style style;
  const DynamicStyleExample({super.key, required this.style});

  @override
  Widget build(BuildContext context) => MapWidget(
      center: style.center,
      layerFactory: (context) =>
          VectorTileLayer(tileProviders: style.providers, theme: style.theme));
}
