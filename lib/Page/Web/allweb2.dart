// ignore_for_file: prefer_const_constructors

import 'dart:async';
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

class AllWeb2 extends StatefulWidget {
  const AllWeb2({Key? key, this.callBack}) : super(key: key);
  final Function()? callBack;
  @override
  _AllWebState2 createState() => _AllWebState2();
}

class _AllWebState2 extends State<AllWeb2> {
  String? _controller;
  List<String>? _controller2 = [];
  bool tappedYes = false;
  TextEditingController web = TextEditingController();
  TextEditingController passweb = TextEditingController();
  static var decodedMap3;
  static List decodedMap22 = [];
  DateTime currentDate = DateTime.now();
  AnimationController? animationController;
  String? namewebwow;
    Timer? _timer;
  // ดึงรูปมาโชว์ //

  @override
  void initState() {
    super.initState();
    _startAutoUpdate(); 
  }
@override
  void dispose() {
    _stopAutoUpdate(); // หยุดการอัพเดตอัตโนมัติเมื่อวิดเจ็ตถูกทำลาย
    super.dispose();
  }

   void _startAutoUpdate() {
    const duration = Duration(seconds: 1); // กำหนดระยะเวลาในการอัพเดต (เช่นทุก 10 วินาที)
    _timer = Timer.periodic(duration, (timer) {
      _updateWidget(); // เรียกใช้งาน _updateWidget() เมื่อต้องการอัพเดต Widget
    });
  }

 void _stopAutoUpdate() {
    _timer?.cancel(); // ยกเลิกการทำงานของ Timer ถ้ามีการอัพเดตอัตโนมัติที่กำลังทำงาน
  }

 void _loadData() async {
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
      _controller = prefs.getString("profilImage");
      _controller2 = prefs.getStringList("cart");
    });
  }

   void _updateWidget() {
    setState(() {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(children: <Widget>[
              RengView(),
              Flexible(
                  child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                                child: _controller2 == null
                                    ? Text("ยังไม่มีเว็บไซต์")
                                    : GridView(
                                        padding: const EdgeInsets.all(8),
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10.0,
                                          crossAxisSpacing: 10.0,
                                          childAspectRatio: 0.8,
                                        ),
                                        children: <Widget>[
                                            if (_controller2 != null)
                                              for (int i = 0;
                                                  i < _controller2!.length;
                                                  i++)
                                                InkWell(
                                                  onTap: () {
                                                    FlutterWebBrowser.openWebPage(
                                                        url:
                                                            "https://www.${decodedMap22[i]["nameweb"]}");
                                                  },
                                                  splashColor:
                                                      Colors.transparent,
                                                  child: SizedBox(
                                                    height: 280,
                                                    child: Stack(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .bottomCenter,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: currentDate.difference(DateTime.parse(decodedMap22[i]["expiredate"])).inDays *
                                                                                (-1) >=
                                                                            365
                                                                        ? Color.fromARGB(
                                                                            255,
                                                                            211,
                                                                            237,
                                                                            212)
                                                                        : Color.fromARGB(
                                                                            255,
                                                                            240,
                                                                            180,
                                                                            180),
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            16.0)),
                                                                  ),
                                                                  child: Column(
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                                                                                child: Text(
                                                                                  decodedMap22[i]["nameweb"],
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 17,
                                                                                    letterSpacing: 0.27,
                                                                                    color: DesignCourseAppTheme.darkerText,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      'หมดอายุวันที่ ${decodedMap22[i]["expiredate"]}',
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(
                                                                                        fontWeight: FontWeight.w200,
                                                                                        fontSize: 14,
                                                                                        letterSpacing: 0.27,
                                                                                        color: DesignCourseAppTheme.grey,
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      child: Row(
                                                                                        children: <Widget>[
                                                                                          Text("\n"),
                                                                                          Text(
                                                                                            '   เหลืออีก ${currentDate.difference(DateTime.parse(decodedMap22[i]["expiredate"])).inDays * (-1)} วัน',
                                                                                            textAlign: TextAlign.left,
                                                                                            style: TextStyle(
                                                                                              fontWeight: FontWeight.w200,
                                                                                              fontSize: 15,
                                                                                              letterSpacing: 0.27,
                                                                                              color: DesignCourseAppTheme.grey,
                                                                                            ),
                                                                                          ),
                                                                                          Icon(
                                                                                            Icons.star,
                                                                                            color: currentDate.difference(DateTime.parse(decodedMap22[i]["expiredate"])).inDays * (-1) >= 365 ? Color.fromARGB(255, 25, 194, 34) : Color.fromARGB(255, 225, 21, 21),
                                                                                            size: 20,
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            48,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 48,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 24,
                                                                    right: 16,
                                                                    left: 16),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            16.0)),
                                                                boxShadow: <
                                                                    BoxShadow>[
                                                                  BoxShadow(
                                                                      color: DesignCourseAppTheme
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.2),
                                                                      offset: const Offset(
                                                                          0.0,
                                                                          0.0),
                                                                      blurRadius:
                                                                          6.0),
                                                                ],
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            16.0)),
                                                                child:
                                                                    AspectRatio(
                                                                  aspectRatio:
                                                                      1.28,
                                                                  child:
                                                                      InkWell(
                                                                    //child: CategoryListView()
                                                                    child: PageSmallScreen(
                                                                        WebResetPass:
                                                                            "https://www.${decodedMap22[i]["nameweb"]}"),
                                                                    onTap: () {
                                                                      FlutterWebBrowser.openWebPage(
                                                                          url: decodedMap22[i]
                                                                              [
                                                                              "nameweb"]);
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          ]))
                          ]))),
            ])));
  }

  Widget RengView() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _controller2?.length != null
                    ? Text(
                        "ทั้งหมดจำนวณ  " +
                            _controller2!.length.toString() +
                            "  เว็บ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 0.27,
                          color: DesignCourseAppTheme.darkerText,
                        ),
                      )
                    : Text(""),
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
                                      addweb(web: web, passweb: passweb);
                                      //_loadData();
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
                  onPressed: () async {
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
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
