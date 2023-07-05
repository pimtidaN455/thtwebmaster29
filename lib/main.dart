import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Intro/introduction_animation_screen.dart';
import 'Page/SildePage/nevigator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await FlutterDownloader.initialize(debug: true);
  await Permission.storage.request();
  await Permission.mediaLibrary.request();
  await Permission.camera.request();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var statuslogin = prefs.getString("statuslogin");

  runApp(Home(statuslogin: statuslogin));
}

class MyApp extends StatelessWidget {
  final String? statuslogin;
  const MyApp({Key? key, this.statuslogin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: statuslogin == "success"
          ? Home()
          : IntroductionAnimationScreen(),
    );
  }
}

class Home extends StatefulWidget {
  final String? statuslogin;
  const Home({Key? key, this.statuslogin}) : super(key: key);
  @override
  _HomeState createState() => _HomeState(statuslogin: statuslogin);
}

class _HomeState extends State<Home> {
   final String? statuslogin;
  _HomeState({required this.statuslogin});

  @override
  void initState() {
    super.initState();
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    OneSignal.shared.setAppId("8a484f83-b642-47a8-b231-74ed2e3611bc");
    getDeviceState();
  }

  void getDeviceState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var deviceState = await OneSignal.shared.getDeviceState();
    if (deviceState != null) {
      print('Device State: $deviceState');
      print("กรูีววว");
      print(deviceState.userId);
      await prefs.setString("Player_ID", deviceState.userId.toString());
    } else {
      print('Failed to get device state.');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: statuslogin == "success"
          ? NavigationHomeScreen()
          : IntroductionAnimationScreen(),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}


/*

import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Intro/introduction_animation_screen.dart';
import 'Page/SildePage/nevigator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

Future<void> main() async{

    WidgetsFlutterBinding.ensureInitialized();
     ///////

 ///////
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  await FlutterDownloader.initialize(debug: true);
  await Permission.storage.request();
  await Permission.mediaLibrary.request();
  await Permission.camera.request();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var statuslogin=prefs.getString("statuslogin");
  var Firstname=prefs.getString("firstname");
  var Lastname=prefs.getString("lastname");
  print(statuslogin);


  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    home: statuslogin=="success"?NavigationHomeScreen():IntroductionAnimationScreen(),));
   // home: statuslogin=="success"?NavigationHomeScreen():IntroductionAnimationScreen(),));
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
*/