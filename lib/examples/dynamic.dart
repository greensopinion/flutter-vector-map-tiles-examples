import 'package:flutter/material.dart' hide Theme;
import 'package:vector_map_tiles/vector_map_tiles.dart';

import '../map.dart';
import '../remote_theme.dart';

class DynamicStyleExample extends StatelessWidget {
  final RemoteTheme remoteTheme;
  const DynamicStyleExample({super.key, required this.remoteTheme});

  @override
  Widget build(BuildContext context) => MapWidget(
      center: remoteTheme.center,
      layerFactory: (context) => VectorTileLayer(
          tileProviders: remoteTheme.providers, theme: remoteTheme.theme));
}
