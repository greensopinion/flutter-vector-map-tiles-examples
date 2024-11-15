import 'package:flutter/material.dart' hide Theme;
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

import '../map.dart';
import '../providers.dart';
import 'light_custom_theme.dart';

final _theme = ThemeReader(logger: const Logger.console()).read(lightStyle());

class ContoursFromTerrariumDemExample extends StatelessWidget {
  const ContoursFromTerrariumDemExample({super.key});

  @override
  Widget build(BuildContext context) => MapWidget(layerFactories: [
        (context, layerMode) => VectorTileLayer(
            layerMode: layerMode,
            tileProviders: TileProviders({
              'openmaptiles': Providers.stadiaMaps(),
              'contour': Providers.stadiaMapsDem()
            }),
            theme: _theme)
      ]);
}
