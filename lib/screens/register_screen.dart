import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/screens/constant.dart';
import 'package:untitled1/screens/home_screen.dart';
import 'package:untitled1/screens/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final auth =FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileNoController = TextEditingController();
  SharedPreferences _sharedPreferences;

  String _nameText, _dobText, _mobilenoText,_emailText, _passwordText;
  bool isLoading = true;
  DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text("Register to your account"),
      ),
      body: Container(
        child: Form(
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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
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
                        height: 700,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Text(
                              "Register",
                              style: TextStyle(
                                fontSize: 35.0,
                                letterSpacing: 1.5,
                                color: Colors.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),Padding(
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

                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Name can't be empty";
                                      } else {
                                        _nameText = value;
                                      }
                                      return null;
                                    },
                                    onChanged: (v) {
                                      setState(() {
                                        _nameText = v;
                                      });
                                    },
                                    onSaved: (val) => _nameText = val,
                                    controller: _nameController,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(
                                          Icons.person_add,
                                          color: Colors.purple,
                                        ),
                                        hintText: 'Enter Name'),
                                  ),
                                ),
                              ),
                            ),Padding(
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
                                    onTap: (){
                                        _showDate(context);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "DOB can't be empty";
                                      } else {
                                        _dobText = selectedDate.toString();
                                      }
                                      return null;
                                    },
                                    onChanged: (v) {
                                      setState(() {
                                        _dobText = v;
                                      });
                                    },
                                    onSaved: (val) => _dobText = val,
                                    controller: _dobController,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.purple,
                                        ),
                                        hintText: 'Enter Birth Date'),
                                  ),
                                ),
                              ),
                            ),Padding(
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
                                    keyboardType: TextInputType.phone,

                                    validator: (value) {
                                      if (value.isEmpty && value.length==10) {
                                        return "Mobile No can't be empty & lenght shuld be 10";
                                      } else {
                                        _mobilenoText = value;
                                      }
                                      return null;
                                    },
                                    onChanged: (v) {
                                      setState(() {
                                        _mobilenoText = v;
                                      });
                                    },
                                    onSaved: (val) => _mobilenoText = val,
                                    controller: _mobileNoController,
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        icon: Icon(
                                          Icons.perm_phone_msg,
                                          color: Colors.purple,
                                        ),
                                        hintText: 'Enter MobileNo'),
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
                                      if (value.isEmpty && value.length<=8) {
                                        return "Password can't be empty and length should be 8";
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

                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: RaisedButton(
                                color: Color(0xFFAB47BC),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      registerData();
                                      _sharedPreferences?.setBool("IsLogin", true);
                                      _sharedPreferences?.setString(
                                          "UserName", _emailController.text);
                                      _sharedPreferences?.setString(
                                          "Password", _passwordController.text);

                                      eUserName = _emailController.text;
                                      ePassword = _passwordController.text;
                                      Fluttertoast.showToast(msg: "Register User Sucessfully.");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                  eUserName, ePassword)));
                                    });
                                    //await _loginData();

                                  }
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
                                  child: const Text('Register Now',
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
                                          builder: (context) => LoginScreen()));
                                },
                                child: Text(
                                  "Alredy Have Account ? Login.",
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void registerData() {
    var PName=_nameController.text;
    var PDob=_dobController.text;
    var PMobileNo=_mobileNoController.text;
    var PEmail=_emailController.text;
    var PPassword=_passwordController.text;
    Map<String,dynamic>demoData={"Name":PName,
      "DOB":PDob,
      "Mobile":PMobileNo,
      "Email Address":PEmail,
      "Password":PPassword,
      };
    CollectionReference collectionRefrence=FirebaseFirestore.instance.collection('Data');
    collectionRefrence.add(demoData).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(eUserName, ePassword))));
  }

  Future<void> _showDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.purple,
                  surface: Colors.purpleAccent,
                  background: Colors.purple,
                  onPrimary: Colors.white,
                  onSurface: Colors.purpleAccent,
                ),
                dialogBackgroundColor: Colors.white),
            child: child,
          );
        });
    if (picked != null && picked != DateTime.now())
      setState(() {
        selectedDate = picked;
        var splitDate = selectedDate.toString().split(' ').first.toString();
        _dobController.text = splitDate;
      });
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
