// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:http/http.dart' as http;

// Project imports:
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String id;
  String _token;
  String chgPwd = 'Change Password';
  String currPwd = "Current Password";
  String enterCurrPwd = 'Please enter your current password';
  String sixDigitPwd = 'Password must be at least 6 digit';
  String enterNewPwd = 'Please enter a new password';
  String newPwd = "New Password";
  String cnfPwd = 'Please confirm your password';
  String samePwd = 'New password and confirm password must be same.';
  String enterCnfPwd = "Confirm Password";
  String change = "Change";
  bool isResponse = false;

  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Utils.getStringValue('id').then((value) {
      setState(() {
        id = value;
      });
    });
    Utils.getStringValue('token').then((value) {
      _token = value;
    });

    Utils.getStringValue('lang').then((language) {
      Utils.getTranslatedLanguage(language, "Change Password").then((value) {
        chgPwd = value;
      });

      Utils.getTranslatedLanguage(language, "Current Password").then((value) {
        currPwd = value;
      });

      Utils.getTranslatedLanguage(language, "Please enter your current password").then((value) {
        enterCurrPwd = value;
      });

      Utils.getTranslatedLanguage(language, "Password must be at least 6 digit").then((value) {
        sixDigitPwd = value;
      });

      Utils.getTranslatedLanguage(language, "Please enter a new password").then((value) {
        enterNewPwd = value;
      });

      Utils.getTranslatedLanguage(language, "New Password").then((value) {
        newPwd = value;
      });

            Utils.getTranslatedLanguage(language, "Please confirm your password").then((value) {
        cnfPwd = value;
      });

            Utils.getTranslatedLanguage(language, "New password and confirm password must be same.'").then((value) {
        samePwd = value;
      });

            Utils.getTranslatedLanguage(language, "Confirm Password").then((value) {
        enterCnfPwd = value;
      });

            Utils.getTranslatedLanguage(language, "Change").then((value) {
        change = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: chgPwd,
      ),
      body: Center(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.headline6,
                    controller: _currentPasswordController,
                    obscureText: true,
                    validator: (String value) {
                      // RegExp regExp = new RegExp(r'^[0-9]*$');
                      if (value.isEmpty) {
                        return enterCurrPwd;
                      }
                      if (value.length < 6) {
                        return sixDigitPwd;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: currPwd,
                      labelText: currPwd,
                      labelStyle: Theme.of(context).textTheme.headline4,
                      errorStyle:
                          TextStyle(color: Colors.pinkAccent, fontSize: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.headline6,
                    controller: _newPasswordController,
                    obscureText: true,
                    validator: (String value) {
                      // RegExp regExp = new RegExp(r'^[0-9]*$');
                      if (value.isEmpty) {
                        return enterNewPwd;
                      }
                      if (value.length < 6) {
                        return sixDigitPwd;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: newPwd,
                      labelText: newPwd,
                      labelStyle: Theme.of(context).textTheme.headline4,
                      errorStyle:
                          TextStyle(color: Colors.pinkAccent, fontSize: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: Theme.of(context).textTheme.headline6,
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (String value) {
                      // RegExp regExp = new RegExp(r'^[0-9]*$');
                      if (value.isEmpty) {
                        return cnfPwd;
                      }
                      if (value.length < 6) {
                        return sixDigitPwd;
                      }
                      if (value != _newPasswordController.text) {
                        return samePwd;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: enterCnfPwd,
                      labelText: enterCnfPwd,
                      labelStyle: Theme.of(context).textTheme.headline4,
                      errorStyle:
                          TextStyle(color: Colors.pinkAccent, fontSize: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      errorMaxLines: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      decoration: Utils.gradientBtnDecoration,
                      child: Text(
                        change,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isResponse = true;
                        });

                        var response = await http.post(
                            Uri.parse(InfixApi.changePassword(
                                _currentPasswordController.text,
                                _newPasswordController.text,
                                _confirmPasswordController.text,
                                id)),
                            headers: Utils.setHeader(_token.toString()));

                        if (response.statusCode == 200) {
                          Map<String, dynamic> data =
                              jsonDecode(response.body) as Map;

                          if (data['success'] == true) {
                            Utils.showToast('Password changed successfully');
                            Navigator.of(context).pop();
                          } else {
                            Utils.showToast(
                                'You Entered Wrong Current Password');
                          }

                          setState(() {
                            _currentPasswordController.clear();
                            _newPasswordController.clear();
                            _confirmPasswordController.clear();
                            isResponse = false;
                          });
                        } else if (response.statusCode == 404) {
                          Map<String, dynamic> data =
                              jsonDecode(response.body) as Map;

                          if (data['success'] == false) {
                            Utils.showToast(
                                'You Entered Wrong Current Password');
                          }

                          setState(() {
                            _currentPasswordController.clear();
                            _newPasswordController.clear();
                            _confirmPasswordController.clear();
                            isResponse = false;
                          });
                        }
                      } else {
                        Utils.showToast('Please correct the errors');
                      }
                    },
                  ),
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
        ),
      ),
    );
  }
}
