// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:math';

// import '../app/homeScreen/mainNavBar.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String captcha = "";
//   TextEditingController textEditingController = TextEditingController();
//   bool showErrorMessage = false;

//   @override
//   void initState() {
//     super.initState();
//     generateCaptcha();
//   }

//   void generateCaptcha() {
//     String digits = '0123456789';
//     String alpha = 'abcdefghijklmnopqrstuvwxyz';
//     String chars = digits + alpha;

//     captcha = '';
//     for (int i = 0; i < 6; i++) {
//       int index = Random().nextInt(chars.length);
//       captcha += chars[index];
//     }
//   }

//   void validateCaptcha() {
//     setState(() {
//       showErrorMessage = true;
//       if (textEditingController.text == captcha) {
//         showErrorMessage = false;
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) => mainNavBar(),
//           ),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Enter the captcha below:',
//               style: TextStyle(fontSize: 22),
//             ),
//             SizedBox(height: 20),
//             Text(
//               captcha,
//               style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 30),
//             TextFormField(
//               controller: textEditingController,
//               decoration: InputDecoration(
//                 labelText: 'Enter Captcha',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: validateCaptcha,
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.blueGrey[900],
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               ),
//               child: Text('Submit', style: TextStyle(fontSize: 16)),
//             ),
//             if (showErrorMessage && textEditingController.text != captcha)
//               SizedBox(height: 20),
//             Text(
//               'Wrong, please try again.',
//               style: TextStyle(color: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         backgroundColor: Colors.blueGrey[900],
//       ),
//       body: Center(
//         child: Text('Welcome to the Home Page!'),
//       ),
//     );
//   }
// }
