import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key:key);

  Widget build(BuildContext context){
    return MaterialApp(
      home: Home(),

    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key:key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
   @override
    void initState(){
      super.initState();
      OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
      OneSignal.shared.setAppId("8a484f83-b642-47a8-b231-74ed2e3611bc");
      getDeviceState();
    }

    void getDeviceState() async {
  var deviceState = await OneSignal.shared.getDeviceState();
  
  // ทำสิ่งที่คุณต้องการด้วยข้อมูลสถานะที่ได้รับ เช่น การแสดงข้อความหรือการประมวลผลข้อมูล
  if (deviceState != null) {
    print('Device State: $deviceState');
    print("กรูีววว");
    print(deviceState.userId);
    // ดึงข้อมูลสถานะอุปกรณ์ที่คุณสนใจ เช่น deviceState.subscriptionStatus, deviceState.userId, ฯลฯ
  } else {
    print('Failed to get device state.');
  }
}
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text("OneSignal")),
          body: const Center(child: Text("OneSignal PushNotification"),),
        );
      }
}
