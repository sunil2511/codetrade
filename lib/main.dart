import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/screens/constant.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    NavigateMainScreen();
    Firebase.initializeApp().whenComplete(() {
      print("App Is Created");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/images/wallpaers2.jpg',
          ),
          fit: BoxFit.cover,
        )),
      ),
    );
  }

  Future<void> NavigateMainScreen() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    IsLogin = _sharedPreferences.getBool('IsLogin') ?? false;

    if (IsLogin) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(eUserName, ePassword))));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen())));
    }
  }
}
