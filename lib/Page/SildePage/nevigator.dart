import 'package:flutter/material.dart';

import '../../Design/app_theme.dart';
import 'drawer_user_controller.dart';
import 'first_screen.dart';
import 'loginweb_screen.dart';
import 'notify_screen.dart';
import 'home_drawer.dart';
import '../Web/mainpage.dart';
import 'howtouse.dart';


class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = FirstScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = FirstScreen ();
          });
          break;
           case DrawerIndex.WEB:
          setState(() {
            screenView = MainHomeScreen();
          });
          break;
        case DrawerIndex.HOWTOUSE:
          setState(() {
            screenView = HowtoUseScreen();
          });
          break;
        case DrawerIndex.LOGINWEB:
          setState(() {
            screenView = LoginWebScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
