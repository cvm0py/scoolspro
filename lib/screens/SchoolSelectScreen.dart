// Flutter imports:
import 'package:flutter/material.dart';
import 'package:infixedu/screens/Login.dart';

// Package imports:

// Project imports:
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/server/Login.dart';

class SchoolSelectScreen extends StatefulWidget {
  @override
  _SchoolSelectScreenState createState() => _SchoolSelectScreenState();
}

class _SchoolSelectScreenState extends State<SchoolSelectScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String user;
  String email;

  bool isResponse = false;

  @override
  void initState() {
    super.initState();
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Container(
                      height: 150.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/config/logo_blue.png'),
                      )),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/schoolSelectGif.gif'),
                      )),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ListView(
                    children: <Widget>[
                      Center(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0))),
                                    contentPadding: EdgeInsets.only(top: 10.0),
                                    content: Container(
                                      width: 260.0,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: const Color(0xFFFFFF),
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(32.0)),
                                      ),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ListView(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                print(1);
                                                Route route;
                                                route = MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen());
                                                Navigator.pushReplacement(
                                                    context, route);
                                              },
                                              child: Container(
                                                child: ListTile(
                                                    title: Text(
                                                  'Admin school',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                )),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                print(2);
                                                Route route;
                                                route = MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen());
                                                Navigator.pushReplacement(
                                                    context, route);
                                              },
                                              child: Container(
                                                child: ListTile(
                                                    title: Text('Beta school',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                print(3);
                                                Route route;
                                                route = MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen());
                                                Navigator.pushReplacement(
                                                    context, route);
                                              },
                                              child: Container(
                                                child: ListTile(
                                                    title: Text('Gamma school',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/selectSchoolText.gif'),
                                )),
                          ),
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
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(10.0),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       GestureDetector(
      //         child: Container(
      //           alignment: Alignment.center,
      //           width: MediaQuery.of(context).size.width,
      //           height: 50.0,
      //           decoration: Utils.gradientBtnDecoration,
      //           child: Text(
      //             "Login",
      //             style: Theme.of(context)
      //                 .textTheme
      //                 .headline5
      //                 .copyWith(color: Colors.white),
      //           ),
      //         ),
      //         onTap: () {
      //           if (_formKey.currentState.validate()) {
      //             String email = emailController.text;
      //             String password = passwordController.text;

      //             if (email.length > 0 && password.length > 0) {
      //               setState(() {
      //                 isResponse = true;
      //               });
      //               Login(email, password).getData2(context).then((result) {
      //                 setState(() {
      //                   isResponse = false;
      //                 });
      //                 Utils.showToast(result);
      //               });
      //             } else {
      //               setState(() {
      //                 isResponse = false;
      //               });
      //               Utils.showToast('invalid email and password');
      //             }
      //           }
      //         },
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: isResponse == true
      //             ? LinearProgressIndicator(
      //                 backgroundColor: Colors.transparent,
      //               )
      //             : Text(''),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
