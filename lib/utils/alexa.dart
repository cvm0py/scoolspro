import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';

class Alexa extends StatefulWidget {
  String id;
  Alexa({Key key, this.id}) : super(key: key);

  @override
  _AlexaState createState() => _AlexaState();
}

class _AlexaState extends State<Alexa> {
  //  final double statusBarHeight = MediaQuery.of(context).padding.top;

  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
  //     statusBarColor: AppConfig.primary, //or set color with: Color(0xFF0000FF)
  //   ));
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 50),
        child: Scaffold(
            backgroundColor: Colors.blue[50],
            appBar: CustomAppBarWidget(
              title: 'Alexa',
            ),
            body: Container(
              color: Colors.lightBlue[50],
              child: Container(
                child: Image.asset("assets/images/alexaDemo.png"),
              ),
            )));
  }
}
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     Note task = Note(name: "Run", description: "Run a 40 mile marathon");
//     return ScopedModelDescendant<NotesModel>(builder: (context, child, model) {
//       //scoped model descendants helps to pass data to the children widgets.
//       return Scaffold(
//         appBar: AppBar(
//           // Here, we take the value from the MyHomePage object that was created by
//           // the App.build method, and use it to set our appbar title.
//           title: Text(widget.title),
//         ),
//         body: ListView.builder(
//             padding: EdgeInsets.all(5.0),
//             itemCount: model.list.length, //calculating length ist
//             itemBuilder: (BuildContext context, index) {
//               return Column(
//                 children: <Widget>[
//                   ListTile(
//                       leading: Image.network(
//                         //fetching online images
//                         "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Noto_Emoji_KitKat_263a.svg/1200px-Noto_Emoji_KitKat_263a.svg.png",
//                         height: 20.0,
//                         width: 20.0,
//                       ),
//                       title: Text(model.list[index]
//                           .name) //retrieving object's name from list

//                       ),
//                   Divider()
//                 ],
//               );
//             }),

//         floatingActionButton: FloatingActionButton(
//           //objects will be added to the database when this button is clicked.
//           onPressed: () {
//             model.addNote(task); //this method is executed when the floating button is clicked
//           },
//           tooltip: 'Add to list new object',
//           child: Icon(Icons.add),
//         ), // This trailing comma makes auto-formatting nicer for build methods.
//       );
//     });
//   }
// }
// import 'note.dart';

// class NotesModel extends Model{
//   List<Note> _list = []; //list that stores Note objects

//   List<Note> get list{ //returns a copy of list
//     return [..._list];
//   }
//     void addNote(Note note){ //adds a Note object to list
//         _list.add(note);
//         notifyListeners();
//     }

//   void removeNote(Note note){
//     _list.remove(note); //removes a Note object from list
//     notifyListeners();
//   }