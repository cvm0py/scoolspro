import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/config/app_config.dart';
import 'package:infixedu/screens/student/album/photos.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:http/http.dart' as http;
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
                      return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            print('--/>' + snapshot.data.toString());
                            print('Snpshot type -> ' +
                                snapshot.data.runtimeType.toString());
                            if (snapshot.hasData) {
                              return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              snapshot.data[index]['event_title']
                                                  .toString(),
                                              style: TextStyle(
                                                color: Color(0xff3575B6),
                                                fontSize: 18,
                                                fontFamily:
                                                    AppConfig.quicksandFont,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              //maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppConfig.primary,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            width:
                                                MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.3,
                                            child: (snapshot.data[index][
                                                            'uplad_image_file'] !=
                                                        null ||
                                                    snapshot.data[index][
                                                            'uplad_image_file'] !=
                                                        '')
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    child: Image.network(
                                                      "https://admin.scoolspro.com/" +
                                                          snapshot.data[index][
                                                              'uplad_image_file'],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    child: Image.asset(
                                                        'images/assets/event.jpg',
                                                        fit: BoxFit.cover),
                                                  ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Description',
                                              style: TextStyle(
                                                color: AppConfig.primary,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              snapshot.data[index]['event_des']
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppConfig.quicksandFont,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              //maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text('Event Location',
                                              style: TextStyle(
                                                color: AppConfig.primary,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              snapshot.data[index]
                                                      ['event_location']
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppConfig.quicksandFont,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              //maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text('Start Date',
                                              style: TextStyle(
                                                color: AppConfig.primary,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              snapshot.data[index]['from_date']
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppConfig.quicksandFont,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              //maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('End Date',
                                              style: TextStyle(
                                                color: AppConfig.primary,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              snapshot.data[index]['to_date']
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily:
                                                    AppConfig.quicksandFont,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              //maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
                        color: Color(0xff3575B6),
                      ));
                    }
                  }),
            ),
          )),
    );
  }

  Widget _buildChip(String label, String count, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(3.0),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(count.toString()),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[40],
      padding: EdgeInsets.all(8.0),
    );
  }
}
