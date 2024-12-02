// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:infixedu/utils/model/ClassExamList.dart';
import '../FunctinsData.dart';
import '../Utils.dart';

// ignore: must_be_immutable
class StudentExamRow extends StatefulWidget {
  classExam exam;

  StudentExamRow(this.exam);

  @override
  _StudentExamRowState createState() => _StudentExamRowState();
}

class _StudentExamRowState extends State<StudentExamRow> {
  String roomNo = "Room No";

  String date = "Date";

  String start = "Start";

  String end = 'End';
  String subject = 'Subject';

  @override
  void initState() {
    Utils.getStringValue('lang').then((language) {
      Utils.getTranslatedLanguage(language, "Room No").then((val) {
        setState(() {
          roomNo = val;
        });
      });

      Utils.getTranslatedLanguage(language, "Date").then((val) {
        setState(() {
          date = val;
        });
      });
       Utils.getTranslatedLanguage(language, "Subject").then((val) {
        setState(() {
          subject = val;
        });
      });

      Utils.getTranslatedLanguage(language, "Start").then((val) {
        setState(() {
          start = val;
        });
      });
      Utils.getTranslatedLanguage(language, "End").then((val) {
        setState(() {
          end = val;
        });
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
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              // color: Colors.purple,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    subject,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    widget.exam.subjectName == null
                        ? 'N/A'
                        : widget.exam.subjectName,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          roomNo,
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
                          widget.exam.roomNo == null
                              ? 'N/A'
                              : widget.exam.roomNo,
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
                          widget.exam.date == null ? 'N/A' : widget.exam.date,
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
                          start,
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
                          widget.exam.startTime == null
                              ? 'N/A'
                              : AppFunction.getAmPm(widget.exam.startTime),
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
                          end,
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
                          widget.exam.endTime == null
                              ? 'N/A'
                              : AppFunction.getAmPm(widget.exam.endTime),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 0.5,
            //   margin: EdgeInsets.only(top: 10.0),
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.centerRight,
            //         end: Alignment.centerLeft,
            //         colors: [Colors.purple, Colors.deepPurple]),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
