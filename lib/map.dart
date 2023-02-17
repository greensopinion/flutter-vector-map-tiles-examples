import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

class MapWidget extends StatefulWidget {
  final VectorTileLayer Function(BuildContext) layerFactory;
  final LatLng? center;
  final double? zoom;

  const MapWidget(
      {super.key, required this.layerFactory, this.center, this.zoom});

  @override
  State<StatefulWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapWidget> {
  final MapController _controller = MapController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: FlutterMap(
        mapController: _controller,
        options: MapOptions(
            center: widget.center ?? LatLng(43.7763331, 7.4733097),
            zoom: widget.zoom ?? 13,
            maxZoom: 22,
            interactiveFlags: InteractiveFlag.drag |
                InteractiveFlag.flingAnimation |
                InteractiveFlag.pinchMove |
                InteractiveFlag.pinchZoom |
                InteractiveFlag.doubleTapZoom),
        children: [widget.layerFactory(context)],
      )),
      Wrap(alignment: WrapAlignment.spaceBetween, children: [
        _positionButton('London', 51.515556, -0.093056),
        _positionButton('Paris', 48.8566, 2.3522),
        _positionButton('San Francisco', 37.7749, -122.4194),
        _positionButton('Vancouver', 49.2827, -123.1207),
        _positionButton('Hong Kong', 22.3193, 114.1694)
      ])
    ]);
  }

  Widget _positionButton(String name, double latitude, double longitude) {
    return TextButton(
        child: Text(
            '$name ${latitude.toStringAsFixed(2)},${longitude.toStringAsFixed(2)}'),
        onPressed: () =>
            _controller.move(LatLng(latitude, longitude), _controller.zoom));
  }
}
