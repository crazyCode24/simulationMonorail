// ignore: file_names
import 'package:flutter/material.dart';
import 'package:monorail/app/mapFolder/mapCapital2.dart';

import 'Back_Trips_M2/octoberM2back.dart';
import 'Going_Trips_M2/octoberM2go.dart';

class monoCapitalInfo2 extends StatefulWidget {
  const monoCapitalInfo2({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<monoCapitalInfo2> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    GoingTripsM2NC(),
    BackTripsM2NC(),
    MonoCapitalMap2()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0.0,
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.schedule),
                    Text(
                      'Going',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.schedule),
                    Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.map),
                    Text(
                      'Map',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
