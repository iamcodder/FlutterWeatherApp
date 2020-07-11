import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:weatherapp/key/key.dart';

// ignore: must_be_immutable
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
  GoogleMapsPlaces _places;
  GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    currentPosition = LatLng(widget.latitude, widget.longitude);
    _addMarker(currentPosition);
    _places = GoogleMapsPlaces(apiKey: getApiKey());
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

  void _locationChange() {
    _mapController.moveCamera(CameraUpdate.newLatLng(currentPosition));
  }

  void _mapCreated(GoogleMapController controller) {
    _mapController = controller;
    _controller.complete(_mapController);
  }

  void _mapTypeSelector() {
    setState(() {
      _mapType =
          _mapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  Future<LatLng> displayPrediction(Prediction p) async {
    LatLng willReturnLatLng;
    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      willReturnLatLng = LatLng(lat, lng);
    } else
      willReturnLatLng =
          LatLng(currentPosition.latitude, currentPosition.longitude);
    return willReturnLatLng;
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
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onTap: (value) => _addMarker(value),
            ),
            Container(
                alignment: Alignment.topCenter,
                child: RaisedButton(
                  onPressed: () async {
                    Prediction p = await PlacesAutocomplete.show(
                        context: context, apiKey: getApiKey());
                    LatLng latLng = await displayPrediction(p);
                    _addMarker(latLng);
                    _locationChange();
                  },
                  child: Text('Find address'),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
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
