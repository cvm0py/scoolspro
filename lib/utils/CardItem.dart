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
          //height: 200.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color:
                   // widget.isSelected ? AppConfig.primary: AppConfig.primary,
                    widget.isSelected ? Colors.blueAccent : Colors.blueAccent,
                blurRadius: 9.0,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppConfig.primary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                            fontSize: MediaQuery.of(context).size.height *
                                0.02, //ScreenUtil().setSp(14),
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
                          padding: const EdgeInsets.only(top: 5.0),
                          //color: Colors.green,
                          color: AppConfig.primary,
                          height: MediaQuery.of(context).size.height * 0.055,
                          width: MediaQuery.of(context).size.width * 0.12,
                          child: Image.asset(
                            widget.icon.toString(),
                            // fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
