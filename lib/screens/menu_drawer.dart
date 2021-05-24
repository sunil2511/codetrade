import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/screens/constant.dart';
import 'package:untitled1/screens/login_screen.dart';
import 'package:untitled1/screens/register_screen.dart';


Widget menuDrawer(BuildContext context) {
  SharedPreferences _sharedPreferences;
  SharedPreferences.getInstance().then((value) {
    _sharedPreferences = value;
    IsLogin = _sharedPreferences.getBool('IsLogin') ?? false;
  });
  return SafeArea(
    top: true,
    child: Container(
      width: 200,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: Container(
              child: Image.asset(
                'assets/images/cover.jpg',
                fit: BoxFit.contain,
              ),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.purple)),
            )),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login_rounded,
                    color: Colors.purple,
                    size: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.purple, fontSize: 17),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>LoginScreen()));
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.how_to_reg_outlined,
                    color: Colors.purple,
                    size: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Registration',
                      style: TextStyle(color: Colors.purple, fontSize: 17),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
            (IsLogin)
                ? ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.purple,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Logout',
                            style:
                                TextStyle(color: Colors.purple, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      _sharedPreferences.setBool('IsLogin', false);
                      IsLogin = false;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  )
                : ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.login,
                          color: Colors.purple,
                          size: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Login',
                            style:
                                TextStyle(color: Colors.purple, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  ),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
    ),
  );
}
