// ignore_for_file: prefer_const_constructors

import 'dart:convert';
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

class RengView extends StatefulWidget {
  const RengView({Key? key, this.callBack}) : super(key: key);

  final Function()? callBack;
  @override
  _RengViewState createState() => _RengViewState();
}

class _RengViewState extends State<RengView> {
    TextEditingController web = TextEditingController();
  TextEditingController passweb = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String? _selectedCity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "ทั้งหมดจำนวณ ___ เว็บ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: ClipOval(
              child: Material(
                color: Color.fromARGB(0, 255, 255, 255),
                child: IconButton(
                  iconSize: 27,
                  icon: const Icon(Icons.add_circle,
                      color: Color.fromARGB(255, 129, 209, 18)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        //barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(24),
                              ),
                            ),
                            // backgroundColor: Colors.black87,
                            titlePadding: EdgeInsets.all(0),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      size: 25,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Center(
                                  child: Text("ใส่ชื่อเว็บไซต์",
                                      style: TextStyle(
                                        //fontFamily: 'TTNorms',
                                        fontWeight: FontWeight.bold,
                                        wordSpacing: 0,
                                        letterSpacing: 0,
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "ตัวอย่างเช่น : helloworld.com",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 21, 191, 6),
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  onChanged: (value) {},
                                  controller: web,
                                  decoration: InputDecoration(
                                      hintText: "   helloworld.com"),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  onChanged: (value) {},
                                  controller: passweb,
                                  decoration:
                                      InputDecoration(hintText: "   password"),
                                ),
                                SizedBox(height: 10),
                                TextButton(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 51, 114, 11),
                                      ),
                                    ),
                                    onPressed: () async {
                                     addweb(web:web , passweb:passweb);
                                     

                                    }),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ),
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: ClipOval(
              child: Material(
                color: Color.fromARGB(0, 255, 255, 255),
                child: IconButton(
                  iconSize: 27,
                  icon: const Icon(Icons.remove_circle,
                      color: Color.fromARGB(255, 195, 8, 8)),
                  onPressed: () async{
                     SharedPreferences pref =
                      await SharedPreferences.getInstance();
                     pref.remove("cart");
                     pref.remove("nub");
                  },
                ),
              ),
            ),
          ),
          PopupMenuButton(
            icon: Icon(
              Icons.filter_list,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 0,
                child: Text('เรียงเว็บจาก ชื่อเว็บ a-z'),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text('เรียงเว็บจาก ชื่อเว็บ z-a'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('เรียงเว็บจาก วันหมดอายุ น้อย - มาก'),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text('เรียงเว็บจาก วันหมดอายุ มาก - น้อย'),
              ),
            ],
          ),
          Container(
            width: 60,
            height: 60,
            child: ClipOval(
              child: Material(
                color: Color.fromARGB(0, 255, 255, 255),
                child: IconButton(
              icon: Icon(
                Icons.restore,
                //color: MyStyle().blackColor,
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationHomeScreen(
                           )));
              },
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
  }
}

