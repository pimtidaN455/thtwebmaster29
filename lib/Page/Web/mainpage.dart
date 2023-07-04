// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../../Design/design_course_app_theme.dart';
import 'addweb.dart';
import 'allweb2.dart';
import 'pagesmall.dart';
import 'reng.dart';
import 'search.dart';

class MainHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MainHomeScreen2(),
      );
}

class MainHomeScreen2 extends StatefulWidget {
  const MainHomeScreen2({Key? key, this.callBack}) : super(key: key);
  final Function()? callBack;
  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen2>   with TickerProviderStateMixin {
////////////////////////////////////////////////////////////
  AnimationController? animationController;
  String? _controller;
  List<String>? _controller2 = [];
  String? _imageProfile;
  String? _FnameProfile;
  String? _LnameProfile;
  bool tappedYes = false;
  TextEditingController web = TextEditingController();
  TextEditingController passweb = TextEditingController();
  static var decodedMap3;
  static List decodedMap22 = [];
  DateTime currentDate = DateTime.now();
  // ดึงรูปมาโชว์ //
@override
void didChangeDependencies(){
  _loadData();
  super.didChangeDependencies();
}

  @override
  void dispose() {
     animationController?.dispose();
    super.dispose();
  }
  @override
  void initState() {
     animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

 Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
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
      _FnameProfile = prefs.getString("firstname");
      _LnameProfile = prefs.getString("lastname");
      _controller = prefs.getString("profilImage");
      _controller2 = prefs.getStringList("cart");
    });
  }

  ////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Container(
        color: DesignCourseAppTheme.nearlyWhite,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              getAppBarUI(),
              AllWeb2(),
            ])));
  }

  Widget Search() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Container(child: SearchView()),
    );
  }

  Widget getAppBarUI() {
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
  }
}




/*// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../../Check/filecheck/User_data.dart';
import '../../Design/design_course_app_theme.dart';
import 'pagesmall.dart';
import '../Main/popular_course_list_view.dart';
import 'reng.dart';
import 'search.dart';


class MainHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: MainHomeScreen2(),
      );
}

class MainHomeScreen2 extends StatefulWidget {
  @override
  _MainHomeScreenState createState() =>
      _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen2> {
////////////////////////////////////////////////////////////
  String? _controller;
   List<String> ? _controller2 = [];
  String? _imageProfile;
  String? _FnameProfile;
  String? _LnameProfile;
  bool tappedYes = false;
  
  // ดึงรูปมาโชว์ //

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _imageProfile = prefs.getString("profilImage");
    _FnameProfile = prefs.getString("firstname");
    _LnameProfile = prefs.getString("lastname");
    _controller2 = prefs.getStringList("cart");
    setState(() {
      _controller = prefs.getString("profilImage");
     // _controller = new TextEditingController(text: _imageProfile);
      //_controller2 = prefs.getStringList("cart");
    });
  }

  var controller;
  //var textController = TextEditingController();


  @override
  void initState() {
    super.initState();
   // _imageProfile = "";
    getSharedPrefs();
    _loadData();
  }

    _loadData() async {
    //print("ไหนดู​" + _controller2.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _controller = prefs.getString("profilImage");
      _controller2 = prefs.getStringList("cart");
    });
  }
  ////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    // _loadData();
    // getSharedPrefs();
    return Container(
        color: DesignCourseAppTheme.nearlyWhite,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              getAppBarUI(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 20, right: 20, bottom: 10),
                child: Container(
                  //height: 120.0,
                  // width: 120.0,
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('ใส่ชื่อเว็บเพื่อค้นหา',
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                  ),
                ),
              ),
              Search(),
              RengView(),
              //Text(_controller2.toString()),
              Expanded(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(children: <Widget>[
                        Flexible(
                          child: getPopularCourseUI(),
                        ),
                      ])))
            ])));
  }

  Widget Search() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Container(child: SearchView()),
    );
  }

  Widget getAppBarUI() {
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
                      ? AssetImage("assets/images/logojoblucky.png")
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
  }
  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            child: _controller2 != null? PopularCourseListView(WebResetPass: _controller2,):Text("ยังไม่มีเว็บไซต์"))]
          )
      ); 
  }
}
*/