import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 28.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
        title: Text('Frequently Asked Questions. '),
        backgroundColor: Color.fromRGBO(254, 254, 254, 0.494),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 7, 48, 95),
                Color.fromARGB(255, 19, 70, 92),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('FAQs').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(
                    255, 19, 20, 20)), // Set the progress indicator color
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final document = snapshot.data!.docs[index];
              final question = document['question'];
              final answer = document['answer'];

              return Card(
                color: Color.fromARGB(
                    255, 255, 255, 255), // Set the card background color
                margin: EdgeInsets.all(10.0),
                child: ExpansionTile(
                  title: Text(
                    question,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Color.fromARGB(
                          255, 43, 45, 45), // Set the question text color
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        answer,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.black87, // Set the answer text color
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
