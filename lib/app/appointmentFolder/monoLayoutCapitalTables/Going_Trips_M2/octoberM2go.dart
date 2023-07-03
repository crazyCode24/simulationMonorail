import 'package:flutter/material.dart';

import 'Appointments/Trip1.dart';

class GoingTripsM2NC extends StatefulWidget {
  const GoingTripsM2NC({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<GoingTripsM2NC> {
  var _selectedPathwayIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _selectedPathwayIndex = 0),
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildPathwayTrips(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() => SliverAppBar(
        backgroundColor: Color.fromARGB(255, 239, 239, 239),
        elevation: 0.0,
        floating: true,
        leading: IconButton(
          color: Color.fromARGB(255, 0, 0, 0),
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Color.fromARGB(255, 0, 0, 0),
                size: 28.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            'Going Trips',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          centerTitle: true,
          background: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
            ),
          ),
        ),
      );
  Widget _buildPathwayTrips() => Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: _selectedPathwayIndex == 0 ? 1.0 : 0.0,
                child: Text(
                  'Please Choose Your Trip',
                  style: TextStyle(
                    fontFamily: 'Fantasy',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 2,
                    color: Color.fromARGB(255, 55, 53, 53),
                  ),
                ),
              ),
              SizedBox(height: 40),
              buildMonoTrip(
                context,
                '1st Trip ',
                'Start from El Adala City',
                'Start Time 9:00 AM',
                () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Trip1_go_capitalM2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              buildMonoTrip(
                context,
                '2nd Trip ',
                'Start from El Adala City',
                'Start Time 10:00 AM',
                () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Trip1_go_capitalM2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              buildMonoTrip(
                context,
                '3rd Trip ',
                'Start from El Adala City',
                'Start Time 11:00 AM',
                () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Trip1_go_capitalM2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              buildMonoTrip(
                context,
                '4th Trip ',
                'Start from El Adala City',
                'Start Time 12:00 PM',
                () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Trip1_go_capitalM2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              buildMonoTrip(
                context,
                '5th Trip ',
                'Start from El Adala City',
                'Start Time 1:00 PM',
                () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Trip1_go_capitalM2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 20.0),
              buildMonoTrip(
                context,
                '6th Trip ',
                'Start from El Adala City',
                'Start Time 2:00 PM',
                () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Trip1_go_capitalM2(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget buildMonoTrip(
    BuildContext context,
    String title,
    String subtitle,
    String price,
    VoidCallback onPressed,
  ) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Color.fromARGB(255, 4, 49, 72),
      shadowColor: Color.fromARGB(255, 2, 65, 92),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    'Get Full Info',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(16, 107, 182, 0.498),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    shadowColor:
                        Color.fromARGB(255, 9, 25, 37).withOpacity(0.5),
                    elevation: 8.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
