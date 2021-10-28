// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
// import 'package:infixedu/config/app_config.dart';
// import 'package:infixedu/screens/student/album/photos.dart';
// import 'package:infixedu/utils/CustomAppBarWidget.dart';
// import 'package:http/http.dart' as http;
// import 'package:infixedu/utils/Utils.dart';
// import 'package:infixedu/utils/apis/Apis.dart';
// import 'package:infixedu/utils/widget/ScaleRoute.dart';

// // ignore: must_be_immutable
// class Events extends StatefulWidget {
//   String id;
//   String profileName;
//   Events({this.id, this.profileName});
//   @override
//   _EventsState createState() => _EventsState();
// }

// class _EventsState extends State<Events> {
//   String description = "Description";
//   String evntLoc = "Event Location";
//   String startDate = "Start Date";
//   String endDate = "End Date";

//   initState() {
//     super.initState();
//     Utils.getStringValue('lang').then((language) {
//       Utils.getTranslatedLanguage(language, "Description").then((value) {
//         setState(() {
//           description = value;
//         });
//       });

//       Utils.getTranslatedLanguage(language, "Event Location").then((value) {
//         setState(() {
//           evntLoc = value;
//         });
//       });

//       Utils.getTranslatedLanguage(language, "Start Date").then((value) {
//         setState(() {
//           startDate = value;
//         });
//       });

//       Utils.getTranslatedLanguage(language, "End Date").then((value) {
//         setState(() {
//           endDate = value;
//         });
//       });
//     });
//   }

//   loadData() async {
//     var response = await http.get(Uri.parse(InfixApi.getEvents));
//     Map<String, dynamic> decodedJson = json.decode(response.body);
//     List<dynamic> responseData = decodedJson['data'];
//     return responseData;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double statusBarHeight = MediaQuery.of(context).padding.top;
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
//       statusBarColor: AppConfig.primary, //or set color with: Color(0xFF0000FF)
//     ));

//     String imgUrl = "https://admin.scoolspro.com/";
//     return Padding(
//       padding: EdgeInsets.only(top: statusBarHeight),
//       child: Scaffold(
//           appBar: CustomAppBarWidget(title: 'Events'),
//           body: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Container(
//               color: Colors.grey[100],
//               child: FutureBuilder(
//                   future: loadData(),
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     print(snapshot.data);
//                     if (snapshot.hasData) {
//                       return GridView.builder(
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 1,
//                             childAspectRatio: 0.8,
//                           ),
//                           itemCount: snapshot.data.length,
//                           itemBuilder: (context, index) {
//                             //  print('--/>' + snapshot.data.toString());
//                             // print('Snpshot type -> ' +
//                             //    snapshot.data.runtimeType.toString());
//                             if (snapshot.hasData) {
//                               return GestureDetector(
//                                 child: Container(
//                                   child: TextTilePage(
//                                       imgAdd: (imgUrl +
//                                           snapshot.data[index]
//                                               ['uplad_image_file']),
//                                       title: snapshot.data[index]
//                                           ['event_title'],
//                                       description: snapshot.data[index]
//                                           ['event_des'],
//                                       eventLocation: snapshot.data[index]
//                                           ['event_location'],
//                                       startDate: snapshot.data[index]
//                                           ['from_date'],
//                                       endDate: snapshot.data[index]['to_date']),
//                                 ),
//                               );
//                             } else {
//                               return Center(
//                                 child: CircularProgressIndicator(
//                                   color: Colors.blueAccent,
//                                 ),
//                               );
//                             }
//                           });
//                     } else {
//                       return Center(
//                           child: CircularProgressIndicator(
//                         color: Color(0xff3575B6),
//                       ));
//                     }
//                   }),
//             ),
//           )),
//     );
//   }

//   Widget _buildChip(String label, String count, Color color) {
//     return Chip(
//       labelPadding: EdgeInsets.all(3.0),
//       label: Text(
//         label,
//         style: TextStyle(
//           color: Colors.white,
//         ),
//       ),
//       avatar: CircleAvatar(
//         backgroundColor: Colors.white70,
//         child: Text(count.toString()),
//       ),
//       backgroundColor: color,
//       elevation: 6.0,
//       shadowColor: Colors.grey[40],
//       padding: EdgeInsets.all(8.0),
//     );
//   }
// }

// class TextTilePage extends StatefulWidget {
//   TextTilePage(
//       {Key key,
//       this.imgAdd,
//       this.title,
//       this.description,
//       this.eventLocation,
//       this.startDate,
//       this.endDate})
//       : super(key: key);
//   String imgAdd;
//   String title;
//   String description;
//   String eventLocation;
//   String startDate;
//   String endDate;

//   @override
//   _TextTilePageState createState() => _TextTilePageState();
// }

// class _TextTilePageState extends State<TextTilePage> {
//   static final double radius = 20;

//   UniqueKey keyTile;
//   bool isExpanded = false;

//   void expandTile() {
//     setState(() {
//       isExpanded = true;
//       keyTile = UniqueKey();
//     });
//   }

//   void shrinkTile() {
//     setState(() {
//       isExpanded = false;
//       keyTile = UniqueKey();
//     });
//   }

//   @override
//   Widget build(BuildContext context) => Container(
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(radius),
//             side: BorderSide(color: Colors.white, width: 2),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(radius),
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               child: Column(
//                 children: [
//                   GestureDetector(
//                     onTap: () => isExpanded ? shrinkTile() : expandTile(),
//                     child: buildImage(widget.imgAdd),
//                   ),
//                   buildText(context),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//   Widget buildImage(String imgAdd) => Image.network(
//         imgAdd,
//         fit: BoxFit.cover,
//         width: double.infinity,
//         height: 400,
//       );

//   Widget buildText(BuildContext context) => Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           key: keyTile,
//           initiallyExpanded: isExpanded,
//           childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
//           title: Text(
//             widget.title,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//           ),
//           children: [
//             Text(
//               widget.description,
//               style: TextStyle(fontSize: 14, height: 1.4),
//             ),
//             Divider(
//               color: Color(0xffF4F4F4),
//               thickness: 2,
//             ),
//             Text(
//               "Event Location : " + widget.eventLocation,
//               style: TextStyle(fontSize: 14, height: 1.4),
//             ),
//             Divider(
//               color: Color(0xffF4F4F4),
//               thickness: 2,
//             ),
//             Text(
//               "Start Date : " + widget.startDate,
//               style: TextStyle(fontSize: 14, height: 1.4),
//             ),
//             Divider(
//               color: Color(0xffF4F4F4),
//               thickness: 2,
//             ),
//             Text(
//               "End Date : " + widget.endDate,
//               style: TextStyle(fontSize: 14, height: 1.4),
//             ),
//           ],
//           // onExpansionChanged: (isExpanded) => Utils.showSnackBar(
//           //   context,
//           //   text: isExpanded ? 'Expand Tile' : 'Shrink Tile',
//           //   color: isExpanded ? Colors.green : Colors.red,
//           // ),
//         ),
//       );
// }
