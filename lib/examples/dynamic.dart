import 'package:flutter/material.dart' hide Theme;
import 'package:vector_map_tiles/vector_map_tiles.dart';

import '../map.dart';

class DynamicStyleExample extends StatelessWidget {
  final Style style;
  final TileOffset tileOffset;
  const DynamicStyleExample(
      {super.key, required this.style, this.tileOffset = TileOffset.DEFAULT});

  @override
  Widget build(BuildContext context) => MapWidget(
      center: style.center,
      layerFactory: (context, layerMode) => VectorTileLayer(
          tileProviders: style.providers,
          theme: style.theme,
          layerMode: layerMode,
          tileOffset: tileOffset));
}
