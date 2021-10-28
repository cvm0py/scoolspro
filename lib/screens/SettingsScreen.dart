// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/localization/app_translations.dart';

// Project imports:
import 'package:infixedu/localization/application.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/widget/Line.dart';
import '../main.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<bool> isSelected = [false, false];
  GlobalKey _scaffold = GlobalKey();
  AppTranslations appTranslation;
  String languageSet;
  String changeLanguage = "Change Language";
  String language = "Language";
  String systemLocale = 'System Locale';

  @override
  void initState() {
    super.initState();
    Utils.getIntValue('locale').then((value) {
      setState(() {
        // ignore: unnecessary_statements
        value != null ? isSelected[value] = true : null;
        //Utils.showToast('$value');
      });
    });
    Utils.getStringValue('lang').then((value) {
      Utils.getTranslatedLanguage(value, "Change Language").then((value) {
        setState(() {
          changeLanguage = value.toString();
        });
      });
      Utils.getTranslatedLanguage(value, "Language").then((value) {
        setState(() {
          language = value.toString();
        });
      });

      Utils.getTranslatedLanguage(value, 'System Locale').then((value) {
        setState(() {
          systemLocale = value.toString();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppConfig.primary, //or set color with: Color(0xFF0000FF)
    ));
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        appBar: CustomAppBarWidget(title: 'Settings'),
        backgroundColor: Colors.white,
        key: _scaffold,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: toggleButton(context),
                ),
                elevation: 5.0,
              ),
            ),
            BottomLine(),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppConfig.primary,
                child: Icon(
                  Icons.language,
                  color: Colors.white,
                  size: ScreenUtil().setSp(16),
                ),
              ),
              title: Text(
                changeLanguage,
                style: Theme.of(context).textTheme.headline6,
              ),
              trailing: GestureDetector(
                onTap: () {
                  showChangeLanguageAlert(_scaffold.currentContext);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: AppConfig.primary,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        language,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                    )),
              ),
              dense: true,
            ),
            BottomLine(),
          ],
        ),
      ),
    );
  }

  Widget toggleButton(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              systemLocale,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ToggleButtons(
            borderColor: Colors.blueAccent,
            fillColor: AppConfig.primary,
            borderWidth: 2,
            selectedBorderColor: AppConfig.primary,
            selectedColor: Colors.white,
            borderRadius: BorderRadius.circular(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'RTL',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'popins',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'LTL',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'popins',
                  ),
                ),
              ),
            ],
            onPressed: (int index) {
              setState(() {
                Utils.saveIntValue('locale', index);
                rebuildAllChildren(context);
                for (int i = 0; i < isSelected.length; i++) {
                  if (i == index) {
                    isSelected[i] = true;
                  } else {
                    isSelected[i] = false;
                  }
                }
              });
            },
            isSelected: isSelected,
          ),
        ],
      ),
    );
  }

  showChangeLanguageAlert(BuildContext context) {
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, right: 20.0),
                    child: ListView.builder(
                      itemCount: languagesList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Utils.saveStringValue(
                                    'lang', languagesMap[languagesList[index]]);
                                application.onLocaleChanged(
                                    Locale(languagesMap[languagesList[index]]));
                                rebuildAllChildren(context);
                              },
                              child: Text(
                                languagesList[index],
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            BottomLine(),
                          ],
                        );
                      },
                    )),
              ),
            ),
          ],
        );
      },
    );
  }

  void rebuildAllChildren(BuildContext context) {
//    Navigator.of(context)
//        .push(MaterialPageRoute(builder: (BuildContext context) {
//      return MyApp();
    Route route = MaterialPageRoute(builder: (context) => MyApp());
    Navigator.pushAndRemoveUntil(context, route, ModalRoute.withName('/'));
  }
}
