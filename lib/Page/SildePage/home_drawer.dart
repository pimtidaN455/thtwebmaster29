import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import '../../Design/app_theme.dart';
import '../../Design/design_course_app_theme.dart';

import '../../Intro/introduction_animation_screen.dart';
import '../Regis/register.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer(
      {Key? key,
      this.screenIndex,
      this.iconAnimationController,
      this.callBackIndex})
      : super(key: key);

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;

  TextEditingController? _controller;
  String? _imageProfile;
  String? _FnameProfile;
  String? _LnameProfile;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _imageProfile = prefs.getString("profilImage");
    _FnameProfile = prefs.getString("firstname");
    _LnameProfile = prefs.getString("lastname");
    setState(() {
      _controller = new TextEditingController(text: _imageProfile);
    });
  }

  @override
  void initState() {
    setDrawerListArray();
    super.initState();
    _imageProfile = "";
    getSharedPrefs();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'หน้าหลัก',
        icon: Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.WEB,
        labelName: 'เช็คเว็บไซต์',
        icon: Icon(Icons.computer),
      ),
      DrawerList(
        index: DrawerIndex.HOWTOUSE,
        labelName: 'วิธีใช้',
        icon: Icon(Icons.book),
      ),
      DrawerList(
        index: DrawerIndex.LOGINWEB,
        labelName: 'เข้าสู่ระบบเว็บไซต์',
        icon: Icon(Icons.login),
      ),
     
    ];
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 -
                            (widget.iconAnimationController!.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController!,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                /* BoxShadow(
                                    color: AppTheme.grey.withOpacity(0.6),
                                    offset: const Offset(2.0, 4.0),
                                    blurRadius: 8),*/
                              ],
                            ),
                            child: ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                child: Ink.image(
                                  image: _imageProfile == null
                                      ? AssetImage("assets/images/rabbit.jpg")
                                      : FileImage(File(_imageProfile!))
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                  width: 128,
                                  height: 128,
                                  child: InkWell(),
                                ),
                              ),
                            ),
                            /* ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child:  Image.asset('assets/images/pim.jpg'),
                            ),*/
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      _FnameProfile.toString() + " " +  _LnameProfile.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isLightMode ? AppTheme.grey : AppTheme.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.6),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppTheme.darkText,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: Colors.red,
                ),
                onTap: () {
                  _onWillPop();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  /*void onTapped() {
    print('Doing Something...'); // Print to console.
  }*/

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: new Text(
                  'No',
                  style: TextStyle(
                    color: DesignCourseAppTheme.nearlyRed,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.remove("statuslogin");
                  pref.remove("firstname");
                  pref.remove("lastname");
                  pref.remove("profilImage");
                  pref.remove("cart");
        
                //  pref.setString("profilImage", 'assets/images/THTWEB.png');
                  
                  //_webViewController?.goBack(),
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => IntroductionAnimationScreen(),
                    ),(Route<dynamic> route) => false,
                  );
                },
                child: new Text(
                  'Yes',
                  style: TextStyle(
                    color: DesignCourseAppTheme.nearlyGreen,
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    // decoration: BoxDecoration(
                    //   color: widget.screenIndex == listData.index
                    //       ? Colors.blue
                    //       : Colors.transparent,
                    //   borderRadius: new BorderRadius.only(
                    //     topLeft: Radius.circular(0),
                    //     topRight: Radius.circular(16),
                    //     bottomLeft: Radius.circular(0),
                    //     bottomRight: Radius.circular(16),
                    //   ),
                    // ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? Color.fromARGB(255, 90, 210, 16)
                                  : AppTheme.nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? Color.fromARGB(255, 90, 210, 16)
                              : AppTheme.nearlyBlack),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? Colors.black
                          : AppTheme.nearlyBlack,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 90, 210, 16)
                                  .withOpacity(0.2),
                              borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }
}

enum DrawerIndex {
  HOME,
  LOGINWEB,
  WEB, HOWTOUSE,
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
