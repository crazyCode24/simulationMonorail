import 'package:flutter/material.dart';

class MonorailTicketPage extends StatelessWidget {
  const MonorailTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bgTrips.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Monorail Going Trips',
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.0),
              buildTicketCard(
                context,
                'First Trip M1',
                'Start from October',
                'Start Time 9:00',
              ),
              SizedBox(height: 20.0),
              buildTicketCard(
                context,
                'Second Trip M1',
                'Start from October',
                'Start Time 10:00',
              ),
              SizedBox(height: 20.0),
              buildTicketCard(
                context,
                'Third Trip M1',
                'Start from October',
                'Start Time 11:00',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTicketCard(
    BuildContext context,
    String title,
    String subtitle,
    String price,
  ) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Color.fromARGB(255, 4, 52, 75),
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
                  onPressed: () {},
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
                        Color.fromARGB(255, 74, 138, 186).withOpacity(0.5),
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
