import 'dart:convert';

import 'package:cell_calendar/cell_calendar.dart';
import 'package:expandable/expandable.dart';
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

class Calendar extends StatefulWidget {
  Calendar({this.id});

  String id;

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
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
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
                        const SizedBox(width: 12),
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
                            content: GestureDetector(
                              child: ExpandableNotifier(
                                  child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff3575B6),
                                          shape: BoxShape.rectangle,
                                        ),
                                      ),
                                    ),
                                    ScrollOnExpand(
                                      scrollOnExpand: true,
                                      scrollOnCollapse: false,
                                      child: ExpandablePanel(
                                        theme: const ExpandableThemeData(
                                          headerAlignment:
                                              ExpandablePanelHeaderAlignment
                                                  .center,
                                          tapBodyToCollapse: true,
                                        ),
                                        header: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "Highlights Of The Day",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )),
                                        collapsed: Text(
                                          "Updated March 27, 2021",
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        expanded: Column(
                                          children: eventsOnTheDate
                                              .map(
                                                (event) => Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(4),
                                                  margin: EdgeInsets.only(
                                                      bottom: 12),
                                                  color: event
                                                      .eventBackgroundColor,
                                                  child: Text(
                                                    event.eventName,
                                                    style: TextStyle(
                                                        color: event
                                                            .eventTextColor),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                        ),
                                        builder: (_, collapsed, expanded) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            child: Expandable(
                                              collapsed: collapsed,
                                              expanded: expanded,
                                              theme: const ExpandableThemeData(
                                                  crossFadePoint: 0),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ));
                },
                onPageChanged: (firstDate, lastDate) {
                  /// Called when the page was changed
                  /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
                },
              ),
            ),
          ],
        ),
      ),
    );

    //   return Padding(
    //     padding: EdgeInsets.only(top: statusBarHeight),
    //     child: Scaffold(
    //       bottomNavigationBar: MainScreen(),
    //       appBar: CustomAppBarWidget(title: 'Calendar'),
    //       backgroundColor: Colors.white,
    //       body: Column(
    //         children: <Widget>[
    //           Expanded(
    //             child: CalendarCarousel(
    //                 // height: MediaQuery.of(context).size.height * 0.5,
    //                 weekDayPadding: EdgeInsets.zero,
    //                 onDayPressed: (DateTime date, List<Calendar> events) {
    //                   this.setState(() => _currentDate = date);
    //                 },
    //                 onCalendarChanged: (DateTime date) {},
    //                 weekendTextStyle: Theme.of(context).textTheme.headline6,
    //                 thisMonthDayBorderColor: Colors.grey,
    //                 daysTextStyle: Theme.of(context).textTheme.headline4,
    //                 showOnlyCurrentMonthDate: false,
    //                 headerTextStyle: Theme.of(context)
    //                     .textTheme
    //                     .headline6
    //                     .copyWith(fontSize: ScreenUtil().setSp(15.0)),
    //                 weekdayTextStyle: Theme.of(context)
    //                     .textTheme
    //                     .headline4
    //                     .copyWith(
    //                         fontSize: ScreenUtil().setSp(15.0),
    //                         fontWeight: FontWeight.w500),
    //                 weekFormat: false,
    //                 markedDatesMap: _markedDateMap,
    //                 selectedDateTime: _currentDate,
    //                 // daysHaveCircularBorder: true,
    //                 todayButtonColor: Colors.transparent,
    //                 todayBorderColor: Colors.transparent,
    //                 todayTextStyle: Theme.of(context)
    //                     .textTheme
    //                     .headline4
    //                     .copyWith(color: Colors.white)),
    //           ),
    //           SizedBox(height: 30),
    //           // Expanded(
    //           //   child: Center(child: Text('No Events to display', style: TextStyle(fontSize : 16)))
    //           // ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
  }
}
