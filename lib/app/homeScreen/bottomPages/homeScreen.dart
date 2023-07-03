import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Admin/login.dart';
import '../../MovementLayouts/cairoMovement.dart';
import '../../MovementLayouts/capitalMovement.dart';
import '../../MovementLayouts/octoberMovement.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<homeScreen>
    with SingleTickerProviderStateMixin {
  final _imageList = ['image2.png', 'image1.png', 'image3.png', 'image4.png'];
  int _tapCount = 0;
  bool _isButtonVisible = false;
  var _selectedPathwayIndex = 0;
  List<String> _imageUrls = []; // Store the fetched image URLs
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  void initState() {
    super.initState();
    fetchImageUrls();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _animation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuint,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchImageUrls() async {
    final storage = FirebaseStorage.instance;
    for (final imageName in _imageList) {
      final ref = storage.ref().child('slider/$imageName');
      final url = await ref.getDownloadURL();
      setState(() {
        _imageUrls.add(url);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_isButtonVisible) {
            _isButtonVisible = false;
            _tapCount = 0;
          } else {
            _tapCount++;
            if (_tapCount == 3) {
              _isButtonVisible = true;
            }
          }
        });
      },
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
                      _buildCarouselSlider(),
                      _buildWelcomeText(),
                      SizedBox(height: 20),
                      _buildPathwayButtons(),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                      if (_isButtonVisible) _buildHiddenButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildSliverAppBar() => SliverAppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        floating: true,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.menu),
          onPressed: () => handleBurgerIconPress(),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/letter-m.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildWelcomeText() => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _animation,
            child: Opacity(
              opacity: _animationController.value,
              child: Text(
                'See maps',
                style: TextStyle(
                  fontFamily: 'Fantasy',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 6,
                  color: Color.fromARGB(255, 86, 85, 85),
                ),
              ),
            ),
          );
        },
      );

  Widget _buildPathwayButtons() => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _animation,
            child: Opacity(
              opacity: _animationController.value,
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
                        'Please Choose Your Pathway',
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
                      icon: Icons.train_outlined,
                      title: 'October Pathway',
                      subtitle: 'press to get full info.',
                      index: 1,
                      isSelected: _selectedPathwayIndex == 1,
                      onTap: () async {
                        try {
                          UserCredential userCredential =
                              await FirebaseAuth.instance.signInAnonymously();
                          if (userCredential.user != null) {
                            // Anonymous authentication successful, proceed to navigate to the next page
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        octoberMovementUi(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
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
                          } else {
                            // Something went wrong with anonymous authentication, handle accordingly
                            print('Anonymous authentication failed.');
                          }
                        } catch (e) {
                          // Handle any errors that may occur during anonymous authentication
                          print('Error during anonymous authentication: $e');
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    _buildPathwayButton(
                      icon: Icons.train_outlined,
                      title: 'Cairo Pathway',
                      subtitle: 'press to get full info.',
                      index: 1,
                      isSelected: _selectedPathwayIndex == 2,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    cairoMovementUi(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                      icon: Icons.train_outlined,
                      title: 'Capital Pathway',
                      subtitle: 'press to get full info.',
                      index: 1,
                      isSelected: _selectedPathwayIndex == 3,
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    capitalMovementUi(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
            ),
          );
        },
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

  void handleBurgerIconPress() {
    // TODO: Implement burger icon press handler
  }
  Widget _buildHiddenButton() => ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminLoginPage()),
        ),
        child: Text(
          'Admin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Color.fromARGB(255, 153, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        ),
      );

  Widget _buildCarouselSlider() => AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _animation,
            child: Opacity(
              opacity: _animationController.value,
              child: Container(
                height: 150,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 86, 85, 85),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: CarouselSlider.builder(
                  itemCount: _imageUrls.length,
                  itemBuilder: (context, index, realIndex) => Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: GestureDetector(
                        onTap: () => showImageDialog(context, realIndex),
                        child: CachedNetworkImage(
                          imageUrl: _imageUrls[realIndex],
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                  options: CarouselOptions(
                    height: 200,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    aspectRatio: 16 / 9,
                    autoPlayInterval: Duration(seconds: 3),
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) => setState(() {
                      _selectedPathwayIndex = index;
                    }),
                  ),
                ),
              ),
            ),
          );
        },
      );

  void showImageDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: InteractiveViewer(
          child: Image.asset(
            'assets/images/${_imageList[index]}',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class HiddenButtonWidget extends StatefulWidget {
  @override
  _HiddenButtonWidgetState createState() => _HiddenButtonWidgetState();
}

class _HiddenButtonWidgetState extends State<HiddenButtonWidget> {
  bool _buttonVisible = false;
  int _tapCount = 0;

  void _handleTap() {
    setState(() {
      _tapCount++;
      if (_tapCount == 3) {
        _buttonVisible = true;
      } else if (_tapCount == 4) {
        _buttonVisible = false;
        _tapCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            // Your other widgets can go here

            if (_buttonVisible)
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    // Button's onPressed logic goes here
                  },
                  child: Icon(Icons.add),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
