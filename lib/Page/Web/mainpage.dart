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
import 'notification.dart';
import 'pagesmall.dart';
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
  int notificationCount = 5;
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
    return NotiView();
  }
}