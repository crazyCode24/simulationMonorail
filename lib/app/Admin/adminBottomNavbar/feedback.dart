import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackAdmin extends StatefulWidget {
  @override
  _FeedbackAdminState createState() => _FeedbackAdminState();
}

class _FeedbackAdminState extends State<FeedbackAdmin> {
  List<QueryDocumentSnapshot> feedbackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(35, 70, 95, 1),
        title: Text('Feedback!'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('feedback').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.size == 0) {
            return Center(
              child: Text('No feedback available.'),
            );
          }

          feedbackList = snapshot.data!.docs; // Update the feedbackList

          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: snapshot.data!.size,
            itemBuilder: (BuildContext context, int index) {
              var feedback = snapshot.data!.docs[index];
              var feedbackId = feedback.id;
              var firstName = feedback['firstName'];
              var lastName = feedback['lastName'];
              var phoneNumber = feedback['phoneNumber'];
              var email = feedback['feedback'];

              return Dismissible(
                key: Key(feedbackId),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  _deleteFeedback(context, feedbackId); // Delete the feedback
                  setState(() {
                    feedbackList
                        .remove(feedback); // Remove the feedback from the list
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '$firstName $lastName',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Phone Number:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          phoneNumber,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Feedback:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _deleteFeedback(BuildContext context, String feedbackId) {
    FirebaseFirestore.instance.collection('feedback').doc(feedbackId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Feedback deleted')),
    );
  }
}
