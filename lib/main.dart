import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Common/Constant.dart';
import 'package:my_jini_adminapp/Screen/ApproveSociety.dart';
import 'package:my_jini_adminapp/Screen/CreateSociety.dart';
import 'package:my_jini_adminapp/Screen/Dashboard.dart';
import 'package:my_jini_adminapp/Screen/DirectoryScreen.dart';
import 'package:my_jini_adminapp/Screen/LoginScreen.dart';
import 'package:my_jini_adminapp/Screen/MySociety.dart';
import 'package:my_jini_adminapp/Screen/PreviewScreen.dart';
import 'package:my_jini_adminapp/Screen/RegistrationScreen.dart';
import 'package:my_jini_adminapp/Screen/Splashscreen.dart';

import 'Screen/SetupWings.dart';
import 'Screen/societyDownload.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyJini',
      initialRoute: '/',
      //navigatorKey: Get.key,
      routes: {
        // '/': (context) => ApproveSociety(),
        '/': (context) => Splashscreen(),
        '/LoginScreen': (context) => LoginScreen(),
        '/Dashboard': (context) => Dashboard(),
        '/PreviewScreen': (context) => PreviewScreen(),
        '/MySociety': (context) => MySociety(),
        '/SetupWings': (context) => SetupWings(),
        '/CreateSociety': (context) => CreateSociety(),
        '/RegistrationScreen': (context) => RegistrationScreen(),
      },
      theme: ThemeData(
        primarySwatch: appPrimaryMaterialColor,
        //accentColor: appPrimaryMaterialColor,
        // buttonColor: appPrimaryMaterialColor,
      ),
    );
  }
}
