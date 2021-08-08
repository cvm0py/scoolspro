// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/config/app_config.dart';

// Project imports:
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/server/Login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String user;
  String email;
  Future<String> futureEmail;
  String password = '123456';
  bool isResponse = false;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String _notificationToken;

  @override
  void initState() {
    firebaseNotificationSetup();
    super.initState();
  }

  firebaseNotificationSetup() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    messaging.getToken().then((value) {
      _notificationToken = value;
      print(_notificationToken);
    });
    print('User granted permission: ${settings.authorizationStatus}');
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //   image: AssetImage(AppConfig.loginBackground),
                  //   fit: BoxFit.fill,
                 // )),
                  child: Center(
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(AppConfig.appLogo_blue),
                      )),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                    email = 'student@student.com';
                                    emailController.text = email;
                                    passwordController.text = password;
                                  });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: AppConfig.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8.0),
                                      bottomLeft: Radius.circular(8.0),
                                    ),
                                  )),
                              child: Text(
                                "Student",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                   setState(() {
                                    email = 'Teacher2@gmail.com';
                                    emailController.text = email;
                                    passwordController.text = password;
                                  });
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: AppConfig.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                  )),
                              child: Text("Teacher",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                    email = 'Guardian4@scoolspro.com';
                                    emailController.text = email;
                                    passwordController.text = password;
                                  });
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: AppConfig.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                  )),
                              child: Text("Parents",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: textStyle,
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "email",
                              labelText: "Email",
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Colors.pinkAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 1.0),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: textStyle,
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'please enter a valid password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "password",
                              labelText: "Password",
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                  color: Colors.pinkAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                decoration: Utils.gradientBtnDecoration,
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.white),
                ),
              ),
              onTap: () {
                if (_formKey.currentState.validate()) {
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (email.length > 0 && password.length > 0) {
                    setState(() {
                      isResponse = true;
                    });
                    Login(email, password).getData2(context).then((result) {
                      setState(() {
                        isResponse = false;
                      });
                      Utils.showToast(result);
                    });
                  } else {
                    setState(() {
                      isResponse = false;
                    });
                    Utils.showToast('invalid email and password');
                  }
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: isResponse == true
                  ? LinearProgressIndicator(
                      backgroundColor: Colors.transparent,
                    )
                  : Text(''),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getEmail(String user) async {
    final response = await http.get(Uri.parse(InfixApi.getEmail));
    print(response.body);
    var jsonData = json.decode(response.body);

    //print(InfixApi.getDemoEmail(schoolId));

    return jsonData['data'][user]['email'];
  }
}
