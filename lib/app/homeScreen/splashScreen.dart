import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monorail/app/homeScreen/mainNavBar.dart';

class MonorailSplashScreen extends StatefulWidget {
  const MonorailSplashScreen({super.key});

  @override
  _MonorailSplashScreenState createState() => _MonorailSplashScreenState();
}

class _MonorailSplashScreenState extends State<MonorailSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _translateAnimation;
  String _monorailText = "Monorail";
  bool _showLoader = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3500),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 1.0, curve: Curves.ease),
      ),
    );
    _translateAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0.0, 1.0, curve: Curves.easeOut),
    ));
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        Future.delayed(Duration(milliseconds: 500), () {
          _animationController.duration = Duration(milliseconds: 1000);
          _animationController.forward();
        });
      }
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showLoader = true;
        });
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => MainNavBar(),
            ),
          );
        });
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(84, 110, 122, 1),
              Color.fromRGBO(66, 165, 245, 1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _buildWordAnimation(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 200.0),
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: Image.asset(
                    "assets/images/letter-m.png",
                    width: 128.0,
                    height: 128.0,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _showLoader,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 200.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordAnimation() {
    return _animationController.isCompleted
        ? FadeTransition(
            opacity: _opacityAnimation,
            child: Text(
              _monorailText,
              style: TextStyle(
                fontSize: 64.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _monorailText.length,
              (index) {
                return FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _translateAnimation,
                    child: Text(
                      _monorailText[index],
                      style: TextStyle(
                        fontSize: 64.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
