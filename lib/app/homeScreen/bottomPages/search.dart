import 'package:flutter/material.dart';
import 'package:monorail/app/appointmentFolder/monoLayoutCairoTables/MonoCairoInfo2.dart';
import 'package:monorail/app/appointmentFolder/monoLayoutCapitalTables/MonoCapitalInfo2.dart';
import 'package:monorail/app/appointmentFolder/monoLayoutOctoberTables/MonoOctoberInfo2.dart';
import 'package:monorail/app/mapFolder/mapCairo2.dart';
import 'package:monorail/app/mapFolder/mapCapital2.dart';
import 'package:monorail/app/mapFolder/mapOctober2.dart';

import '../../MovementLayouts/cairoMovement.dart';
import '../../MovementLayouts/capitalMovement.dart';
import '../../MovementLayouts/octoberMovement.dart';
import '../../appointmentFolder/monoLayoutCairoTables/MonoCairoInfo1.dart';
import '../../appointmentFolder/monoLayoutCapitalTables/MonoCapitalInfo1.dart';
import '../../appointmentFolder/monoLayoutOctoberTables/MonoOctoberInfo1.dart';
import '../../mapFolder/mapCairo1.dart';
import '../../mapFolder/mapCapital1.dart';
import '../../mapFolder/mapOctober1.dart';
import 'FAQs.dart';
import 'feedback.dart';

class SearchBarnav extends StatefulWidget {
  const SearchBarnav({Key? key}) : super(key: key);

  @override
  _SearchBarnavState createState() => _SearchBarnavState();
}

enum Pages {
  Home,
  SearchResult,
}

class _SearchBarnavState extends State<SearchBarnav> {
  String searchText = '';
  List<String> items = [
    'October Pathway',
    'Cairo Pathway',
    'Capital Pathway',
    'Monorail [1] October Travel',
    'Monorail [2] October Travel',
    'Monorail [1] Cairo Travel',
    'Monorail [2] Cairo Travel',
    'Monorail [1] Capital Travel',
    'Monorail [2] Capital Travel',
    'October Travel 1 Map',
    'Cairo Travel 1 Map',
    'Capital Travel 1 Map',
    'October Travel 2 Map',
    'Cairo Travel 2 Map',
    'Capital Travel 2 Map',
    'FAQs',
    'Send Feedback'
  ];
  List<String> searchResults = [];

  void search() {
    setState(() {
      searchResults = items
          .where(
              (item) => item.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void navigateToResultPage(String result) {
    switch (result) {
      case 'October Pathway':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => octoberMovementUi(),
          ),
        );
        break;
      case 'Cairo Pathway':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => cairoMovementUi(),
          ),
        );
        break;
      case 'Capital Pathway':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => capitalMovementUi(),
          ),
        );
        break;
      case 'Monorail [1] October Travel':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => monoOctoberInfo1(),
          ),
        );
        break;
      case 'Monorail [2] October Travel':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => monoOctoberInfo2(),
          ),
        );
        break;
      case 'Monorail [1] Cairo Travel':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => monoCairoInfo1(),
          ),
        );
        break;
      case 'Monorail [2] Cairo Travel':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => monoCairoInfo2(),
          ),
        );
        break;
      case 'Monorail [1] Capital Travel':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => monoCapitalInfo1(),
          ),
        );
        break;
      case 'Monorail [2] Capital Travel':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => monoCapitalInfo2(),
          ),
        );
        break;
      case 'October Travel 1 Map':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MonoOctoberMap1(),
          ),
        );
        break;
      case 'Cairo Travel 1 Map':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MonoCairoMap1(),
          ),
        );
        break;
      case 'Capital Travel 1 Map':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MonoCapitalMap1(),
          ),
        );
        break;
      case 'October Travel 2 Map':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MonoOctoberMap2(),
          ),
        );
        break;
      case 'Cairo Travel 2 Map':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MonoCairoMap2(),
          ),
        );
        break;
      case 'Capital Travel 2 Map':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MonoCapitalMap2(),
          ),
        );
        break;
      case 'FAQs':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FAQScreen(),
          ),
        );
        break;
      case 'Send Feedback':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeedbackScreen(),
          ),
        );
        break;
      // Add cases for other result options as needed
      default:
        // Handle cases other than Apple and Banana
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      home: Scaffold(
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
          title: Text('Find what you need '),
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
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                    if (searchText.isEmpty) {
                      searchResults.clear();
                    } else {
                      searchResults = items
                          .where((item) => item
                              .toLowerCase()
                              .contains(searchText.toLowerCase()))
                          .toList();
                    }
                  });
                },
                onSubmitted: (value) {
                  search();
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: search,
              child: Text('Search'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 63, 97, 114),
                textStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Search: $searchText',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8.0), // Add margin
                        // decoration: BoxDecoration(
                        //   color: Colors
                        //       .lightBlue, // Replace with your desired background color
                        //   borderRadius: BorderRadius.circular(
                        //       8.0), // Optional: Add border radius
                        // ),
                        child: ListTile(
                          title: Container(
                            padding: EdgeInsets.all(
                                8.0), // Optional: Add padding for text
                            child: Text(
                              searchResults[index],
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color.fromARGB(
                                    255, 16, 0, 0), // Optional: Set text color
                              ),
                            ),
                          ),
                          onTap: () {
                            navigateToResultPage(searchResults[index]);
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
