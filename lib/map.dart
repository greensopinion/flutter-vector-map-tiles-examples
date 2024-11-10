import 'package:flutter/material.dart' as material show Theme;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

typedef LayerFactory = Widget Function(BuildContext, VectorTileLayerMode mode);

class MapWidget extends StatefulWidget {
  final List<LayerFactory> layerFactories;
  final LatLng? center;
  final double? zoom;

  const MapWidget(
      {super.key, required this.layerFactories, this.center, this.zoom});

  @override
  State<StatefulWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapWidget> {
  final MapController _controller = MapController();
  var _layerMode = VectorTileLayerMode.vector;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Stack(children: [
        FlutterMap(
          mapController: _controller,
          options: MapOptions(
              initialCenter:
                  widget.center ?? const LatLng(43.7763331, 7.4733097),
              initialZoom: widget.zoom ?? 13,
              maxZoom: 22,
              backgroundColor: material.Theme.of(context).canvasColor),
          children: widget.layerFactories
              .map((layerFactory) => layerFactory(context, _layerMode))
              .toList(),
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                  children: [_modeButton(context), _mapInfo(context)]
                      .map((e) => Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 2),
                          child: e))
                      .toList()),
            ))
      ])),
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
        onPressed: () => _controller.move(
            LatLng(latitude, longitude), _controller.camera.zoom));
  }

  Widget _modeButton(BuildContext context) {
    return Container(
        color: Theme.of(context).canvasColor,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text("Mode"),
          ToggleButtons(
              onPressed: (index) {
                setState(() {
                  _layerMode = index == 0
                      ? VectorTileLayerMode.raster
                      : VectorTileLayerMode.vector;
                });
              },
              isSelected: [
                _layerMode == VectorTileLayerMode.raster,
                _layerMode == VectorTileLayerMode.vector
              ],
              children: const [
                Text('Raster'),
                Text('Vector'),
              ])
        ]));
  }

  Widget _mapInfo(BuildContext context) =>
      _MapStateInfo(mapController: _controller);
}

class _MapStateInfo extends StatefulWidget {
  final MapController mapController;

  const _MapStateInfo({required this.mapController});

  @override
  State<StatefulWidget> createState() => _MapStateInfoState();
}

class _MapStateInfoState extends State<_MapStateInfo> {
  bool _disposed = false;
  void onMapChange(event) {
    if (!_disposed) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    widget.mapController.mapEventStream.listen(onMapChange);
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(direction: Axis.vertical, spacing: 8.0, children: [
          Text('Zoom: ${widget.mapController.camera.zoom.toStringAsFixed(2)}'),
          Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: [
            Text(
                'Rotation: ${widget.mapController.camera.rotation.toStringAsFixed(2)}'),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(4),
                ),
                onPressed: () {
                  widget.mapController.rotate(0);
                },
                child: const Icon(Icons.north_rounded))
          ])
        ]));
  }
}
