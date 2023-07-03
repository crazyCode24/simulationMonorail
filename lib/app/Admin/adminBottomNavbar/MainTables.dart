import 'package:flutter/material.dart';
import 'package:monorail/app/Admin/adminBottomNavbar/TableModification/CapitalModification/capitalM1backM.dart';

import 'TableModification/CairoModification/cairoM1backM.dart';
import 'TableModification/CairoModification/cairoM1goM.dart';
import 'TableModification/CairoModification/cairoM2backM.dart';
import 'TableModification/CairoModification/cairoM2goM.dart';
import 'TableModification/CapitalModification/capitalM1goM.dart';
import 'TableModification/CapitalModification/capitalM2backM.dart';
import 'TableModification/CapitalModification/capitalM2goM.dart';
import 'TableModification/OctoberModification/octoberM1backM.dart';
import 'TableModification/OctoberModification/octoberM1goM.dart';
import 'TableModification/OctoberModification/octoberM2backM.dart';
import 'TableModification/OctoberModification/octoberM2goM.dart';
import 'WaitTime.dart';
import 'feedback.dart';
import 'speedMono.dart';

class mainTables extends StatefulWidget {
  mainTables({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<mainTables> {
  int _selectedIndex = 0;
  int _tableIndex = 0;

  static const List<Widget> _tableOptions = <Widget>[
    octoberM1goM(),
    octoberM1backM(),
    octoberM2goM(),
    octoberM2backM(),
    cairoM1go(),
    cairoM1back(),
    cairoM2go(),
    cairoM2back(),
    capitalM1go(),
    capitalM1back(),
    capitalM2go(),
    capitalM2back(),
  ];

  void _onTableItemTapped(int index) {
    setState(() {
      _tableIndex = index;
    });
  }

  void _onMainItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(35, 70, 95, 1),
        title: Text('Control of Table Appointment Time'),
      ),
      body: _selectedIndex == 0
          ? _tableOptions[_tableIndex]
          : _selectedIndex == 1
              ? WaitingStation()
              : _selectedIndex == 2
                  ? speedMono5()
                  : FeedbackAdmin(), // new case for feedback

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 36, 49, 60),
              ),
              child: Text(
                'Table Options',
                style: TextStyle(
                  color: Color.fromARGB(0, 91, 13, 13),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('october M1 go'),
              selected: _tableIndex == 0,
              onTap: () {
                _onTableItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('october M1 back'),
              selected: _tableIndex == 1,
              onTap: () {
                _onTableItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('october M2 go'),
              selected: _tableIndex == 2,
              onTap: () {
                _onTableItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('october M2 back'),
              selected: _tableIndex == 3,
              onTap: () {
                _onTableItemTapped(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('cairo M1 go'),
              selected: _tableIndex == 4,
              onTap: () {
                _onTableItemTapped(4);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('cairo M1 back'),
              selected: _tableIndex == 5,
              onTap: () {
                _onTableItemTapped(5);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('cairo M2 go'),
              selected: _tableIndex == 6,
              onTap: () {
                _onTableItemTapped(6);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('cairo M2 back'),
              selected: _tableIndex == 7,
              onTap: () {
                _onTableItemTapped(7);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('capital M1 go'),
              selected: _tableIndex == 8,
              onTap: () {
                _onTableItemTapped(8);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('capital M1 back'),
              selected: _tableIndex == 9,
              onTap: () {
                _onTableItemTapped(9);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('capital M2 go'),
              selected: _tableIndex == 10,
              onTap: () {
                _onTableItemTapped(10);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('capital M2 back'),
              selected: _tableIndex == 11,
              onTap: () {
                _onTableItemTapped(11);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
