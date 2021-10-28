// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:infixedu/utils/model/ActiveOnlineExam.dart';

import '../Utils.dart';

// ignore: must_be_immutable
class ActiveOnlineExamRow extends StatefulWidget {
  ActiveOnlineExam exam;

  ActiveOnlineExamRow(this.exam);

  @override
  _ActiveOnlineExamRowState createState() => _ActiveOnlineExamRowState();
}

class _ActiveOnlineExamRowState extends State<ActiveOnlineExamRow> {
  String subject = "Subject";

  String notAssigned = "not assigned";

  String date = "Date";

  String action = "Action";

  String running = 'Running'; 

  String pending = 'Pending';

  String closed = 'Closed';

  String submitted = 'Submitted';

  String active = "Active";

  Random random = Random();

  @override
  void initState() {
 
    Utils.getStringValue('lang').then((language) {
      Utils.getTranslatedLanguage(language, "Subject").then((value) {
        subject = value;
      });

      Utils.getTranslatedLanguage(language, "not assigned").then((value) {
        notAssigned = value;
      });

      Utils.getTranslatedLanguage(language, "Date").then((value) {
        date = value;
      });

      Utils.getTranslatedLanguage(language, "Action").then((value) {
        action = value;
      });
         Utils.getTranslatedLanguage(language, "Running").then((value) {
        running = value;
      });

      Utils.getTranslatedLanguage(language, "Pending").then((value) {
        pending = value;
      });

      Utils.getTranslatedLanguage(language, "Closed").then((value) {
        closed = value;
      });

      Utils.getTranslatedLanguage(language, "Submitted").then((value) {
        submitted = value;
      });

      Utils.getTranslatedLanguage(language, "Active").then((value) {
        active = value;
      });
    
    });
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.exam.title == null ? notAssigned : widget.exam.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: ScreenUtil().setSp(15.0)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          subject,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.exam.subject == null ? notAssigned : widget.exam.subject,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          date,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          widget.exam.date == null ? notAssigned : widget.exam.date,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Text(
                  //         'Status',
                  //         maxLines: 1,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .headline4
                  //             .copyWith(fontWeight: FontWeight.w500),
                  //       ),
                  //       SizedBox(
                  //         height: 5.0,
                  //       ),
                  //       getExamStatusWidget(
                  //           context: context,
                  //           isRunning: exam.isRunning,
                  //           isClosed: exam.isClosed,
                  //           isWaiting: exam.isWaiting),
                  //     ],
                  //   ),
                  // ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          action,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        getStatus(context, widget.exam.status, widget.exam.isRunning,
                            widget.exam.isClosed),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              margin: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.purple, Colors.deepPurple]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getExamStatusWidget(
      {BuildContext context, int isRunning, int isWaiting, int isClosed}) {
    if (isRunning == 1) {
      return Text(
        running,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .headline4
            .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      );
    } else if (isWaiting == 1) {
      return Text(
        pending,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .headline4
            .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      );
    } else if (isClosed == 1) {
      return Text(
        closed,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .headline4
            .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      );
    } else {
      return Text(
        notAssigned,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: Theme.of(context)
            .textTheme
            .headline4
            .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      );
    }
  }

  Widget getStatus(
      BuildContext context, int status, int isRunning, int isClosed) {
    if (status == 1) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.green.shade500),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            submitted,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else if (status == 0) {
      if (isClosed == 0) {
        return InkWell(
          onTap: () {
            print('Active'); // TODO:: ONLINE EXAM TAKE
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.indigo.shade500),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                active,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        );
      } else {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.red.shade500),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              closed,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        );
      }
    } else {
      return Container();
    }
  }
}
