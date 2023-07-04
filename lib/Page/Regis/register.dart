import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Design/background.dart';
import '../SildePage/nevigator.dart';
import 'profile_widget.dart';
import 'user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController Firstname = TextEditingController();
  TextEditingController Lastname = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
      child: Form(
        key: _fromKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Center(
                child: Column(
              children: [
                SizedBox(height: 150),
                Text(
                  'Create Your Profile\n',
                  style: TextStyle(
                      color: Color.fromARGB(255, 15, 63, 19),
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                ProfileWidget(),
                const SizedBox(height: 24),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                    controller: Firstname,
                    decoration: InputDecoration(
                      labelText: "Firstname",
                      suffixIcon: IconButton(
                        onPressed: () {
                          Firstname.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter FirstName.";
                      } else if (value.length < 3) {
                        return "FirstName should be more than 3 characters.";
                      } else if (value.length > 30) {
                        return "FirstName should not be greater than 30 charecters.";
                      } else
                        return null;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                    controller: Lastname,
                    decoration: InputDecoration(
                      labelText: "Lastname",
                      suffixIcon: IconButton(
                        onPressed: () {
                          Lastname.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Lastname.";
                      } else if (value.length < 3) {
                        return "Lastname should be more than 3 characters.";
                      } else if (value.length > 30) {
                        return "Lastname should not be greater than 30 charecters.";
                      } else
                        return null;
                    },
                  ),
                ),
                //buildName(user),
                const SizedBox(height: 24),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      bool validate = _fromKey.currentState!.validate();
                      if (validate) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString("firstname", Firstname.text);
                        await prefs.setString("lastname", Lastname.text);
                        await prefs.setString("statuslogin", "success");

                        String Firstname2 = prefs.getString("firstname") ?? '';
                        String Lastname2 = prefs.getString("lastname") ?? '';

                        print("ไหนเช็คดิ้");
                        print(Firstname2);
                        print(Lastname2);
                        MaterialPageRoute materialPageRoute;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationHomeScreen(),
                            settings: RouteSettings(arguments: null),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      onPrimary:
                          Theme.of(context).primaryTextTheme.button?.color,
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: new LinearGradient(colors: [
                            Color.fromARGB(255, 7, 67, 8),
                            Color.fromARGB(255, 14, 208, 17),
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    ));
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
