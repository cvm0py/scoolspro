// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/config/app_config.dart';

// Project imports:
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/widget/TeacherMyRoutineItem.dart';

import '../../nav_main.dart';

// ignore: must_be_immutable
class TeacherMyRoutineScreen extends StatelessWidget {
  List<String> weeks = AppFunction.weeks;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppConfig.primary, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        
        bottomNavigationBar: MainScreen(),
        appBar: CustomAppBarWidget(title: 'My Routine'),
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: weeks.length,
          itemBuilder: (context, index) {
            return TeacherRoutineRow(title: weeks[index]);
          },
        ),
      ),
    );
  }
}
