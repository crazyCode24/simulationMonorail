// ignore: file_names
import 'package:flutter/material.dart';

import 'adminBottomNavbar/FAQsModify.dart';
import 'adminBottomNavbar/MainTables.dart';
import 'adminBottomNavbar/WaitTime.dart';
import 'adminBottomNavbar/feedback.dart';
import 'adminBottomNavbar/speedMono.dart';

class mainAdoNavBar extends StatefulWidget {
  const mainAdoNavBar({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<mainAdoNavBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    mainTables(),
    WaitingStation(),
    speedMono5(),
    FeedbackAdmin(),
    AdminPageFAQs()
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
                    Icon(Icons.cancel_schedule_send),
                    Text(
                      'Tables',
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
                    Icon(Icons.watch_outlined),
                    Text(
                      'Waiting',
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
                    Icon(Icons.speed),
                    Text(
                      'Speed',
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
                    Icon(Icons.feedback),
                    Text(
                      'Feedback',
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
                    Icon(Icons.question_answer),
                    Text(
                      'FAQs',
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
