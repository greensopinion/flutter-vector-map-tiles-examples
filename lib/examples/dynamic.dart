import 'dart:io';

import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_map/flutter_map.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

import '../map.dart';

class DynamicStyleExample extends StatelessWidget {
  final Style style;
  final TileOffset tileOffset;
  final String uri;
  final String? apiKey;
  const DynamicStyleExample(
      {super.key,
      required this.style,
      this.tileOffset = TileOffset.DEFAULT,
      required this.uri,
      this.apiKey});

  @override
  Widget build(BuildContext context) =>
      MapWidget(center: style.center, layerFactories: [
        (context, layerMode) =>
            layerMode == VectorTileLayerMode.raster && Platform.isIOS ||
                    Platform.isAndroid
                ? TileLayer(
                    tileProvider: createTileProvider(
                        styleUri: uri,
                        styleApiKey: apiKey,
                        tileOffset: tileOffset),
                  )
                : VectorTileLayer(
                    tileProviders: style.providers,
                    theme: style.theme,
                    sprites: style.sprites,
                    layerMode: layerMode,
                    tileOffset: tileOffset)
      ]);
}
