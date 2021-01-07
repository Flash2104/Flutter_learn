import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treasure Mapp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Completer<GoogleMapController> _controller = Completer();
  double _zoom = 12;
  CameraPosition _position = CameraPosition(target: LatLng(55.751244, 37.618423), zoom: 12);

  Set<Marker> _markers = LinkedHashSet<Marker>(equals: (a, b) => a.markerId == b.markerId);

  @override
  void initState() {
    _getDevicePosition().then((value) {
      setState(() {
        _position = CameraPosition(target: value, zoom: 12);
      });
      _goToPosition(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('The Treasure Mapp')),
      body: Container(
          child: GoogleMap(
        initialCameraPosition: _position,
        mapType: MapType.hybrid,
        zoomControlsEnabled: false,
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
        markers: Set.of(_markers),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_circle_down_sharp),
        onPressed: () => _getDevicePosition().then((value) => _goToPosition(value)),
      ),
    );
  }

  Future<LatLng> _getDevicePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return Future.error('Location permissions are denied (actual value: $permission).');
      }
    }

    var position = await Geolocator.getCurrentPosition();
    var latLng = LatLng(position.latitude, position.longitude);
    return latLng;
  }

  Future _goToPosition(LatLng latLng) async {
    var controller = await _controller.future;
    _zoom = await controller.getZoomLevel();
    var camera = CameraPosition(target: latLng, zoom: _zoom);
    controller.animateCamera(CameraUpdate.newCameraPosition(camera));
    _addMarker(latLng, 'current_pos', 'Я тут');
  }

  void _addMarker(LatLng pos, String markerId, String markerTitle) {
    var icon = markerId == 'current_pos'
        ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
        : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
    _markers.add(Marker(markerId: MarkerId(markerId), position: _position.target, infoWindow: InfoWindow(title: markerTitle), icon: icon));
    setState(() {
      _markers = _markers;
    });
  }
}
