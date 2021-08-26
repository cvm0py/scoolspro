import 'dart:convert';

import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/screens/nav_main.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/sample_event.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

import 'package:horizontal_calendar_widget/date_helper.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';

const labelMonth = 'Month';
const labelDate = 'Date';
const labelWeekDay = 'Week Day';

class CalendarHorizontal extends StatefulWidget {
  @override
  _CalendarHorizontalState createState() => _CalendarHorizontalState();
}

class _CalendarHorizontalState extends State<CalendarHorizontal> {
  loadData() async {
    //var response =
    //     await http.get(Uri.parse(InfixApi.getPhotos());
    // // print('-->' + response.body.toString());
    // Map<String, dynamic> decodedJson = json.decode(response.body);
    // //print('-->' + decodedJson.toString());
    // var responseData = decodedJson['data'];
    // //print('->' + responseData.toString());
    // return decodedJson['data']['photos'];
  }
  String selectedTime = '';
  String selectedDate;
  String monthString;

  DateTime firstDate;
  DateTime lastDate;
  String dateFormat = 'dd';
  String monthFormat = 'MMM';
  String weekDayFormat = 'EEE';
  List<String> order = [labelMonth, labelDate, labelWeekDay];
  bool forceRender = false;

  Color defaultDecorationColor = Colors.transparent;
  BoxShape defaultDecorationShape = BoxShape.circle;
  bool isCircularRadiusDefault = true;

  Color selectedDecorationColor = Colors.blue[600];
  BoxShape selectedDecorationShape = BoxShape.circle;
  bool isCircularRadiusSelected = true;

  Color disabledDecorationColor = Colors.grey;
  BoxShape disabledDecorationShape = BoxShape.circle;
  bool isCircularRadiusDisabled = true;

  int minSelectedDateCount = 1;
  int maxSelectedDateCount = 1;
  RangeValues selectedDateCount;
  List<DateTime> feedInitialSelectedDates(int target, int calendarDays) {
    List<DateTime> selectedDates = [];

    for (int i = 0; i < calendarDays; i++) {
      if (selectedDates.length == target) {
        break;
      }
      DateTime date = firstDate.add(Duration(days: i));
      if (date.weekday != DateTime.sunday) {
        selectedDates.add(date);
      }
    }
    return selectedDates;
  }

  List<DateTime> initialSelectedDates;
  String convertNumberMonthToStringMonth(month) {
    if (month == 1) {
      monthString = 'January';
    } else if (month == 2) {
      monthString = 'Fabruary';
    } else if (month == 3) {
      monthString = 'March';
    } else if (month == 4) {
      monthString = 'April';
    } else if (month == 5) {
      monthString = 'May';
    } else if (month == 6) {
      monthString = 'June';
    } else if (month == 7) {
      monthString = 'July';
    } else if (month == 8) {
      monthString = 'August';
    } else if (month == 9) {
      monthString = 'September';
    } else if (month == 10) {
      monthString = 'October';
    } else if (month == 11) {
      monthString = 'November';
    } else if (month == 12) {
      monthString = 'December';
    }
    return monthString;
  }

  initState() {
    super.initState();
    const int days = 31;
    firstDate = toDateMonthYear(DateTime.now());
    lastDate = toDateMonthYear(firstDate.add(Duration(days: days - 1)));
    selectedDateCount = RangeValues(
      minSelectedDateCount.toDouble(),
      maxSelectedDateCount.toDouble(),
    );
    initialSelectedDates = feedInitialSelectedDates(minSelectedDateCount, days);
    setState(() {
      selectedDate =
          '${firstDate.day}-${convertNumberMonthToStringMonth(firstDate.month)}';
    });
  }

  LabelType toLabelType(String label) {
    LabelType type;
    switch (label) {
      case labelMonth:
        type = LabelType.month;
        break;
      case labelDate:
        type = LabelType.date;
        break;
      case labelWeekDay:
        type = LabelType.weekday;
        break;
    }
    return type;
  }

  horizontalDatePicker() {
    return HorizontalCalendar(
      key: forceRender ? UniqueKey() : Key('Calendar'),
      selectedDateTextStyle: TextStyle(color: Colors.white),
      selectedMonthTextStyle: TextStyle(color: Colors.white),
      selectedWeekDayTextStyle: TextStyle(color: Colors.white),
      spacingBetweenDates: 10.0,
      height: 105,
      padding: EdgeInsets.all(10 * 2.0),
      firstDate: firstDate,
      lastDate: lastDate,
      dateFormat: dateFormat,
      weekDayFormat: weekDayFormat,
      monthFormat: monthFormat,
      defaultDecoration: BoxDecoration(
        color: defaultDecorationColor,
        shape: defaultDecorationShape,
        borderRadius: defaultDecorationShape == BoxShape.rectangle &&
                isCircularRadiusDefault
            ? BorderRadius.circular(8)
            : null,
      ),
      selectedDecoration: BoxDecoration(
        color: selectedDecorationColor,
        shape: selectedDecorationShape,
        borderRadius: selectedDecorationShape == BoxShape.rectangle &&
                isCircularRadiusSelected
            ? BorderRadius.circular(8)
            : null,
      ),
      disabledDecoration: BoxDecoration(
        color: disabledDecorationColor,
        shape: disabledDecorationShape,
        borderRadius: disabledDecorationShape == BoxShape.rectangle &&
                isCircularRadiusDisabled
            ? BorderRadius.circular(8)
            : null,
      ),
      //isDateDisabled: (date) => date.weekday == DateTime.sunday,
      labelOrder: order.map(toLabelType).toList(),
      // minSelectedDateCount: minSelectedDateCount,
      maxSelectedDateCount: maxSelectedDateCount,
      initialSelectedDates: initialSelectedDates,
      onDateSelected: (e) async {
        setState(() {
          selectedDate = '${e.day}-${convertNumberMonthToStringMonth(e.month)}';
          print('selected Date -> ' + selectedDate);
        });
      },
    );
  }

  final _sampleEvents = sampleEvents();
  final cellCalendarPageController = CellCalendarPageController();
  var _currentDate;
  var _markedDateMap;

  Widget build(BuildContext context) {
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
          children: [
            horizontalDatePicker()
            /*
            Container(
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width,
              child: CellCalendar(
                cellCalendarPageController: cellCalendarPageController,
                events: _sampleEvents,
                daysOfTheWeekBuilder: (dayIndex) {
                  final labels = ["S", "M", "T", "W", "T", "F", "S"];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Text(
                      labels[dayIndex],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                monthYearLabelBuilder: (datetime) {
                  final year = datetime.year.toString();
                  final month = datetime.month.monthName;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Text(
                          "$month  $year",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            cellCalendarPageController.animateToDate(
                              DateTime.now(),
                              curve: Curves.linear,
                              duration: Duration(milliseconds: 300),
                            );
                          },
                        )
                      ],
                    ),
                  );
                },
                onCellTapped: (date) {
                  final eventsOnTheDate = _sampleEvents.where((event) {
                    final eventDate = event.eventDate;
                    return eventDate.year == date.year &&
                        eventDate.month == date.month &&
                        eventDate.day == date.day;
                  }).toList();
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(date.month.monthName +
                                " " +
                                date.day.toString()),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: eventsOnTheDate
                                  .map(
                                    (event) => Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(4),
                                      margin: EdgeInsets.only(bottom: 12),
                                      color: event.eventBackgroundColor,
                                      child: Text(
                                        event.eventName,
                                        style: TextStyle(
                                            color: event.eventTextColor),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ));
                },
                onPageChanged: (firstDate, lastDate) {
                  /// Called when the page was changed
                  /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
                },
              ),
            ),
          */
          ],
        ),
      ),
    );
  }
}
