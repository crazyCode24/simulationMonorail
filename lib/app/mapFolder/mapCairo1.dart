import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MonoCairoMap1 extends StatefulWidget {
  const MonoCairoMap1({Key? key}) : super(key: key);

  @override
  _MonorailMapState createState() => _MonorailMapState();
}

class _MonorailMapState extends State<MonoCairoMap1>
    with TickerProviderStateMixin {
  late Completer<GoogleMapController> _controllerCompleter =
      Completer<GoogleMapController>();

  late List<Marker> _markers;
  late List<LatLng> _locations;
  late List<LatLng> _stations;
  late int _currentLocationIndex;
  late int _currentStationIndex = 0;

  late AnimationController _animationController;
  // final double _markerSize = 30.0;
  final int _lineWidth = 5;
  final Color _lineColor = Colors.blue;
  // final Color _markerColor = Colors.red;
  int _waitTime = 2;
  double speedMono = 3;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>?
      _speedSubscription;

  List<String> mapNameStation = [
    'محطة الاستاد',
    'محطة الطيران',
    ' محطة نوري الخطاب',
    'محطة ذاكر حسين',
    'محطة جيهان السادات',
    'محطة المشير طنطاوي',
    'محطة المستشفي الجوي',
    'محطة النرجس',
    'محطة الجامعة الامريكية',
    'محطة الاندلس',
    'محطة النافورة',
    'محطة الربوة'
  ];
  List<String> mapNameStation2 = [
    'محطة الاستاد',
    'محطة الاستاد',
    'محطة الطيران',
    ' محطة نوري الخطاب',
    'محطة ذاكر حسين',
    'محطة جيهان السادات',
    'محطة المشير طنطاوي',
    'محطة المستشفي الجوي',
    'محطة النرجس',
    'محطة الجامعة الامريكية',
    'محطة الاندلس',
    'محطة النافورة',
    'محطة الربوة',
    'محطة النافورة',
    'محطة الاندلس',
    'محطة الجامعة الامريكية',
    'محطة النرجس',
    'محطة المستشفي الجوي',
    'محطة المشير طنطاوي',
    'محطة جيهان السادات',
    'محطة ذاكر حسين',
    ' محطة نوري الخطاب',
    'محطة الطيران',
  ];

  GoogleMapController? _googleMapController;

  @override
  void initState() {
    super.initState();
    _controllerCompleter = Completer();
    _markers = [];
    _locations = [
      LatLng(30.076777, 31.317115), // الاستاد
      LatLng(30.076777, 31.317115), // الاستاد
      LatLng(30.068231, 31.321991), // الطيران
      LatLng(30.057637, 31.323722), // نوري الخطاب
      LatLng(30.050206, 31.346661), // ذاكر حسين
      LatLng(30.043498, 31.355343), // جيهان السادات
      LatLng(30.023589, 31.383432), // المشير طنطاوي
      LatLng(30.015534, 31.434041), // المستشفي الجوي
      LatLng(30.025491, 31.459194), // النرجس
      LatLng(30.025679, 31.490731), // الجامعة الامريكية
      LatLng(30.013807, 31.519947), // الاندلس
      LatLng(30.026915, 31.533201), // النافورة
      LatLng(30.026848, 31.560483), // الربوة
      LatLng(30.026915, 31.533201), // النافورة
      LatLng(30.013807, 31.519947), // الاندلس
      LatLng(30.025679, 31.490731), // الجامعة الامريكية
      LatLng(30.025491, 31.459194), // النرجس
      LatLng(30.015534, 31.434041), // المستشفي الجوي
      LatLng(30.023589, 31.383432), // المشير طنطاوي
      LatLng(30.043498, 31.355343), // جيهان السادات
      LatLng(30.050206, 31.346661), // ذاكر حسين
      LatLng(30.057637, 31.323722), // نوري الخطاب
      LatLng(30.068231, 31.321991), // الطيران
      LatLng(30.076777, 31.317115), // الاستاد
    ];
    _stations = [
      LatLng(30.076777, 31.317115), // الاستاد
      LatLng(30.068231, 31.321991), // الطيران
      LatLng(30.057637, 31.323722), // نوري الخطاب
      LatLng(30.050206, 31.346661), // ذاكر حسين
      LatLng(30.043498, 31.355343), // جيهان السادات
      LatLng(30.023589, 31.383432), // المشير طنطاوي
      LatLng(30.015534, 31.434041), // المستشفي الجوي
      LatLng(30.025491, 31.459194), // النرجس
      LatLng(30.025679, 31.490731), // الجامعة الامريكية
      LatLng(30.013807, 31.519947), // الاندلس
      LatLng(30.026915, 31.533201), // النافورة
      LatLng(30.026848, 31.560483), // الربوة
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

    Future<BitmapDescriptor> getDefaultMarkerIcon() async {
      return BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)),
        'assets/images/monorail3.png',
      );
    }

// Inside the _moveMarker function
    final BitmapDescriptor defaultMarkerIcon = await getDefaultMarkerIcon();

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
