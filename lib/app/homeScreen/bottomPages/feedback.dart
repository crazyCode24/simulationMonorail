import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _submitFeedback() async {
    final String firstName = _firstNameController.text.trim();
    final String lastName = _lastNameController.text.trim();
    final String phoneNumber = _phoneNumberController.text.trim();
    final String feedbackText = _feedbackController.text.trim();

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        feedbackText.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('feedback').add({
          'firstName': firstName,
          'lastName': lastName,
          'phoneNumber': phoneNumber,
          'feedback': feedbackText,
          'timestamp': DateTime.now(),
        });

        // Show a success dialog or perform any other actions
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 80.0,
                      color: Colors.green,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Feedback Submitted!',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Thank you for your feedback!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        // Clear the input fields
        _firstNameController.clear();
        _lastNameController.clear();
        _phoneNumberController.clear();
        _feedbackController.clear();
      } catch (error) {
        print('Error submitting feedback: $error');
        // Handle the error
      }
    }
  }

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
        title: Text('Have Any Question?'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _feedbackController,
                decoration: InputDecoration(
                  labelText: 'Enter your feedback',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 5,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitFeedback,
                child: Text('Submit Feedback'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 86, 97, 114),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
