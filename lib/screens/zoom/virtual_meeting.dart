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

class VirtualMeetingScreen extends StatefulWidget {
  final uid;

  VirtualMeetingScreen({this.uid});

  @override
  _VirtualMeetingScreenState createState() => _VirtualMeetingScreenState();
}

class _VirtualMeetingScreenState extends State<VirtualMeetingScreen> {
//
//  String _id;

  String notAvailable ="Not available";


  String _token;
  String _id;

  @override
  void initState() {
    Utils.getStringValue('token').then((value) {
      setState(() {
        _token = value;
      });
    });
    Utils.getStringValue('id').then((value) {
      setState(() {
        _id = value;
      });
    });
     Utils.getStringValue('lang').then((language) {
      Utils.getTranslatedLanguage(language, "Not available").then((value) {
        notAvailable = value;
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
          title: 'Online Meeting',
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
    print('Meeting:' + InfixApi.getAllZoomMeetingsByUserID(_id));
    final response = await http.get(
        Uri.parse(InfixApi.getAllZoomMeetingsByUserID('4')),
        headers: Utils.setHeader(_token.toString()));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return ZoomMeetingList.fromJson(jsonData['data']['meeting']);
    } else {
      throw Exception('Failed to load');
    }
  }
}
