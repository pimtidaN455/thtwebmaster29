import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Scanqr.dart';


class MenuScan extends StatefulWidget {
  const MenuScan({Key? key}) : super(key: key);
  @override
  _MenuScanState createState() => _MenuScanState();
}

class _MenuScanState extends State<MenuScan>with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late TabController _controller;
  int _selectedIndex = 2;

   List<Widget> list = [
    Tab(child: Text('แสกน', style: TextStyle(
      color: Colors.black, // กำหนดสีข้อความในปุ่มเป็นสีขาว
    ),)),
    Tab(
        child: Text(
      'เว็บไซต์ที่เคยทำการล๊อคอิน', style: TextStyle(
      color: Colors.black, // กำหนดสีข้อความในปุ่มเป็นสีขาว
    ),
     
    )),
   ];

   @override
   void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
   }

   @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('เข้าสู่ระบบเว็บไซต์',style: TextStyle(
      color: Colors.black, // กำหนดสีข้อความในปุ่มเป็นสีขาว
    )),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            ////////////////////////////////////////
            Center(child:ScanQR()),
            ////////////////////////////////////////
            Center(child: ScanQR()),
            ////////////////////////////////////////
          ],
        ),
      ),
    );
   }
}
