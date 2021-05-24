import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/screens/constant.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    taskAsynk();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  SharedPreferences _sharedPreferences;

  String  _emailText, _passwordText;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text("Login to your account"),
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      height: 50,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    height: 400,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 35.0,
                            letterSpacing: 1.5,
                            color: Colors.purple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.purple[50]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Email can't be empty";
                                  } else {
                                    _emailText = value;
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  setState(() {
                                    _emailText = v;
                                  });
                                },
                                onSaved: (val) => _emailText = val,
                                controller: _emailController,
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    Icons.email_rounded,
                                    color: Colors.purple,
                                  ),
                                  hintText: 'Enter Email Address',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.purple[50]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Password can't be empty";
                                  } else {
                                    _passwordText = value;
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  setState(() {
                                    _passwordText = v;
                                  });
                                },
                                onSaved: (val) => _passwordText = val,
                                controller: _passwordController,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(
                                      Icons.lock,
                                      color: Colors.purple,
                                    ),
                                    hintText: 'Enter Password'),
                              ),
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forget Password?",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: RaisedButton(
                            color: Color(0xFFAB47BC),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _sharedPreferences?.setBool("IsLogin", true);
                                  _sharedPreferences?.setString(
                                      "UserName", _emailController.text);
                                  _sharedPreferences?.setString(
                                      "Password", _passwordController.text);
                                  eUserName = _emailController.text;
                                  ePassword = _passwordController.text;
                                  Fluttertoast.showToast(
                                      msg: "Login Sucessfully.");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                              eUserName, ePassword)));
                                });
                                await _loginData();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen(eUserName, ePassword)));
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: 250,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFFE1BEE7),
                                    Color(0xFFAB47BC),
                                    Color(0xFF7B1FA2),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: const Text('Login Now',
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              "Don't Have Account ? Register.",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _loginData() async {
    final User user = (await auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;
    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(eUserName, ePassword)));
    }
  }

  taskAsynk() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff9C27B0);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
