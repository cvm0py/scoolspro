// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:infixedu/config/app_config.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import './Login.dart';

// Project imports:
import 'package:infixedu/localization/app_translations.dart';
import 'package:infixedu/localization/app_translations_delegate.dart';
import 'package:infixedu/localization/application.dart';
import 'package:infixedu/screens/Login.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AppTranslationsDelegate _newLocaleDelegate;
  AppTranslations appTranslations;
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;

    //getting language code from memory and using this code we fetch translated data from asset/locale
    Utils.getStringValue('lang').then((value) {
      if (value != null) {
        _newLocaleDelegate = AppTranslationsDelegate(newLocale: Locale(value));
        _newLocaleDelegate.load(Locale(value)).then((val) {
          if (!mounted) return;
          setState(() {
            appTranslations = val;
          });
        });
      }
    });

    Route route;
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 30.0, end: 90.0).animate(controller);
    controller.forward();

    Future.delayed(Duration(seconds: 3), () {
      getBooleanValue('isLogged').then((value) {
        if (value) {
          Utils.getStringValue('rule').then((rule) {
            Utils.getStringValue('zoom').then((zoom) {
              AppFunction.getFunctions(context, rule, zoom);
            });
          });
        } else {
          route = MaterialPageRoute(builder: (context) => LoginScreen());
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            /*Positioned.fill(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppConfig.splashScreenBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ), */
            Container(
              alignment: Alignment.topCenter,
              height: 10.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Container(
                          height: animation.value,
                          width: animation.value,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: ExactAssetImage(AppConfig.appLogo_blue),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.only(bottom: 80.0, left: 40, right: 40),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> getBooleanValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  void onLocaleChange(Locale locale) {
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
  }
}
