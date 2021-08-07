import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infixedu/screens/student/album/photos.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

import '../../nav_main.dart';

class Albums extends StatefulWidget {
  String id;

  Albums({this.id});
  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  loadData() async {
    var response = await http.get(Uri.parse(InfixApi.getAlbum));
    Map<String, dynamic> decodedJson = json.decode(response.body);
    List<dynamic> responseData = decodedJson['data'];
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: MainScreen(),
      appBar: CustomAppBarWidget(title: 'Albums'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
            color: Colors.grey[100],
            child: FutureBuilder(
                future: loadData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 1,
                        ),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          if (true) {
                            return GestureDetector(
                              onTap: () {
                                String idd =
                                    snapshot.data[index]['id'].toString();
                                Navigator.push(
                                    context,
                                    ScaleRoute(
                                        page: Photos(
                                      id: idd,
                                    )));
                              },
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
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Image.network(
                                            "https://admin.scoolspro.com/albums/" +
                                                snapshot.data[index]
                                                    ['cover_image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              snapshot.data[index]['name'],
                                              style: TextStyle(
                                                color: Color(0xff3575B6),
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Center(
                                                child: _buildChip(
                                                    " Image ",
                                                    snapshot
                                                        .data[index]['photos']
                                                        .length
                                                        .toString(),
                                                    Color(0xff3575B6))),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            snapshot.data[index]['description']
                                                .toString(),
                                            style: TextStyle(
                                              color: Color(0xff3575B6),
                                              fontSize: 12,
                                            ),
                                            maxLines: 1,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            print('hey');
                            return SizedBox(
                              height: 0.5,
                            );
                          }
                        });
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Color(0xff3575B6),
                    ));
                  }
                })),
      ),
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
