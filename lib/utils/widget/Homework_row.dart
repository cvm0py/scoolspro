// Dart imports:
import 'dart:io';
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permissions_plugin/permissions_plugin.dart';

// Project imports:
import 'package:infixedu/screens/student/homework/UploadHomework.dart';
import 'package:infixedu/screens/student/studyMaterials/StudyMaterialViewer.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/model/StudentHomework.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

// ignore: must_be_immutable
class StudentHomeworkRow extends StatefulWidget {
  Homework homework;
  String type;

  StudentHomeworkRow(this.homework, this.type);

  @override
  _StudentHomeworkRowState createState() => _StudentHomeworkRowState();
}

class _StudentHomeworkRowState extends State<StudentHomeworkRow> {
  var progress = "Download";

  var received;

  Random random = Random();

  GlobalKey _globalKey = GlobalKey();
  String _id;
  String created = 'Created';
  String submission = 'Submission';
  String evaluation = 'Evaluation';
  String status = 'Status';
  String marks = 'Marks';
  String notassigned = 'not assigned';
  String upload = 'Upload';
  String incomplete = 'Incomplete';
  String completed = 'Completed';
  String no = 'No';
  String download = 'Download';
  String wouldYou = "Would you like to download the file?";
  String downloading = "Downloading...";
  String downloadCompleted =
      "Download Completed. File is also available in your download folder.";
  String youMust = 'You must grant all permission to use this application';
  String permissionDenied = 'Permission Denied';

  @override
  void initState() {
    Utils.getStringValue('id').then((value) {
      _id = value;
    });
    Utils.getStringValue('lang').then((language) {
      Utils.getTranslatedLanguage(language, 'Created').then((value) {
        setState(() {
          created = value;
        });
      });

      Utils.getTranslatedLanguage(language, 'Submission').then((value) {
        setState(() {
          submission = value;
        });
      });

      Utils.getTranslatedLanguage(language, 'Evaluation').then((value) {
        setState(() {
          evaluation = value;
        });
      });

      Utils.getTranslatedLanguage(language, 'Status').then((value) {
        setState(() {
          status = value;
        });
      });

      Utils.getTranslatedLanguage(language, 'Marks').then((value) {
        setState(() {
          marks = value;
        });
      });

      Utils.getTranslatedLanguage(language, 'not assigned').then((value) {
        setState(() {
          notassigned = value;
        });
      });

      Utils.getTranslatedLanguage(language, "Upload").then((value) {
        setState(() {
          upload = value;
        });
      });
      Utils.getTranslatedLanguage(language, "Incomplete").then((value) {
        setState(() {
          incomplete = value;
        });
      });
      Utils.getTranslatedLanguage(language, "Completed").then((value) {
        setState(() {
          completed = value;
        });
      });

      Utils.getTranslatedLanguage(language, "No").then((value) {
        setState(() {
          no = value;
        });
      });

      Utils.getTranslatedLanguage(language, 'Download').then((value) {
        setState(() {
          download = value;
        });
      });

      Utils.getTranslatedLanguage(
              language, "Would you like to download the file?")
          .then((value) {
        setState(() {
          wouldYou = value;
        });
      });

      Utils.getTranslatedLanguage(language, "Downloading...").then((value) {
        setState(() {
          downloading = value;
        });
      });

      Utils.getTranslatedLanguage(language,
              "Download Completed. File is also available in your download folder.")
          .then((value) {
        setState(() {
          downloadCompleted = value;
        });
      });

      Utils.getTranslatedLanguage(language, permissionDenied).then((value) {
        setState(() {
          permissionDenied = value;
        });
      });

      Utils.getTranslatedLanguage(
              language, "You must grant all permission to use this application")
          .then((value) {
        setState(() {
          youMust = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            showAlertDialog(context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.homework.subjectName,
                      style: Theme.of(context).textTheme.headline6.copyWith(),
                    ),
                  ),
                  // Container(
                  //   child: GestureDetector(
                  //     onTap: () {

                  //     },
                  //     child: Text(
                  //       'View',
                  //       textAlign: TextAlign.end,
                  //       style: Theme.of(context).textTheme.headline6.copyWith(
                  //           color: Colors.blue,
                  //           decoration: TextDecoration.underline),
                  //     ),
                  //   ),
                  // ),
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
                            created,
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
                            widget.homework.homeworkDate == null
                                ? 'N/A'
                                : widget.homework.homeworkDate,
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
                            submission,
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
                            widget.homework.submissionDate == null
                                ? 'N/A'
                                : widget.homework.submissionDate,
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
                            evaluation,
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
                            widget.homework.evaluationDate == null
                                ? 'N/A'
                                : widget.homework.evaluationDate,
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
                            status,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          getStatus(context, widget.homework.status),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    marks,
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
                    widget.homework.marks == null
                        ? notassigned
                        : widget.homework.marks.toString(),
                    maxLines: 1,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              // widget.homework.obtainedMarks == ""
              //     ?
              //     : Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             'Obtained Marks',
              //             maxLines: 1,
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .headline4
              //                 .copyWith(fontWeight: FontWeight.w500),
              //           ),
              //           SizedBox(
              //             height: 10.0,
              //           ),
              //           Text(
              //             widget.homework.obtainedMarks == null
              //                 ? 'not assigned'
              //                 : widget.homework.obtainedMarks.toString(),
              //             maxLines: 1,
              //             style: Theme.of(context).textTheme.headline4,
              //           ),
              //         ],
              //       ),
              Container(
                height: 0.5,
                margin: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [Colors.blue, Colors.blueAccent]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.homework.subjectName,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          Text(
                            marks + ": " + widget.homework.marks,
                            style: Theme.of(context).textTheme.headline5,
                            maxLines: 1,
                          )
                          // widget.homework.obtainedMarks == ""
                          //     ?
                          //     : Text(
                          //         "Obtained Marks: " +
                          //             widget.homework.obtainedMarks,
                          //         style: Theme.of(context).textTheme.headline5,
                          //         maxLines: 1,
                          //       )
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
                                    created,
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
                                    widget.homework.homeworkDate,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    submission,
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
                                    widget.homework.submissionDate,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    evaluation,
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
                                    widget.homework.evaluationDate == null
                                        ? notassigned
                                        : widget.homework.evaluationDate,
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ],
                              ),
                            ),
                            widget.type == 'student'
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          status,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        getStatus(
                                            context, widget.homework.status),
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                widget.homework.description == null
                                    ? ''
                                    : widget.homework.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            widget.homework.fileUrl == null ||
                                    widget.homework.fileUrl == ''
                                ? Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: ScreenUtil().setWidth(145),
                                      height: ScreenUtil().setHeight(40),
                                    ),
                                  )
                                : InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: ScreenUtil().setWidth(145),
                                      height: ScreenUtil().setHeight(40),
                                      decoration: Utils.gradientBtnDecoration,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.cloud_download),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            progress,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5
                                                .copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      checkPermissions(context);
                                      showDownloadAlertDialog(
                                          context, widget.homework.subjectName);
                                    },
                                  ),
                            widget.type == 'student'
                                ? widget.homework.status == "incompleted"
                                    ? InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: ScreenUtil().setWidth(145),
                                          height: ScreenUtil().setHeight(40),
                                          decoration:
                                              Utils.gradientBtnDecoration,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(Icons.cloud_upload),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                upload,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          showDialog<void>(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return UploadHomework(
                                                homework: widget.homework,
                                                userID: _id,
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : Container()
                                : Container()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getStatus(BuildContext context, String status) {
    //print('Status --> ' + status);
    if (status == 'incompleted') {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text(
            incomplete,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else if (status == 'Completed') {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.greenAccent),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text(
            completed,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  showDownloadAlertDialog(BuildContext context, String title) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(no),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );
    Widget yesButton = TextButton(
      child: Text(download),
      onPressed: () {
        widget.homework.fileUrl != null
            ? downloadFile(widget.homework.fileUrl, context, title)
            : Utils.showToast('no file found');
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        download,
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Text(wouldYou),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> downloadFile(
      String url, BuildContext context, String title) async {
    Dio dio = Dio();

    String dirloc = "";
    if (Platform.isAndroid) {
      dirloc = "/sdcard/download/";
    } else {
      dirloc = (await getApplicationDocumentsDirectory()).path;
    }
    Utils.showToast(dirloc);

    try {
      FileUtils.mkdir([dirloc]);
      Utils.showToast(downloading);

      await dio.download(
          InfixApi.root + url, dirloc + AppFunction.getExtention(url),
          options: Options(headers: {HttpHeaders.acceptEncodingHeader: "*"}),
          onReceiveProgress: (receivedBytes, totalBytes) async {
        received = ((receivedBytes / totalBytes) * 100);
        setState(() {
          progress =
              ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
        });
        if (received == 100.0) {
          if (url.contains('.pdf')) {
            Utils.showToast(downloadCompleted);
            Navigator.push(
                context,
                ScaleRoute(
                    page: DownloadViewer(
                        title: title, filePath: InfixApi.root + url)));
          } else {
            var file =
                await DefaultCacheManager().getSingleFile(InfixApi.root + url);
            OpenFile.open(file.path);

            Utils.showToast(downloadCompleted);
          }
        }
      });
    } catch (e) {
      print(e);
    }
    // progress = "Download Completed.Go to the download folder to find the file";
  }

  Future<void> checkPermissions(BuildContext context) async {
    Map<Permission, PermissionState> permission =
        await PermissionsPlugin.checkPermissions([
      Permission.WRITE_EXTERNAL_STORAGE,
    ]);

    if (permission[Permission.WRITE_EXTERNAL_STORAGE] !=
        PermissionState.GRANTED) {
      try {
        permission = await PermissionsPlugin.requestPermissions([
          Permission.WRITE_EXTERNAL_STORAGE,
        ]);
      } on Exception {
        debugPrint("Error");
      }

      if (permission[Permission.WRITE_EXTERNAL_STORAGE] ==
          PermissionState.GRANTED)
        print("write  permission ok");
      else
        permissionsDenied(context);
    } else {
      print("write permission ok");
    }
  }

  void permissionsDenied(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return SimpleDialog(
            title: Text(permissionDenied),
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
                child: Text(
                  youMust,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              )
            ],
          );
        });
  }
}
