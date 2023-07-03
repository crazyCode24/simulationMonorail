import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPageFAQs extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPageFAQs> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<DocumentSnapshot> _faqs = []; // List to hold the FAQs
// Variable to track if the dialog is open

  @override
  void initState() {
    super.initState();
    _fetchFAQs(); // Fetch FAQs on page initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(35, 70, 95, 1),
        title: Text('FAQs Add & Modify!'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _openAddDialog,
              child: Text('Add New FAQ'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _faqs.length,
                itemBuilder: (context, index) {
                  final faq = _faqs[index];
                  final question = faq['question'];
                  final answer = faq['answer'];

                  return ListTile(
                    title: Text(question),
                    subtitle: Text(answer),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _openModifyDialog(faq),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteFAQ(faq),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchFAQs() async {
    final snapshot = await _firestore.collection('FAQs').get();
    setState(() {
      _faqs = snapshot.docs;
    });
  }

  void _openAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New FAQ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _questionController,
                decoration: InputDecoration(
                  labelText: 'Question',
                ),
              ),
              TextField(
                controller: _answerController,
                decoration: InputDecoration(
                  labelText: 'Answer',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _addFAQ();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _addFAQ() async {
    String question = _questionController.text.trim();
    String answer = _answerController.text.trim();

    await _firestore.collection('FAQs').add({
      'question': question,
      'answer': answer,
    });

    _questionController.clear();
    _answerController.clear();

    _fetchFAQs(); // Fetch FAQs again to update the list
  }

  void _openModifyDialog(DocumentSnapshot faq) {
    String question = faq['question'];
    String answer = faq['answer'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modify FAQ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: question),
                onChanged: (value) => question = value,
                decoration: InputDecoration(
                  labelText: 'Question',
                ),
              ),
              TextField(
                controller: TextEditingController(text: answer),
                onChanged: (value) => answer = value,
                decoration: InputDecoration(
                  labelText: 'Answer',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _updateFAQ(faq, question, answer);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _updateFAQ(DocumentSnapshot faq, String question, String answer) async {
    await faq.reference.update({
      'question': question,
      'answer': answer,
    });

    _fetchFAQs(); // Fetch FAQs again to update the list
  }

  void _deleteFAQ(DocumentSnapshot faq) async {
    await faq.reference.delete();

    _fetchFAQs(); // Fetch FAQs again to update the list
  }
}
