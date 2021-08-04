// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infixedu/config/app_config.dart';

// Project imports:
import 'Utils.dart';

class CustomWidget extends StatefulWidget {
  final int index;
  final bool isSelected;
  final VoidCallback onSelect;
  final String headline;
  final String icon;

  const CustomWidget({
    Key key,
    @required this.index,
    @required this.isSelected,
    @required this.onSelect,
    @required this.headline,
    @required this.icon,
  })  : assert(index != null),
        assert(isSelected != null),
        assert(onSelect != null),
        super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  String title;

  @override
  Widget build(BuildContext context) {
    //print(widget.icon.toString());

    Utils.getStringValue('lang').then((value) {
      if (value == null) {
        Utils.getTranslatedLanguage('en', widget.headline).then((val) {
          print(val);
          title = val;
        });
      } else {
        Utils.getTranslatedLanguage(value, widget.headline).then((val) {
          //print(val);
          setState(() {
            title = val;
          });
        });
      }
    });
    return GestureDetector(
      onTap: widget.onSelect,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                    //widget.isSelected ? Color(0xffc8abfc) : Color(0xffc8abfc),
                    widget.isSelected ? Colors.blueAccent : Colors.blueAccent,
                blurRadius: 9.0,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              /*gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFCCCCFF), Colors.white]),*/
              color: Color(0xff3575B6),
              borderRadius: BorderRadius.circular(10.0),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.deepPurple.withOpacity(0.3),
              //     spreadRadius: 2,
              //     blurRadius: 1,
              //     offset: Offset(1, 1), // changes position of shadow
              //   ),
              // ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title != null ? " " + title : '...',
                        style: TextStyle(
                          fontFamily: "QuickSand",
                          letterSpacing: 1.4,
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.w500,
                        ),
                        // maxLines: 1,
                      ),
                      SizedBox(
                        width: 1,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        //color: Colors.green,
                        color: Color(0xff3575B6),
                        height: 45,
                        width: 45,
                        child: Image.asset(
                          //widget.icon.toString(),
                          // 'assets/images/profile_unseen.gif',
                          //'assets/images/attendance.gif',
                            widget.icon.toString(),
                          // 'assets/images/students.png',

                         // 'assets/images/about_us.png',

                         //color: Colors.green,

                          // width: 75,
                          // height: 75,
                          fit: BoxFit.fill,
                        ),
                      ),
                      //child: Image.network('https://drive.google.com/file/d/1_lJeRPe2lHIQVST1I6oS-XJpcr8U-ygb/view?usp=sharing',),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
