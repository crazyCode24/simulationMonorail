import 'package:flutter/material.dart';

import '../appointmentFolder/monoLayoutCairoTables/MonoCairoInfo1.dart';
import '../appointmentFolder/monoLayoutCairoTables/MonoCairoInfo2.dart';

class cairoMovementUi extends StatefulWidget {
  const cairoMovementUi({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<cairoMovementUi> {
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
                      SizedBox(height: 20),
                      _buildMap(),
                      SizedBox(height: 20),
                      _buildPurchaseButton(),
                      SizedBox(height: 20),
                      _buildPathwayButtons(),
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
          color: Color.fromARGB(255, 255, 255, 255),
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            'Cairo Pathway',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          centerTitle: true,
          background: Container(
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
      );
  Widget _buildPathwayButtons() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            AnimatedOpacity(
              duration: Duration(seconds: 1),
              opacity: _selectedPathwayIndex == 0 ? 1.0 : 0.0,
              child: Text(
                'Please Choose Your Travel',
                style: TextStyle(
                  fontFamily: 'Fantasy',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 2,
                  color: Color.fromARGB(255, 86, 85, 85),
                ),
              ),
            ),
            SizedBox(height: 40),
            _buildPathwayButton(
              icon: Icons.train,
              title: 'Monorail 1',
              subtitle: 'Travel from A to B',
              index: 1,
              isSelected: _selectedPathwayIndex == 1,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        monoCairoInfo1(),
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
            SizedBox(height: 20),
            _buildPathwayButton(
              icon: Icons.train,
              title: 'Monorail 2',
              subtitle: 'Travel from B to A',
              index: 2,
              isSelected: _selectedPathwayIndex == 2,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        monoCairoInfo2(),
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
      );

  Widget _buildPathwayButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) =>
      AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        width: isSelected ? 300 : 250,
        height: isSelected ? 120 : 100,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueGrey[600] : Colors.blueGrey[200],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.blueGrey[800],
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.white : Colors.blueGrey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildMap() => Container(
        height: 180,
        width: 300,
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage('assets/images/image3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(),
      );

  Widget _buildPurchaseButton() => ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return MonorailStationDialog(stationNames: [
                'محطة الاستاد',
                'محطة الطيران',
                ' محطة نوري الخطاب',
                'محطة ذاكر حسين',
                'محطة جيهان السادات',
                'محطة المشير طنطاوي',
                'محطة المستشفي الجوي',
                'محطة النرجس',
                'محطة الجامعة الامريكية',
                'محطة الاندلس',
                'محطة النافورة',
                'محطة الربوة'
              ]);
            },
          );
        },
        child: Text(
          'Show Stations Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 63, 97, 114),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        ),
      );
}

class MonorailStationDialog extends StatelessWidget {
  final List<String> stationNames;

  const MonorailStationDialog({Key? key, required this.stationNames})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 400,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pathway Satations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: stationNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      stationNames[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
