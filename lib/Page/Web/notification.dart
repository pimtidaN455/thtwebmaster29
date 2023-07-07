// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import '../SildePage/nevigator.dart';
import 'addweb.dart';
import 'mainpage.dart';
import 'pagesmall.dart';
import '../../Design/design_course_app_theme.dart';
import 'package:get/get.dart';

class NotiView extends StatefulWidget {
  const NotiView({Key? key, this.callBack}) : super(key: key);
  final Function()? callBack;
  @override
  _NotiViewState createState() => _NotiViewState();
}

class _NotiViewState extends State<NotiView> {
  String? _imageProfile;
  int notificationCount = 0;
  List<String>? _controller2 = [];
  static var decodedMap3;
  static List decodedMap22 = [];

  @override
void didChangeDependencies(){
  _loadData();
  super.didChangeDependencies();
}

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _controller2 = prefs.getStringList("cart");
    decodedMap22.clear();
    List<String>? cart2 = prefs.getStringList("cart");
    if (cart2 == null) {
    } else {
      int nubcart2 = prefs.get("nub") as int;
      for (int i = 0; i < nubcart2; i++) {
        decodedMap3 = jsonDecode(cart2[i]);
        decodedMap22.add(decodedMap3);
      }
    }
    setState(() {
      _imageProfile = prefs.getString("profilImage");
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 50,
                ),
                Container(
                  width: 60,
                  height: 60,
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: _imageProfile == null
                            ? AssetImage("assets/images/rabbit.jpg")
                            //: AssetImage("assets/logojoblucky.png"),
                            : FileImage(File(_imageProfile!)) as ImageProvider,
                        fit: BoxFit.cover,
                        width: 128,
                        height: 128,
                        child: InkWell(),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Stack(
                    children: [
                      Icon(Icons.notifications),
                      if (notificationCount > 0)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              notificationCount.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onPressed: () {
                    // จัดการเมื่อผู้ใช้คลิกที่ไอคอนแจ้งเตือน
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
    /*
     return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Hi!',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  _FnameProfile.toString() + " " + _LnameProfile.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 60,
            height: 60,
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: _imageProfile == null
                      ? AssetImage("assets/images/rabbit.jpg")
                      //: AssetImage("assets/logojoblucky.png"),
                      : FileImage(File(_imageProfile!)) as ImageProvider,
                  fit: BoxFit.cover,
                  width: 128,
                  height: 128,
                  child: InkWell(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
    */
  }
}
