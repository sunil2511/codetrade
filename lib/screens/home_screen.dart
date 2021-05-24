import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/screens/DataApi.dart';
import 'package:untitled1/screens/DataModel.dart';
import 'package:untitled1/screens/constant.dart';
import 'package:untitled1/screens/login_screen.dart';
import 'package:untitled1/screens/menu_drawer.dart';
import 'package:untitled1/screens/usersDetails.dart';

class HomeScreen extends StatefulWidget {
  var eUserName;
  var ePassword;

  HomeScreen(
    this.eUserName,
    this.ePassword, {
    Key key,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<ApiDataModel> opCodeModel;
  bool isLoading = true;
  String base;

  String date;

  int time;

  String tearm;

  String provider;

  Rates rates;
  @override
  void initState() {
    super.initState();
    getUserData().then((value) {
      if (value != null) {
        setState(() {
          base = value.base.toString();
          date = value.date.toString();
          time = value.timeLastUpdated;
          tearm = value.terms.toString();
          provider = value.provider.toString();
          rates = value.rates.toString() as Rates;
          print("sdwd" + date);
          print("s1" + time.toString());
          print("s2" + tearm.toString());
          print("s3" + provider.toString());
          print("s4" + rates.toString());
        });
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: menuDrawer(context),
      appBar: AppBar(
        title: Text("Home"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu_open_sharp),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          GestureDetector(
              onTap: () {
                SharedPreferences _sharedPreferences;
                SharedPreferences.getInstance().then((value) {
                  _sharedPreferences = value;
                  IsLogin = _sharedPreferences.getBool('IsLogin') ?? false;
                  _sharedPreferences.setBool('IsLogin', false);
                  IsLogin = false;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 20),),
                  ),Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.login_outlined),
                    )],
                ),

              ))
        ],
      ),
      body: Container(child: userDetails(base, date, time, tearm, provider)),
    );
  }
}
