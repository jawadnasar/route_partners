
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarLocationScreen extends StatefulWidget {
  const CarLocationScreen({super.key});

  
  

  @override
  State<CarLocationScreen> createState() => _CarLocationScreenState();
}

class _CarLocationScreenState extends State<CarLocationScreen> {
  late GoogleMapController googleMapController;
  final Completer<GoogleMapController> completer = Completer();
  List<Marker> markers = [];
  // final Set<Polyline> _polyline = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  @override
  void initState() {
    super.initState();
    
    // _polyline.add(
    //   Polyline(
    //       polylineId: const PolylineId('1'),
    //       visible: true,
    //       points: widget.latlng,
    //       color: kPrimaryColor),
    // );
    
  }

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
    if (!completer.isCompleted) {
      completer.complete(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            trafficEnabled: true,
            onMapCreated: onMapCreated,
            // polylines: _polyline,
            markers: markers.toSet(),
            polylines: Set<Polyline>.of(polylines.values),
            initialCameraPosition: const CameraPosition(
              target:
                  LatLng(33.27,33.25),
              zoom: 15.0,
            ),
          ),
          
        ],
      ),
    );
  }
}