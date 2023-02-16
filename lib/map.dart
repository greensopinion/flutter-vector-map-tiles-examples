import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapWidget extends StatefulWidget {
  final VectorTileLayer Function(BuildContext) layerFactory;

  const MapWidget({super.key, required this.layerFactory});

  @override
  State<StatefulWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapWidget> {
  final MapController _controller = MapController();

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _controller,
      options: MapOptions(
          center: LatLng(43.7763331, 7.4733097),
          zoom: 13,
          maxZoom: 22,
          interactiveFlags: InteractiveFlag.drag |
              InteractiveFlag.flingAnimation |
              InteractiveFlag.pinchMove |
              InteractiveFlag.pinchZoom |
              InteractiveFlag.doubleTapZoom),
      children: [widget.layerFactory(context)],
    );
  }
}
