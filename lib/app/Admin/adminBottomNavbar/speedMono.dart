import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../mapFolder/mapOctober1.dart';

class speedMono5 extends StatefulWidget {
  const speedMono5({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<speedMono5> {
  final DocumentReference _cellRef =
      FirebaseFirestore.instance.collection('Cells').doc('Speed');
  final TextEditingController _speedController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(35, 70, 95, 1),
        title: Text('Control of spped of Monorail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _speedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Speed Mono',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                double newWaitTime = double.parse(_speedController.text);
                _cellRef.update({'SpeedMonorail': newWaitTime});
              },
              child: Text(
                'Update Monorail Speed ',
                style: TextStyle(fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 14, 68, 113),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            StreamBuilder<DocumentSnapshot>(
              stream: _cellRef.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                double currentWaitTime =
                    snapshot.data!['SpeedMonorail'] as double;
                return Text('Current Speed Mono: $currentWaitTime km/sec');
              },
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed:
                  _showMap, // Call _showMap method when button is pressed
              child: Text(
                'Show Modificication On Map',
                style: TextStyle(fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 36, 59, 78),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MonoOctoberMap1()),
    );
  }
}
