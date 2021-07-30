import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';
import 'package:http/http.dart' as http;
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/widget/ScaleRoute.dart';

class Photos extends StatefulWidget {
  String id;

  Photos({this.id});
  @override
  _PhotosState createState() => _PhotosState();
}

class _PhotosState extends State<Photos> {
  loadData() async {
    var response =
        await http.get(Uri.parse(InfixApi.getPhotos(widget.id.toString())));
    // print('-->' + response.body.toString());
    Map<String, dynamic> decodedJson = json.decode(response.body);
    //print('-->' + decodedJson.toString());
    var responseData = decodedJson['data'];
    //print('->' + responseData.toString());
    return decodedJson['data']['photos'];
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Gallery'),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.85,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30))),
                                          child: Image.network(
                                            "https://admin.scoolspro.com/albums/" +
                                                snapshot.data[index]['image'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
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
      ),
    );
  }
}
