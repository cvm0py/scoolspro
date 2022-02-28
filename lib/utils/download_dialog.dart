// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:infixedu/screens/student/studyMaterials/StudyMaterialViewer.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

class DownloadDialog extends StatefulWidget {
  DownloadDialog({this.file, this.title});

  final String file;
  final String title;

  @override
  _DownloadDialogState createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  var progress = "Download";
  String downloadComplete =
      "Download Completed. File is also available in your download folder.";
  String downloading = "Downloading...";
  String download = "Download";
  String downloadQues = "Would you like to download the file?";
  String no = "No";
  String file = 'no file found';
  String dialog='dialog';
  var received;

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
        // setState(() {
        //   progress =
        //       ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
        // });
        if (received == 100.0) {
          if (url.contains('.pdf')) {
            Utils.showToast(downloadComplete);
            Navigator.push(
                context,
                ScaleRoute(
                    page: DownloadViewer(
                        title: title, filePath: InfixApi.root + url)));
          } else {
            var file =
                await DefaultCacheManager().getSingleFile(InfixApi.root + url);
            OpenFile.open(file.path);

            Utils.showToast(downloadComplete);
          }
        }
      });
    } catch (e) {
      print(e);
    }
    // progress = "Download Completed.Go to the download folder to find the file";
  }

   @override
  void initState() {

     Utils.getStringValue('lang').then((language) {
      Utils.getTranslatedLanguage(language, "Download Completed. File is also available in your download folder.").then((value) {
        downloadComplete = value;
      });

     Utils.getTranslatedLanguage(language, "Downloading...").then((value) {
        downloading = value;
      });
       Utils.getTranslatedLanguage(language, "Download").then((value) {
        download = value;
      });

       Utils.getTranslatedLanguage(language, "Would you like to download the file?").then((value) {
        downloadQues = value;
      });

       Utils.getTranslatedLanguage(language, "No").then((value) {
        no = value;
      });

       Utils.getTranslatedLanguage(language, "no file found").then((value) {
        file = value;
      });

       Utils.getTranslatedLanguage(language, "dialog").then((value) {
        dialog = value;
      });
    
    });


    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        download,
        style: Theme.of(context).textTheme.headline5,
      ),
      content: Text(downloadQues),
      actions: [
        TextButton(
          child: Text(no),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
        ),
        TextButton(
          child: Text(download),
          onPressed: () {
            widget.file != null
                ? downloadFile(widget.file, context, widget.title)
                : Utils.showToast(file);
            Navigator.of(context, rootNavigator: true).pop(dialog);
          },
        ),
      ],
    );
  }
}
