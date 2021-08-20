// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:infixedu/config/app_config.dart';

// Project imports:
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/model/zoom_meeting.dart';
import 'package:infixedu/utils/widget/meeting_row.dart';

class VirtualClassScreen extends StatefulWidget {
  final uid;

  VirtualClassScreen({this.uid});

  @override
  _VirtualClassScreenState createState() => _VirtualClassScreenState();
}

class _VirtualClassScreenState extends State<VirtualClassScreen> {
  String _token;
  String classID;
  String sectionID;
  String notAvailable = "Not available";
  String onlineClass = "Online Class";

  @override
  void initState() {
    Utils.getStringValue('token').then((value) {
      setState(() {
        _token = value;
      });
    });
    Utils.getStringValue('classId').then((value) {
      setState(() {
        classID = value;
      });
    });
    Utils.getStringValue('sectionID').then((value) {
      setState(() {
        sectionID = value;
      });
    });
    Utils.getStringValue('lang').then((value) {
      Utils.getTranslatedLanguage(value, "Online Class").then((val) {
        setState(() {
          onlineClass = val;
        });
      });
       Utils.getTranslatedLanguage(value, "Not available").then((val) {
        setState(() {
          notAvailable = val;
        });
      });
    });
    super.initState();
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
        appBar: CustomAppBarWidget(
          title: onlineClass,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<ZoomMeetingList>(
          future: getAllMeeting(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.meetings.length < 1) {
                return Center(
                    child: Text(
                  notAvailable,
                  style: Theme.of(context).textTheme.subtitle1,
                ));
              }
              return ListView.builder(
                itemCount: snapshot.data.meetings.length,
                itemBuilder: (context, index) {
                  return ZoomMeetingRow(
                      snapshot.data.meetings.elementAt(index));
                },
              );
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<ZoomMeetingList> getAllMeeting() async {
    print('URL' + InfixApi.getAllZoomClassesByClass(classID, sectionID));
    final response = await http.get(
        Uri.parse(InfixApi.getAllZoomClassesByClass(classID, sectionID)),
        headers: Utils.setHeader(_token.toString()));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(jsonData['data']['virtualclass']);

      return ZoomMeetingList.fromJson(jsonData['data']['virtualclass']);
    } else {
      throw Exception('Failed to load');
    }
  }
}
