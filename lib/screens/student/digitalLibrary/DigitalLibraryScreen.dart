// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/config/app_config.dart';

// Project imports:
import 'package:infixedu/utils/CardItem.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/utils/FunctinsData.dart';

import '../../nav_main.dart';

// ignore: must_be_immutable
class DigitalLibraryHome extends StatefulWidget {
  var _titles;
  var _images;
  var id;

  DigitalLibraryHome(this._titles, this._images, {this.id});

  @override
  _HomeState createState() => _HomeState(_titles, _images);
}

class _HomeState extends State<DigitalLibraryHome> {
  bool isTapped;
  int currentSelectedIndex;
  var _titles;
  var _images;

  _HomeState(this._titles, this._images);

  @override
  void initState() {
    super.initState();
    isTapped = false;
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
        appBar: CustomAppBarWidget(title: 'Digital Library'),
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: GridView.builder(
            itemCount: _titles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: (2 / 1.2)),
            itemBuilder: (context, index) {
              return CustomWidget(
                index: index,
                isSelected: currentSelectedIndex == index,
                onSelect: () {
                  setState(() {
                    currentSelectedIndex = index;
                    AppFunction.getDigitalLibraryDashboardPage(
                        context, _titles[index],
                        id: widget.id);
                  });
                },
                headline: _titles[index],
                icon: _images[index],
              );
            },
          ),
        ),
      ),
    );
  }
}