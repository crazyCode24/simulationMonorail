import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animarker/flutter_map_marker_animation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_animarker/widgets/animarker.dart';

const kStartPosition = LatLng(29.895544, 30.846418);
const kSantoDomingo = CameraPosition(target: kStartPosition, zoom: 14);
const kMarkerId = MarkerId('MarkerId1');
const kDuration = Duration(seconds: 5);
const kLocations = [
  kStartPosition,
  // LatLng(29.895544, 30.846418), //اكتوبر الجديدة
  LatLng(29.950889, 30.884055), // جامعة الاهرام الكنديه
  LatLng(29.950889, 30.884055), // جامعة الاهرام الكنديه
  LatLng(29.969115, 30.925945), // السادات
  LatLng(29.969115, 30.925945), // السادات
  LatLng(29.986376, 30.939979), // جهاز مدينة 6 اكتوبر
  LatLng(29.986376, 30.939979), // جهاز مدينة 6 اكتوبر
  LatLng(30.003930, 30.966645), // نقابة المهندسين
  LatLng(30.003930, 30.966645), // نقابة المهندسين
  LatLng(30.014908, 30.987114), // جامعة النيل
  LatLng(30.014908, 30.987114), // جامعة النيل
  LatLng(30.031686, 31.020052), // هايبر
  LatLng(30.031686, 31.020052), // هايبر
  LatLng(30.052362, 31.054038), // اسكندريه الصحراوي
  LatLng(30.052362, 31.054038), // اسكندريه الصحراوي
  LatLng(30.068489, 31.099036), // المنصورية
  LatLng(30.068489, 31.099036), // المنصورية
  LatLng(30.065699, 31.169441), // الطريق الدائري
  LatLng(30.065699, 31.169441), // الطريق الدائري
  LatLng(30.062082, 31.187875), // بشتيل
  LatLng(30.062082, 31.187875), // بشتيل
  LatLng(30.066374, 31.199780), // c
  LatLng(30.066374, 31.199780), // وادي النيل
  LatLng(30.076777, 31.317115), // الاستاد
  LatLng(30.076777, 31.317115), // الاستاد
  LatLng(30.068231, 31.321991), // الطيران
  LatLng(30.068231, 31.321991), // الطيران
  LatLng(30.057637, 31.323722), // نوري الخطاب
  LatLng(30.057637, 31.323722), // نوري الخطاب
  LatLng(30.050206, 31.346661), // ذاكر حسين
  LatLng(30.050206, 31.346661), // ذاكر حسين
  LatLng(30.043498, 31.355343), // جيهان السادات
  LatLng(30.043498, 31.355343), // جيهان السادات
  LatLng(30.023589, 31.383432), // المشير طنطاوي
  LatLng(30.023589, 31.383432), // المشير طنطاوي
  LatLng(30.015534, 31.434041), // المستشفي الجوي
  LatLng(30.015534, 31.434041), // المستشفي الجوي
  LatLng(30.025491, 31.459194), // النرجس
  LatLng(30.025491, 31.459194), // النرجس
  LatLng(30.025679, 31.490731), // الجامعة الامريكية
  LatLng(30.025679, 31.490731), // الجامعة الامريكية
  LatLng(30.013807, 31.519947), // الاندلس
  LatLng(30.013807, 31.519947), // الاندلس
  LatLng(30.026915, 31.533201), // النافورة
  LatLng(30.026915, 31.533201), // النافورة
  LatLng(30.026848, 31.560483), // الربوة
  LatLng(30.026848, 31.560483), // الربوة
  LatLng(30.022456, 31.592192), // الفتاح العليم
  LatLng(30.022456, 31.592192), // الفتاح العليم
  LatLng(30.020094, 31.594575), // الدائري الاوسطي
  LatLng(30.020094, 31.594575), // الدائري الاوسطي
  LatLng(30.019805, 31.620968), // 15 العاصمة الادارية
  LatLng(30.019805, 31.620968), // 15 العاصمة الادارية
  LatLng(30.016955, 31.631245), // R1
  LatLng(30.016955, 31.631245), // R1
  LatLng(30.015981, 31.642573), // 16 العاصمة الادارية
  LatLng(30.015981, 31.642573), // 16 العاصمة الادارية
  LatLng(30.018207, 31.663139), // R2
  LatLng(30.018207, 31.663139), // R2
  LatLng(30.018370, 31.664853), // 17 العاصمة الادارية
  LatLng(30.018370, 31.664853), // 17 العاصمة الادارية
  LatLng(30.017848, 31.687893), // 18 العاصمة الادارية
  LatLng(30.017848, 31.687893), // 18 العاصمة الادارية
  LatLng(30.017371, 31.688848), // R3
  LatLng(30.017371, 31.688848), // R3
  LatLng(30.007987, 31.725368), // الفنون والثقافة
  LatLng(30.007987, 31.725368), // الفنون والثقافة
  LatLng(29.995158, 31.750237), // مسجد مصر
  LatLng(29.995158, 31.750237), // مسجد مصر
  LatLng(30.005821, 31.770911), // مدينة العدالة
  LatLng(30.005821, 31.770911), // مدينة العدالة
  LatLng(30.066374, 31.199780), //امعة النيل
];

class SimpleMarkerAnimationExample extends StatefulWidget {
  const SimpleMarkerAnimationExample({super.key});
  @override
  SimpleMarkerAnimationExampleState createState() =>
      SimpleMarkerAnimationExampleState();
}

late BitmapDescriptor customMarker;
late BitmapDescriptor customMarker2;
getCustomMarker() async {
  customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/images/animate.png');
  customMarker2 = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty, 'assets/images/animate2.png');
}
// var myMarkers = HashSet<Marker>();

List<Marker> markerr = [];
// ignore: unused_element, prefer_const_declarations
final List<Marker> list = const [
  Marker(
    markerId: MarkerId('1'),
    position: LatLng(29.895544, 30.846418),
    infoWindow:
        InfoWindow(title: 'محطة اكتوبر الجديدة', snippet: ' معلومات قريبا'),
  ),
  Marker(
    markerId: MarkerId('2'),
    position: LatLng(29.950889, 30.884055),
    infoWindow: InfoWindow(
        title: 'محطة جامعة الاهرام الكنديه', snippet: 'معلومات قريبا'),
    // icon: await getMarkerIcon() ,
  ),
  Marker(
    markerId: MarkerId('3'),
    position: LatLng(29.969115, 30.925945),
    infoWindow: InfoWindow(title: 'محطة السادات', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('4'),
    position: LatLng(29.986376, 30.939979),
    infoWindow:
        InfoWindow(title: 'محطة جهاز مدينة 6 اكتوبر', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('5'),
    position: LatLng(30.003930, 30.966645),
    infoWindow:
        InfoWindow(title: 'محطة نقابة المهندسين', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('6'),
    position: LatLng(30.014908, 30.987114),
    infoWindow: InfoWindow(title: 'محطة جامعة النيل', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('7'),
    position: LatLng(30.031686, 31.020052),
    infoWindow: InfoWindow(title: 'محطة هايبر ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('8'),
    position: LatLng(30.052362, 31.054038),
    infoWindow: InfoWindow(
        title: 'محطة طريق اسكندريه الصحراوي ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('9'),
    position: LatLng(30.068489, 31.099036),
    infoWindow: InfoWindow(title: 'محطة المنصورية ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('10'),
    position: LatLng(30.065699, 31.169441),
    infoWindow:
        InfoWindow(title: 'محطة الطريق الدائري ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('11'),
    position: LatLng(30.062082, 31.187875),
    infoWindow: InfoWindow(title: 'محطة بشتيل', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('12'),
    position: LatLng(30.066374, 31.199780),
    infoWindow: InfoWindow(title: 'محطة وادي النيل ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('13'),
    position: LatLng(30.076777, 31.317115),
    infoWindow: InfoWindow(title: 'محطة الاستاد  ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('14'),
    position: LatLng(30.068231, 31.321991),
    infoWindow: InfoWindow(title: 'محطة الطيران  ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('15'),
    position: LatLng(30.057637, 31.323722),
    infoWindow:
        InfoWindow(title: 'محطة نوري الخطاب  ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('16'),
    position: LatLng(30.050206, 31.346661),
    infoWindow:
        InfoWindow(title: 'محطة ذاكر حسين   ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('17'),
    position: LatLng(30.043498, 31.355343),
    infoWindow:
        InfoWindow(title: 'محطة جيهان السادات   ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('18'),
    position: LatLng(30.023589, 31.383432),
    infoWindow:
        InfoWindow(title: 'محطة المشير طنطاوي   ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('19'),
    position: LatLng(30.015534, 31.434041),
    infoWindow:
        InfoWindow(title: 'محطة المستشفي الجوي    ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('20'),
    position: LatLng(30.025491, 31.459194),
    infoWindow: InfoWindow(title: 'محطة النرجس     ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('21'),
    position: LatLng(30.025679, 31.490731),
    infoWindow: InfoWindow(
        title: 'محطة الجامعة الامريكية     ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('22'),
    position: LatLng(30.013807, 31.519947),
    infoWindow:
        InfoWindow(title: 'محطة الاندلس     ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('23'),
    position: LatLng(30.026915, 31.533201),
    infoWindow:
        InfoWindow(title: 'محطة النافورة     ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('24'),
    position: LatLng(30.026848, 31.560483),
    infoWindow: InfoWindow(title: 'محطة الربوة     ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('25'),
    position: LatLng(30.022456, 31.592192),
    infoWindow:
        InfoWindow(title: 'محطة الفتاح العليم     ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('26'),
    position: LatLng(30.020094, 31.594575),
    infoWindow:
        InfoWindow(title: ' محطة الدائري الاوسطي ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('27'),
    position: LatLng(30.019805, 31.620968),
    infoWindow: InfoWindow(
        title: ' محطة 15 العاصمة الادارية  ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('28'),
    position: LatLng(30.016955, 31.631245),
    infoWindow: InfoWindow(title: ' محطة R1    ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('29'),
    position: LatLng(30.015981, 31.642573),
    infoWindow: InfoWindow(
        title: ' محطة 16 العاصمة الادارية    ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('30'),
    position: LatLng(30.018207, 31.663139),
    infoWindow: InfoWindow(title: ' محطة R2    ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('31'),
    position: LatLng(30.018207, 31.663139),
    infoWindow: InfoWindow(
        title: ' محطة 17 العاصمة الادارية    ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('32'),
    position: LatLng(30.017848, 31.687893),
    infoWindow: InfoWindow(
        title: ' محطة 18 العاصمة الادارية    ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('33'),
    position: LatLng(30.017371, 31.688848),
    infoWindow: InfoWindow(title: ' محطة R3      ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('34'),
    position: LatLng(30.007987, 31.725368),
    infoWindow: InfoWindow(
        title: ' محطة الفنون والثقافة      ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('35'),
    position: LatLng(29.995158, 31.750237),
    infoWindow: InfoWindow(title: ' محطة مسجد مصر ', snippet: 'معلومات قريبا'),
    // icon: customMarker,
  ),
  Marker(
    markerId: MarkerId('36'),
    position: LatLng(30.005821, 31.770911),
    infoWindow: InfoWindow(
        title: ' محطة مدينة العدالة       ', snippet: 'معلومات قريبا'),
  )
];

List<Polyline> myPolyLine = [];

createPolyLine() {
  myPolyLine.add(
    // ignore: prefer_const_constructors
    Polyline(
      polylineId: PolylineId('000'),
      color: Color.fromARGB(255, 9, 7, 7),
      width: 10,
      points: [
        LatLng(29.895544, 30.846418), //اكتوبر الجديدة
        LatLng(29.950889, 30.884055), // جامعة الاهرام الكنديه
        LatLng(29.969115, 30.925945), // السادات
        LatLng(29.986376, 30.939979), // جهاز مدينة 6 اكتوبر
        LatLng(30.003930, 30.966645), // نقابة المهندسين
        LatLng(30.014908, 30.987114), // جامعة النيل
        LatLng(30.031686, 31.020052), // هايبر
        LatLng(30.052362, 31.054038), // اسكندريه الصحراوي
        LatLng(30.068489, 31.099036), // المنصورية
        LatLng(30.065699, 31.169441), // الطريق الدائري
        LatLng(30.062082, 31.187875), // بشتيل
        LatLng(30.066374, 31.199780), // وادي النيل
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
        // LatLng(30.066374, 31.199780), //
      ],
      // patterns: [
      //   PatternItem.dash(20),
      //   PatternItem.gap(10)
      // ]
    ),
  );
}

class SimpleMarkerAnimationExampleState
    extends State<SimpleMarkerAnimationExample> {
  final markers = <MarkerId, Marker>{};
  final controller = Completer<GoogleMapController>();
  final stream = Stream.periodic(kDuration, (count) => kLocations[count])
      .take(kLocations.length);
  // final stream2 = Stream.periodic(kDuration, (count) => kLocations2[count])
  //     .take(kLocations.length);
// Collection

  @override
  void initState() {
    super.initState();
    markerr.addAll(list);
    createPolyLine();
    getCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Markers Animation Example',
      home: Animarker(
        curve: Curves.decelerate,
        rippleRadius: 0.2,
        useRotation: false,
        shouldAnimateCamera: true,
        duration: const Duration(milliseconds: 5000),
        mapId: controller.future
            .then<int>((value) => value.mapId), //Grab Google Map Id
        markers: markers.values.toSet(),
        child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: kSantoDomingo,
            polylines: myPolyLine.toSet(),
            markers: Set<Marker>.of(markerr),
            onMapCreated: (gController) {
              stream.forEach((value) => newLocationUpdate(value));
              // stream2.forEach((value) => newLocationUpdate(value));
              controller.complete(gController);
            }),
      ),
    );
  }

  int index = 0;
  void newLocationUpdate(LatLng latLng) async {
    var marker = RippleMarker(
        markerId: kMarkerId, position: latLng, icon: customMarker2);
    markers[kMarkerId] = marker;
    setState(() {
      markers[kMarkerId] = marker;
    });
  }
}
