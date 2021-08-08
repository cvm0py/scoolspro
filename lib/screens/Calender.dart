import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/screens/nav_main.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';



class Calendar extends StatefulWidget {
  String id;

  Calendar({this.id});
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  loadData() async {
    var response =
        await http.get(Uri.parse(InfixApi.getPhotos(widget.id.toString())));
    // print('-->' + response.body.toString());
    Map<String, dynamic> decodedJson = json.decode(response.body);
    //print('-->' + decodedJson.toString());
    var responseData = decodedJson['data'];
    //print('->' + responseData.toString());
    return decodedJson['data']['photos'];
  }

  Widget build(BuildContext context) {
    var _currentDate;
    var _markedDateMap;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppConfig.primary, //or set color with: Color(0xFF0000FF)
    ));

    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
        bottomNavigationBar: MainScreen(),
        appBar: CustomAppBarWidget(title: 'Calendar'),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Expanded(
              child: CalendarCarousel(
                  // height: MediaQuery.of(context).size.height * 0.5,
                  weekDayPadding: EdgeInsets.zero,
                  onDayPressed: (DateTime date, List<Calendar> events) {
                    this.setState(() => _currentDate = date);
                  },
                  onCalendarChanged: (DateTime date) {
                    
                  },
                  weekendTextStyle: Theme.of(context).textTheme.headline6,
                  thisMonthDayBorderColor: Colors.grey,
                  daysTextStyle: Theme.of(context).textTheme.headline4,
                  showOnlyCurrentMonthDate: false,
                  headerTextStyle: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: ScreenUtil().setSp(15.0)),
                  weekdayTextStyle: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(
                          fontSize: ScreenUtil().setSp(15.0),
                          fontWeight: FontWeight.w500),
                  
                  
                  weekFormat: false,
                  markedDatesMap: _markedDateMap,
                  selectedDateTime: _currentDate,
                  // daysHaveCircularBorder: true,
                  todayButtonColor: Colors.transparent,
                  todayBorderColor: Colors.transparent,
                  todayTextStyle: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white)),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Center(child: Text('No Events to display', style: TextStyle(fontSize : 16)))
            ),
            
          ],
        ),
      ),
    );
  }
}
