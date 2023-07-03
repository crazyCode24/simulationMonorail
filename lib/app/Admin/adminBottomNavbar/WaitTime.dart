import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../mapFolder/mapOctober1.dart';

class WaitingStation extends StatefulWidget {
  const WaitingStation({Key? key}) : super(key: key);

  @override
  _WaitingStationState createState() => _WaitingStationState();
}

class _WaitingStationState extends State<WaitingStation> {
  final DocumentReference _cellRef = FirebaseFirestore.instance
      .collection('Cells')
      .doc('1ErdvkqP7nRhxpMU97rX');
  final TextEditingController _waitTimeController = TextEditingController();

  @override
  void dispose() {
    _waitTimeController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(35, 70, 95, 1),
        title: Text('Control of Waiting Station Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _waitTimeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Wait Time',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                int newWaitTime = int.parse(_waitTimeController.text);
                _cellRef.update({'Waiting': newWaitTime});
              },
              child: Text(
                'Update Wait Time',
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
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
                int currentWaitTime = snapshot.data!['Waiting'];
                return Column(
                  children: [
                    Text(
                      'Current Wait Time:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      '$currentWaitTime Sec',
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: _showMap,
              child: Text(
                'Show Modification On Map',
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
