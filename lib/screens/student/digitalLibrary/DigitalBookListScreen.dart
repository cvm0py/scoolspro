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
import 'package:infixedu/utils/model/Book.dart';
import 'package:infixedu/utils/model/DigitalBook.dart';
import 'package:infixedu/utils/widget/BookRowLayout.dart';
import 'package:infixedu/utils/widget/DigitalBookRowLayout.dart';

import '../../nav_main.dart';

class DigitalBookListScreen extends StatefulWidget {
  String id;
  DigitalBookListScreen({@required this.id});
  @override
  _DigitalBookListState createState() => _DigitalBookListState();
}

class _DigitalBookListState extends State<DigitalBookListScreen> {
  Future<DigitalBookList> books;
  String _token;
  @override
  void initState() {
    super.initState();
    Utils.getStringValue('token').then((value) {
      setState(() {
        _token = value;
      });
    })
      ..then((value) {
        setState(() {
          books = getAllBooks();
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
        bottomNavigationBar: MainScreen(),
        appBar: CustomAppBarWidget(title: 'Book List'),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<DigitalBookList>(
            future: books,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.books.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.books.length,
                    itemBuilder: (context, index) {
                      return DigitalBookListRow(snapshot.data.books[index]);
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
      ),
    );
  }

  Future<DigitalBookList> getAllBooks() async {
    final response = await http.get(
        Uri.parse(InfixApi.digitalBookList(widget.id)),
        headers: Utils.setHeader(_token.toString()));

    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print(11);
      print(jsonData);
      return DigitalBookList.fromJson(jsonData['data']['books']);
    } else {
      throw Exception('Failed to load');
    }
  }
}
