// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/config/app_config.dart';

// Project imports:
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/model/Fee.dart';
import 'package:infixedu/utils/server/FeesService.dart';
import 'package:infixedu/utils/widget/Fees_row_layout.dart';
import 'package:infixedu/utils/widget/ShimmerListWidget.dart';

import '../nav_main.dart';

// ignore: must_be_immutable
class FeeScreen extends StatefulWidget {
  String id;

  FeeScreen({this.id});

  @override
  _FeeScreenState createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  String _token;
  String grandTotal = "Grand Total";
  String amount = "Amount";
  String discount = 'Discount';
  String fine = 'Fine';
  String paid = 'Paid';
  String balance = 'Balance';

  @override
  void initState() {
    Utils.getStringValue('token').then((value) {
      _token = value;
    });
    Utils.getStringValue('lang').then((value) {
      Utils.getTranslatedLanguage(value, "Grand Total").then((val) {
        setState(() {
          grandTotal = val;
          print('Grand Total -> ' + grandTotal);
        });
      });

      Utils.getTranslatedLanguage(value, "Amount").then((val) {
        setState(() {
          amount = val;
        });
      });

      Utils.getTranslatedLanguage(value, "Discount").then((val) {
        setState(() {
          discount = val;
        });
      });

      Utils.getTranslatedLanguage(value, "Fine").then((val) {
        setState(() {
          fine = val;
        });
      });

      Utils.getTranslatedLanguage(value, "Paid").then((val) {
        setState(() {
          paid = val;
        });
      });
      Utils.getTranslatedLanguage(value, "Balance").then((val) {
        setState(() {
          balance = val;
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
        bottomNavigationBar: MainScreen(),
        // appBar: CustomAppBarWidget(title: 'Fees'),
        appBar: CustomAppBarWidget(
          title: 'Payment',
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      grandTotal,
                      style: Theme.of(context).textTheme.headline5.copyWith(),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                child: FutureBuilder(
                  future: Utils.getStringValue('id'),
                  builder: (context, id) {
                    if (id.hasData) {
                      return Container(
                        child: StreamBuilder<List<double>>(
                            stream: Stream.periodic(Duration(seconds: 3))
                                .asyncMap((i) => FeeService(
                                        int.parse(widget.id != null
                                            ? widget.id
                                            : id.data),
                                        _token)
                                    .fetchTotalFee()),
                            builder: (context, totalSnapshot) {
                              if (totalSnapshot.hasData) {
                                return Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            amount,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '\$' +
                                                totalSnapshot.data[0]
                                                    .toString(),
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            discount,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '\$' +
                                                totalSnapshot.data[1]
                                                    .toString(),
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            fine,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '\$' +
                                                totalSnapshot.data[2]
                                                    .toString(),
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            paid,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '\$' +
                                                totalSnapshot.data[3]
                                                    .toString(),
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            balance,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '\$' +
                                                totalSnapshot.data[4]
                                                    .toString(),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return ShimmerList(
                                  height: 40,
                                  itemCount: 1,
                                );
                              }
                            }),
                      );
                    } else {
                      return Container(
                        child: Text('...'),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 15.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffd9c1f8).withOpacity(0.5), Colors.white]),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FutureBuilder(
                  future: Utils.getStringValue('id'),
                  builder: (context, snapId) {
                    if (snapId.hasData) {
                      return Container(
                        child: StreamBuilder<List<Fee>>(
                            stream: Stream.periodic(Duration(seconds: 3))
                                .asyncMap((i) => FeeService(
                                        int.parse(widget.id != null
                                            ? widget.id
                                            : snapId.data),
                                        _token)
                                    .fetchFee()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return FeesRow(
                                          snapshot.data[index],
                                          widget.id != null
                                              ? widget.id
                                              : snapId.data);
                                    });
                              } else {
                                return ShimmerList(
                                  height: 40,
                                  itemCount: 1,
                                );
                              }
                            }),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
