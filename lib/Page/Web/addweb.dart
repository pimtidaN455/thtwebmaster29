import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Check/Use_Api.dart';
import 'mainpage.dart';

test(TextEditingController web) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? cart2 = prefs.getStringList("cart");
  int? nded = prefs.getInt("nub");
  print(cart2);
  print(nded);
    print("กรุ้กรู้ววว");
    print(cart2);
    print("ว้อทๆๆๆๆ");
    if(nded == null){}
    else{
      for(int i = 0 ; i<nded ; i++){
      Map<String, dynamic> decodedMap3 = jsonDecode(cart2![i]);
    print(decodedMap3);
    print(decodedMap3["nameweb"]);
    if(decodedMap3["nameweb"].contains(web.text)){
      return false;
    }
    else{}
    }
    }
    
}

addweb(
    {required TextEditingController web,
    required TextEditingController passweb}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  use_API us = new use_API();
  int nub = 0;
  ///// ส่งชื่อเว็บไป /////
  var statusweb = await us.Web(nameweb: web.text, passweb: passweb.text);
  print("อ๋อจร้าาา");
  print(statusweb);
  
    if (statusweb['status'] == "true") {
    print("ข้อมูลเว็บถูกต้องจ้า");
    print(statusweb['id_user']);
    print(statusweb['fullname']);
    print(statusweb['expiredate']);
    print(statusweb['dealer']);
    print(statusweb['package']);

    Map<String, dynamic> Web = {
      "nameweb": web.text,
      "passweb": passweb.text,
      "id_user": statusweb['id_user'],
      "fullname": statusweb['fullname'],
      "expiredate": statusweb['expiredate'],
      "dealer": statusweb['dealer'],
      "package": statusweb['package'],
    };
    print("ไหนดู Map web");
    print(Web);
    String encodedMap = jsonEncode(Web);
    print("ไหนดู encode");
    print(encodedMap);
    prefs.setString('timeData', encodedMap);
    String? encodedMap2 = prefs.getString('timeData');
    Map<String, dynamic> decodedMap = jsonDecode(encodedMap2!);
    print("ไหนดู decode");
    print(decodedMap);
    print(decodedMap["id_user"]);
    print("__________________________");
    print("ไหนดู setstring");
    print("__________________________");
    var finalAllWeb = [];
    finalAllWeb.add(encodedMap2);
    print("ไหนดู finalAllWeb");
    print(finalAllWeb);
    print("__________________________");
    Map<String, dynamic> decodedMap2 = jsonDecode(finalAllWeb[0]);
    print(decodedMap2);
    print(decodedMap2["fullname"]);
    print("__________________________");
    List<String>? cart = prefs.getStringList("cart");
    if (cart == null) cart = [];
    cart.add(encodedMap);
    prefs.setStringList("cart", cart);
    prefs.setInt("nub", cart.length);
    List<String>? cart2 = prefs.getStringList("cart");
    print("กรุ้กรู้ววว");
    print(cart2);
    print("ว้อทๆๆๆๆ");
    Map<String, dynamic> decodedMap3 = jsonDecode(cart2![0]);
    print(decodedMap3);
    print(decodedMap3["fullname"]);
    print("__________________________");
  } else {
    AlertDialog(
      title: const Text('ชื่อเว็บไซต์ หรือ รหัสผ่านไม่ถูกต้อง'),
    );
  }
  web.clear();
  passweb.clear();
}
