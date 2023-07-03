import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MonoCapitalMap1 extends StatefulWidget {
  const MonoCapitalMap1({super.key});

  @override
  _MonorailMapState createState() => _MonorailMapState();
}

class _MonorailMapState extends State<MonoCapitalMap1>
    with TickerProviderStateMixin {
  late Completer<GoogleMapController> _controllerCompleter;
  late List<Marker> _markers;
  late List<LatLng> _locations;
  late List<LatLng> _stations;
  late int _currentLocationIndex;
  late int _currentStationIndex = 0;

  late AnimationController _animationController;

  GoogleMapController? _googleMapController;
  // final double _markerSize = 30.0;
  final int _lineWidth = 5;
  final Color _lineColor = Colors.blue;
  // final Color _markerColor = Colors.red;
  int _waitTime = 2;
  double speedMono = 3;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _speedSubscription;
  final mapNameStation = [
    'محطة الفتاح العليم',
    'محطة الدائري الاوسطي',
    ' محطة  15 العاصمة الادارية',
    'محطة R1 ',
    'محطة 16 العاصمة الادارية ',
    'محطة R2 ',
    'محطة 17 العاصمة الادارية ',
    'محطة 18 العاصمة الادارية',
    'محطة R3 ',
    'محطة الفنون والثقافة',
    'محطة مسجد مصر',
    'محطة مدينة العدالة'
  ];
  final mapNameStation2 = [
    'محطة الفتاح العليم',
    'محطة الفتاح العليم',
    'محطة الدائري الاوسطي',
    ' محطة  15 العاصمة الادارية',
    'محطة R1 ',
    'محطة 16 العاصمة الادارية ',
    'محطة R2 ',
    'محطة 17 العاصمة الادارية ',
    'محطة 18 العاصمة الادارية',
    'محطة R3 ',
    'محطة الفنون والثقافة',
    'محطة مسجد مصر',
    'محطة مدينة العدالة',
    'محطة مسجد مصر',
    'محطة الفنون والثقافة',
    'محطة R3',
    'محطة 18 العاصمة الادارية',
    'محطة 17 العاصمة الادارية',
    'محطة R2',
    'محطة 16 العاصمة الادارية',
    'محطة R1',
    'محطة 15 العاصمة الادارية',
    'محطة الدائري الاوسطي',
  ];
  @override
  void initState() {
    super.initState();
    _controllerCompleter = Completer();
    _markers = [];
    _locations = [
      LatLng(30.022456, 31.592192), // الفتاح العليم
      LatLng(30.022456, 31.592192), // الفتاح العليم
      LatLng(30.020094, 31.594575), // الدائري الاوسطي
      LatLng(30.019805, 31.620968), // 15 العاصمة الادارية
      LatLng(30.016955, 31.631245), // R1
      LatLng(30.015981, 31.642573), // 16 العاصمة الادارية
      LatLng(30.018207, 31.663139), // R2
      LatLng(30.018370, 31.664853), // 17 العاصمة الادارية
      LatLng(30.017848, 31.687893), // 18 العاصمة الادارية
      LatLng(30.017371, 31.688848), // R3
      LatLng(30.007987, 31.725368), // الفنون والثقافة
      LatLng(29.995158, 31.750237), // مسجد مصر
      LatLng(30.005821, 31.770911), // مدينة العدالة
      LatLng(29.995158, 31.750237), // مسجد مصر
      LatLng(30.007987, 31.725368), // الفنون والثقافة
      LatLng(30.017371, 31.688848), // R3
      LatLng(30.017848, 31.687893), // 18 العاصمة الادارية
      LatLng(30.018370, 31.664853), // 17 العاصمة الادارية
      LatLng(30.018207, 31.663139), // R2
      LatLng(30.015981, 31.642573), // 16 العاصمة الادارية
      LatLng(30.016955, 31.631245), // R1
      LatLng(30.019805, 31.620968), // 15 العاصمة الادارية
      LatLng(30.020094, 31.594575), // الدائري الاوسطي
      LatLng(30.022456, 31.592192), // الفتاح العليم
    ];
    _stations = [
      LatLng(30.022456, 31.592192), // الفتاح العليم
      LatLng(30.020094, 31.594575), // الدائري الاوسطي
      LatLng(30.019805, 31.620968), // 15 العاصمة الادارية
      LatLng(30.016955, 31.631245), // R1
      LatLng(30.015981, 31.642573), // 16 العاصمة الادارية
      LatLng(30.018207, 31.663139), // R2
      LatLng(30.018370, 31.664853), // 17 العاصمة الادارية
      LatLng(30.017848, 31.687893), // 18 العاصمة الادارية
      LatLng(30.017371, 31.688848), // R3
      LatLng(30.007987, 31.725368), // الفنون والثقافة
      LatLng(29.995158, 31.750237), // مسجد مصر
      LatLng(30.005821, 31.770911), // مدينة العدالة
    ];
    _currentLocationIndex = 0;
    // Add a marker for each location in the _locations array
    for (var i = 0; i < _stations.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: _stations[i],
        infoWindow:
            InfoWindow(title: mapNameStation[i], snippet: 'معلومات قريبا'),
        // Add other properties like icon, info window, etc.
      ));
    }
    _subscribeToWaitingField();
    _subscribeToSpeedMonorailField();
    _moveMarker(speedMono);
  }

  @override
  void dispose() {
    _cancelWaitingFieldSubscription();
    _cancelSpeedSubscription();
    super.dispose();
  }

  void _subscribeToWaitingField() {
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream = FirebaseFirestore
        .instance
        .collection('Cells')
        .doc('1ErdvkqP7nRhxpMU97rX')
        .snapshots();

    stream.listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists) {
        int waiting = snapshot.get('Waiting');
        setState(() {
          _waitTime = waiting; // Update the wait time with the retrieved value
        });
        print('Waiting value: $waiting');
      } else {
        print('Document does not exist');
      }
    }, onError: (dynamic error) {
      print('Error retrieving document: $error');
    });
  }

  void _cancelWaitingFieldSubscription() {
    // Cancel the subscription to stop listening for updates
    // This is important to avoid memory leaks
    // Call this method when the widget is being disposed of
  }
  void _subscribeToSpeedMonorailField() {
    Stream<DocumentSnapshot<Map<String, dynamic>>> stream =
        FirebaseFirestore.instance.collection('Cells').doc('Speed').snapshots();

    _speedSubscription =
        stream.listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists) {
        double speed = snapshot.get('SpeedMonorail');
        setState(() {
          speedMono =
              speed; // Update the monorail speed with the retrieved value
        });
        print('SpeedMonorail value: $speed');
      } else {
        print('Document does not exist');
      }
    }, onError: (dynamic error) {
      print('Error retrieving document: $error');
    });
  }

  void _cancelSpeedSubscription() {
    _speedSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                'Current Location Is:',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                mapNameStation2[_currentStationIndex],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(255, 13, 117, 0.5),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 85, 104, 114),
                Color.fromARGB(255, 111, 145, 161),
              ],
            ),
          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _locations[0],
          zoom: 13.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controllerCompleter.complete(controller);
          _googleMapController = controller;
        },

        markers: Set.from(_markers),
        // ignore: prefer_collection_literals
        polylines: Set.from([
          Polyline(
            polylineId: PolylineId("monorailLine"),
            color: _lineColor,
            width: _lineWidth,
            points: _locations,
          )
        ]),
      ),
    );
  }

  void _moveMarker(double speed) async {
    final currentLocation = _locations[_currentLocationIndex];
    final nextLocation = _locations[_currentLocationIndex + 1];

    // Calculate the distance between the current and next location in meters
    final distance = Geolocator.distanceBetween(
      currentLocation.latitude,
      currentLocation.longitude,
      nextLocation.latitude,
      nextLocation.longitude,
    );

    // Calculate the duration based on the distance and speed
    final duration = (distance / (speed * 1000)).round();

    final BitmapDescriptor defaultMarkerIcon =
        await BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)),
            'assets/images/monorail3.png');

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
    );

    _animationController.addListener(() async {
      final percent = _animationController.value;
      final lat =
          lerpDouble(currentLocation.latitude, nextLocation.latitude, percent)!;
      final lng = lerpDouble(
          currentLocation.longitude, nextLocation.longitude, percent)!;

      final newPosition = LatLng(lat, lng);

      BitmapDescriptor markerIcon = defaultMarkerIcon;

      setState(() {
        _markers
            .removeWhere((marker) => marker.markerId.value == "monorailMarker");
        _markers.add(
          Marker(
            markerId: MarkerId("monorailMarker"),
            position: newPosition,
            icon: markerIcon,
            rotation: getMarkerRotation(currentLocation, nextLocation),
            infoWindow: InfoWindow(
              title: 'Monorail 1',
            ),
          ),
        );
      });

      // Animate the camera to the new position
      final cameraUpdate = CameraUpdate.newLatLng(newPosition);
      await _googleMapController?.animateCamera(cameraUpdate);
    });

    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        // Move to the next location
        _currentLocationIndex++;

        // If we're at the last location, reset the index to 0
        if (_currentLocationIndex == _locations.length - 1) {
          _currentLocationIndex = 0;
        }

        _currentStationIndex = _currentLocationIndex;

        // If we're at the last location, reset the index to 0
        if (_currentLocationIndex == _locations.length - 1) {
          _currentLocationIndex = 0;
        }
        // Wait for the specified time
        await Future.delayed(Duration(seconds: _waitTime));

        // Start moving to the next location
        _moveMarker(speedMono);
      }
    });

    _animationController.forward();
  }

  double getMarkerRotation(LatLng start, LatLng end) {
    final rotation = Geolocator.bearingBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
    return rotation;
  }
}
