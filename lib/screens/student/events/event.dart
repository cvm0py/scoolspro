import 'dart:convert';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/screens/student/album/photos.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

// ignore: must_be_immutable
class Events extends StatefulWidget {
  String id;
  String profileName;
  Events({this.id, this.profileName});
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  String description = "Description";
  String evntLoc = "Event Location";
  String startDate = "Start Date";
  String endDate = "End Date";

  initState() {
    super.initState();
    Utils.getStringValue('lang').then((language) {
      Utils.getTranslatedLanguage(language, "Description").then((value) {
        setState(() {
          description = value;
        });
      });

      Utils.getTranslatedLanguage(language, "Event Location").then((value) {
        setState(() {
          evntLoc = value;
        });
      });

      Utils.getTranslatedLanguage(language, "Start Date").then((value) {
        setState(() {
          startDate = value;
        });
      });

      Utils.getTranslatedLanguage(language, "End Date").then((value) {
        setState(() {
          endDate = value;
        });
      });
    });
  }

  loadData() async {
    var response = await http.get(Uri.parse(InfixApi.getEvents));
    Map<String, dynamic> decodedJson = json.decode(response.body);
    List<dynamic> responseData = decodedJson['data'];
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: AppConfig.primary, //or set color with: Color(0xFF0000FF)
    ));

    String imgUrl = "https://admin.scoolspro.com/";
    return Padding(
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Scaffold(
          appBar: CustomAppBarWidget(title: 'Events'),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              color: Colors.grey[100],
              child: FutureBuilder(
                  future: loadData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print(snapshot.data);
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            if (snapshot.hasData) {
                              return GestureDetector(
                                child: Container(
                                  child: TextTilePage(
                                     evntLoc: evntLoc, startDate:startDate,
                                     endDate: endDate,
                                      imgAdd: (imgUrl +
                                          snapshot.data[index]
                                              ['uplad_image_file']),
                                      title: snapshot.data[index]
                                          ['event_title'],
                                      description: snapshot.data[index]
                                          ['event_des'],
                                      eventLocation: snapshot.data[index]
                                          ['event_location'],
                                      startDat: snapshot.data[index]
                                          ['from_date'],
                                      endDat: snapshot.data[index]['to_date']),
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blueAccent,
                                ),
                              );
                            }
                          });
                    } else {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppConfig.primary,
                      ));
                    }
                  }),
            ),
          )),
    );
  }
}

class TextTilePage extends StatefulWidget {
  TextTilePage(
      {Key key,
      this.evntLoc,
      this.startDate,
      this.endDate,
      this.imgAdd,
      this.title,
      this.description,
      this.eventLocation,
      this.startDat,
      this.endDat})
      : super(key: key);
  String evntLoc;
  String startDate;
  String endDate;
  String imgAdd;
  String title;
  String description;
  String eventLocation;
  String startDat;
  String endDat;

  @override
  _TextTilePageState createState() => _TextTilePageState();
}

class _TextTilePageState extends State<TextTilePage> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: AppConfig.primary,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       Container(
                         padding: EdgeInsets.all(4),
                         width:MediaQuery.of(context).size.width *0.15,
                         color:AppConfig.primary,
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                              Text(
                            
                            
                          widget.startDat[5] + widget.startDat[6],
                       // "21",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                      ),
                             Text(
                              //AppFunction.getMonth(int.parse(widget.startDat[3]+ widget.startDat[4])),
                              "Jan",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                      ),
                           ],
                         ),
                       ),
                       SizedBox(width:5),
                      Container(
                        width: MediaQuery.of(context).size.width *0.55,
                        child: Text(
                          widget.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                collapsed: Text(
                  widget.startDat + " to " + widget.endDat,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Column(
                  children: [
                    Image.network(widget.imgAdd,
                        fit: BoxFit.cover, width: double.infinity, height: 400),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 14, height: 1.4),
                    ),
                    Divider(
                      color: Color(0xffF4F4F4),
                      thickness: 2,
                    ),
                    Center(
                        child: RichText(
                            text: TextSpan(
                      text: widget.evntLoc + " : ",
                      style: TextStyle(color: AppConfig.primary, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.eventLocation,
                          style: TextStyle(
                              height: 1.4, color: Colors.black54, fontSize: 14),
                        )
                      ],
                    ))),
                    Divider(
                      color: Color(0xffF4F4F4),
                      thickness: 2,
                    ),
                    Center(
                        child: RichText(
                            text: TextSpan(
                      text:  widget.startDate + " : ",
                      style: TextStyle(color: AppConfig.primary, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.startDat,
                          style: TextStyle(
                              height: 1.4, color: Colors.black54, fontSize: 14),
                        )
                      ],
                    ))),
                    Divider(
                      color: Color(0xffF4F4F4),
                      thickness: 2,
                    ),
                    Center(
                        child: RichText(
                            text: TextSpan(
                      text:  widget.endDate + " : ",
                      style: TextStyle(color: AppConfig.primary, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.endDat,
                          style: TextStyle(
                              height: 1.4, color: Colors.black54, fontSize: 14),
                        )
                      ],
                    ))),
                  ],
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildImage(String imgAdd) => Image.network(
        imgAdd,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 400,
      );
}
