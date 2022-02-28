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
import 'package:infixedu/utils/model/UploadedContent.dart';
import 'package:infixedu/utils/widget/StudyMaterial_row.dart';

import '../../nav_main.dart';

// ignore: must_be_immutable
class StudentAssignment extends StatefulWidget {
  String id;

  StudentAssignment({this.id});

  @override
  _StudentAssignmentState createState() => _StudentAssignmentState();
}

class _StudentAssignmentState extends State<StudentAssignment> {
  Future<UploadedContentList> assignments;
  String _token;

  @override
  void initState() {
    Utils.getStringValue('token').then((value) {
      _token = value;
    });
    Utils.getStringValue('id').then((value) {
      setState(() {
        assignments = fetchAssignment(
            widget.id != null ? int.parse(widget.id) : int.parse(value));
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        bottomNavigationBar: MainScreen(),
        appBar: CustomAppBarWidget(title: 'Assignment'),
        backgroundColor: Colors.white,
        body: FutureBuilder<UploadedContentList>(
          future: assignments,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot != null) {
              if (snapshot.data.uploadedContents.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data.uploadedContents.length,
                  itemBuilder: (context, index) {
                    return StudyMaterialListRow(
                        snapshot.data.uploadedContents[index]);
                  },
                );
              } else {
                return Utils.noDataWidget();
              }
            } else {
              return Center(child: CupertinoActivityIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<UploadedContentList> fetchAssignment(int id) async {
    final response = await http.get(
        Uri.parse(InfixApi.getStudentAssignment(id)),
        headers: Utils.setHeader(_token.toString()));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      return UploadedContentList.fromJson(jsonData['data']['uploadContents']);
    } else {
      throw Exception('failed to load');
    }
  }
}
