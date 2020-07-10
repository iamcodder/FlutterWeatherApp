import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  double latitude, longitude;

  MapScreen(this.latitude, this.longitude);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  LatLng currentPosition;
  Completer<GoogleMapController> _controller = Completer();
  MapType _mapType = MapType.normal;
  Set<Marker> _markers = {};

  @override
  void initState() {
    currentPosition = LatLng(widget.latitude, widget.longitude);
    _addMarker(currentPosition);
  }

  Future<bool> gotoBackScreen() async {
    Navigator.pop(context, currentPosition);
    return false;
  }

  void _addMarker(LatLng latLng) {
    setState(() {
      currentPosition = latLng;
      if (_markers.isNotEmpty) _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId(currentPosition.toString()),
        position: currentPosition,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _cameraMoved(CameraPosition position) {
    currentPosition = position.target;
  }

  void _mapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _mapTypeSelector() {
    setState(() {
      _mapType =
          _mapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: gotoBackScreen,
      child: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: _mapType,
              initialCameraPosition:
                  CameraPosition(target: currentPosition, zoom: 18),
              zoomGesturesEnabled: true,
              markers: _markers,
              onCameraMove: _cameraMoved,
              onMapCreated: _mapCreated,
              onTap: (value) => _addMarker(value),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: FloatingActionButton(
                  onPressed: _mapTypeSelector,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.map, size: 36.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
