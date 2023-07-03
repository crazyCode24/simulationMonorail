import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class cairoM2go extends StatefulWidget {
  const cairoM2go({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<cairoM2go> {
  late Stream<QuerySnapshot> _trainsStream;

  @override
  void initState() {
    super.initState();
    _trainsStream =
        FirebaseFirestore.instance.collection('cairoM2go').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 20), // Set the desired height for the padding
        child: Container(
          padding: EdgeInsets.fromLTRB(
              16, 20, 16, 0), // Set the desired padding values
          child: AppBar(
            backgroundColor: Color.fromRGBO(96, 125, 139, 1),
            title: Text('Go > monorail 2 (Modify)'),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _trainsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> documents = snapshot.data!.docs;

                return SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              child: Text('Add New Monorail'),
                              onPressed: () {
                                _addData(context);
                              },
                            ),
                            SizedBox(height: 16.0),
                            Center(
                                child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text('Mono-No.')),
                                  DataColumn(label: Text('Start Station')),
                                  DataColumn(label: Text('Start Time')),
                                  DataColumn(label: Text('Arrival Station')),
                                  DataColumn(label: Text('Arrival Time')),
                                  DataColumn(label: Text('Actions')),
                                  DataColumn(label: Text('Delete')),
                                ],
                                dataRowHeight: 50, // Set the height of the rows
                                headingRowHeight:
                                    50, // Set the height of the header
                                columnSpacing:
                                    10, // Set the spacing between columns
                                horizontalMargin:
                                    10, // Set the margin around the ta
                                rows: documents.map((document) {
                                  String monoNo = document['monoNo'];
                                  String startStation =
                                      document['startStation'];
                                  String startTime = document['startTime'];
                                  String arrivalStation =
                                      document['arrivalStation'];
                                  String arrivalTime = document['arrivalTime'];
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(monoNo)),
                                      DataCell(Text(startStation)),
                                      DataCell(Text(startTime)),
                                      DataCell(Text(arrivalStation)),
                                      DataCell(Text(arrivalTime)),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: () {
                                            // TODO: Implement edit cell functionality
                                            _editData(context, document);
                                          },
                                        ),
                                      ),
                                      DataCell(
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            // TODO: Implement edit cell functionality
                                            deleteData(context, document);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ))
                          ])),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addData(BuildContext context) async {
    // Show a dialog to get the data of the new row
    String? monoNo, startStation, startTime, arrivalStation, arrivalTime;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Data'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mono-No.'),
                  onChanged: (value) {
                    monoNo = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Start Station'),
                  onChanged: (value) {
                    startStation = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Start Time'),
                  onChanged: (value) {
                    startTime = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Arrival Station'),
                  onChanged: (value) {
                    arrivalStation = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Arrival Time'),
                  onChanged: (value) {
                    arrivalTime = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () async {
                // Create a new document in the "Schedule" collection
                await FirebaseFirestore.instance.collection('cairoM2go').add({
                  'monoNo': monoNo,
                  'startStation': startStation,
                  'startTime': startTime,
                  'arrivalStation': arrivalStation,
                  'arrivalTime': arrivalTime,
                });
                // Refresh the list of data
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editData(BuildContext context, DocumentSnapshot document) async {
    // Show a dialog to edit the data of the row
    String? monoNo = document['monoNo'];
    String? startStation = document['startStation'];
    String? startTime = document['startTime'];
    String? arrivalStation = document['arrivalStation'];
    String? arrivalTime = document['arrivalTime'];
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Data'),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    initialValue: monoNo,
                    decoration: InputDecoration(labelText: 'Mono-No.'),
                    onChanged: (value) {
                      monoNo = value;
                    },
                  ),
                  TextFormField(
                    initialValue: startStation,
                    decoration: InputDecoration(labelText: 'Start Station'),
                    onChanged: (value) {
                      startStation = value;
                    },
                  ),
                  TextFormField(
                    initialValue: startTime,
                    decoration: InputDecoration(labelText: 'Start Time'),
                    onChanged: (value) {
                      startTime = value;
                    },
                  ),
                  TextFormField(
                    initialValue: arrivalStation,
                    decoration: InputDecoration(labelText: 'Arrival Station'),
                    onChanged: (value) {
                      arrivalStation = value;
                    },
                  ),
                  TextFormField(
                    initialValue: arrivalTime,
                    decoration: InputDecoration(labelText: 'Arrival Time'),
                    onChanged: (value) {
                      arrivalTime = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Store the updated values in local variables
                String? updatedMonoNo = monoNo;
                String? updatedStartStation = startStation;
                String? updatedStartTime = startTime;
                String? updatedArrivalStation = arrivalStation;
                String? updatedArrivalTime = arrivalTime;

                // Update the data in Firestore with the updated values
                FirebaseFirestore.instance
                    .collection("cairoM2go")
                    .doc(document.id)
                    .update({
                  'monoNo': updatedMonoNo,
                  'startStation': updatedStartStation,
                  'startTime': updatedStartTime,
                  'arrivalStation': updatedArrivalStation,
                  'arrivalTime': updatedArrivalTime,
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteData(BuildContext context, DocumentSnapshot document) async {
    // Show a confirmation dialog before deleting the document
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Train'),
          content: Text('Are you sure you want to delete this train?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      // Delete the document from the "Trains" collection
      await FirebaseFirestore.instance
          .collection('cairoM2go')
          .doc(document.id)
          .delete();

      // Refresh the list of trains
      setState(() {});
    }
  }
}
