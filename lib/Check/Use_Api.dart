import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'User_data.dart';

class use_API {
  use_API() {}
  var path = "https://www.joblucky.com/";

  Login(username, password, id_device) async {
    print(username);
    print(password);
    print(id_device);
    final http.Response response = await http.post(
      Uri.parse("https://www.joblucky.com/applogin.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': await username,
        'password': await password,
        'id_device': await id_device,
      }),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (jsonDecode(response.body));
    } else {
      throw Exception('Failed to Login.');
    }
  }

    Web({required String nameweb, required String passweb , required String playerid}) async {
    print(nameweb);
    print(passweb);
    print(playerid);
    final http.Response response = await http.post(
      Uri.parse("https://www.joblucky.com/appaddweb.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nameweb': await nameweb,
        'passweb': await passweb,
        'playerid': await playerid,
      }),
    );

    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      return (jsonDecode(response.body));

    } else {
      throw Exception('Failed to Add Web.');
    }
  }
}