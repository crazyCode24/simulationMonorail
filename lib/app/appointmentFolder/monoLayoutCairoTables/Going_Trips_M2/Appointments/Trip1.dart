import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Trip1_GoM2_cairo extends StatefulWidget {
  const Trip1_GoM2_cairo({Key? key}) : super(key: key);

  @override
  _MonorailScheduleState createState() => _MonorailScheduleState();
}

class _MonorailScheduleState extends State<Trip1_GoM2_cairo> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference _trainsCollection;

  @override
  void initState() {
    super.initState();
    _trainsCollection = _firestore.collection('cairoM2go');
  }

  List<String> _headers = [
    'Mono-No.',
    'Start Station',
    'Start Time',
    'End Station',
    'Arrival Time'
  ];

  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        iconTheme:
            IconThemeData(color: Colors.black), // Change icon color to black
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Add navigation functionality here
          },
        ),
        title: Text(
          'Going Schedule of the monorail 2',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _buildTable(),
            ),
          ],
        ),
      ),
    );
  }

  void _sortTable() {
    setState(() {
      _sortAscending = !_sortAscending;
    });
  }

  Widget _buildTable() {
    return StreamBuilder<QuerySnapshot>(
      stream: _trainsCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ),
            ),
          );
        }

        List<TableRow> rows = snapshot.data!.docs.map((doc) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          if (data == null) return TableRow(children: []);
          return TableRow(
            children: [
              _buildTableCell(data['monoNo']?.toString() ?? ''),
              _buildTableCell(data['startStation']?.toString() ?? ''),
              _buildTableCell(data['startTime']?.toString() ?? ''),
              _buildTableCell(data['arrivalStation']?.toString() ?? ''),
              _buildTableCell(data['arrivalTime']?.toString() ?? ''),
            ],
          );
        }).toList();

        return Table(
          border: TableBorder.all(width: 1, color: Colors.grey),
          columnWidths: {
            0: FractionColumnWidth(0.2),
            1: FractionColumnWidth(0.2),
            2: FractionColumnWidth(0.2),
            3: FractionColumnWidth(0.2),
            4: FractionColumnWidth(0.2),
          },
          children: [
            TableRow(
              children: _headers
                  .map((header) => Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                        ),
                        child: Text(
                          header,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            ...rows,
          ],
        );
      },
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
