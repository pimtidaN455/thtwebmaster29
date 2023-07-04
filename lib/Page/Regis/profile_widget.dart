import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class ProfileWidget extends StatefulWidget {
  ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  File? _image;

  TextEditingController? _controller;
  String? _imageProfile;

  Future<Null> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _imageProfile = prefs.getString("profilImage");
   // print("ไหนดูรูปโปรไฟล์ล่าสุดหน่อยย" + _imageProfile.toString());
    setState(() {
      _controller = new TextEditingController(text: _imageProfile);
    });
  }

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getSharedPrefs();
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    //final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: _imageProfile == null
              ? AssetImage("assets/images/rabbit.jpg")
              // AssetImage("assets/logojoblucky.png"),
              : FileImage(File(_imageProfile!)) as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
      color: Color.fromARGB(255, 13, 162, 85),
      all: 3,
      child: InkWell(
        child: Ink(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          height: 40,
          width: 40,
          child: const Icon(
            Icons.edit,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        onTap: () async {
          showModalBottomSheet(
            context: context,
            builder: ((builder) => bottomSheet()),
          );
        },
        customBorder: const CircleBorder(),
      ));

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    final imagePermanent = await saveFilePermanently(image.path);
    setState(() {
      this._image = imagePermanent;
    });
  }

  Future<File> saveFilePermanently(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(imagePath);
    print("ไหนดู path : " + name);
    final image = File("${directory.path}/$name");
    print("ไหนดู image.path : " + image.path);
    setState(() {
      prefs.setString("profilImage", image.path);
       _imageProfile = prefs.getString("profilImage");
    });

    return File(imagePath).copy(image.path);
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Material(
              color: color, shape: const CircleBorder(), child: child));
}
