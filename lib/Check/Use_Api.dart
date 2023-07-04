import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
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
    Web({required String nameweb, required String passweb}) async {
    print(nameweb);
    final http.Response response = await http.post(
      Uri.parse("https://www.joblucky.com/appaddweb.php"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nameweb': await nameweb,
        'passweb': await passweb,
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

/*import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import 'User_data.dart';

class use_API {
  var path = "https://127.0.0.1:8000/";

  use_API() {}

  Login(username, password, id_device) async {
    print(username);
    print(password);
    print(id_device);
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/loginN/"),
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

  Logout(tokenID) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/logout/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await tokenID,
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (jsonDecode(response.body));
    } else {
      throw Exception('Failed to Logout.');
    }
  }

  GetImgCloud(imageID) async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/UrlImgCloud/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'imageID': await imageID
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return ((await jsonDecode(response.body))['message']);
    } else {
      throw Exception('Failed to GetImgCloud.');
    }
  }

  Change_Album(var idphotho, var nameoldalbum, var namenewalbum) async {
    print("////////////////");
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/change_Album/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'idphoto': idphotho,
        'nameoldalbum': nameoldalbum,
        'namenewalbum': namenewalbum,
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to Change_Album.');
    }
  }

  Reset_password(email) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/resetpassword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': await email,
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to Reset password.');
    }
  }

  getdata_from_Server(tokenID) {
    var path_API = path + "DatabeasesendtoUser/";
    var data = {'tokenID': tokenID};
    return http.post(Uri.parse(path_API), body: data);
  }

  update_name(tokenID, Firstname, Lastname) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/userdataupdate/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await tokenID,
        'firstname': await Firstname,
        'lastname': await Lastname
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to update name.');
    }
  }

  detect_word(word) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/detectword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'word': word,
      }),
    );
    if (response.statusCode == 200) {
      return ((await jsonDecode(response.body))['message']);
    } else {
      throw Exception('Failed to detect word.');
    }
  }

  manage_Album(namealbum, nameoldalbum, keyword, description, status) async {
    print("////////////////");
    print(namealbum);
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/Album/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'namealbum': namealbum,
        'nameoldalbum': nameoldalbum,
        'keyword': keyword,
        'description': description,
        'status': status
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Manage Album.');
    }
  }

  Addimage_clound(nameimage, pathinmage, dataimage) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/Addcloud_storage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'nameimage': await nameimage,
        'image': await dataimage,
        'AddressImage': await pathinmage,
        'datephoto': await now.toString(),
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to Addimage clound.');
    }
  }

  getverify_email(var tokenUser) async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/send_verified_email/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'token': tokenUser}),
    );
    if (response.statusCode == 200) {
      return ((await jsonDecode(response.body))['message']);
    } else {
      throw Exception('Failed to create getverify Email.');
    }
  }

  getallimage_clound() async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/imagecloudstorage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': await user_file_.IDuser}),
    );
    if (response.statusCode == 200) {
      return ((await jsonDecode(response.body))['message']);
    } else {
      throw Exception('Failed to getallimage Clound.');
    }
  }

  AddPhoto(nameimage, pathinmage, dataimage) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/uploadImage/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'nameimage': await nameimage,
        'image': await dataimage,
        'AddressImage': await pathinmage,
        'datephoto': await now.toString(),
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to AddPhoto.');
    }
  }

  updatekeyword_image(namealbum, nameimg, keyword) async {
    user_file user_file_ = new user_file();
    var now = await DateTime.now();
    print("วันที่--------------");
    print(now.toString());
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/updatekeyword/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'tokenID': await user_file_.IDuser,
        'namealbum': namealbum,
        'imageID': nameimg,
        'keyword': keyword
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to Update Keyword image.');
    }
  }

  getPhotoFromAPI() async {
    user_file user_file_ = await new user_file();
    print("Getphoto");
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/DataAlbum/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': await user_file_.IDuser}),
    );
    if (response.statusCode == 200) {
      return ((await jsonDecode(response.body))['message']);
    } else {
      throw Exception('Failed to get Photo from API.');
    }
  }

  getPhotoFromAPIlogin(var token) async {
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/DataAlbum/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'tokenID': token}),
    );
    if (response.statusCode == 200) {
      return ((await jsonDecode(response.body))['message']);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Delete_image_incloud(var tokenimage) async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();

    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/Deletephoto_cloud/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'idimage': await tokenimage,
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to Delete image incloud.');
    }
  }

  Delete_image_incHome(var tokenimage, var nameAlbum) async {
    user_file user_file_ = new user_file();
    await user_file_.getdata_user_file();
    final http.Response response = await http.post(
      Uri.parse("http://10.0.2.2:8000/Deletedataphoto/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'tokenID': await user_file_.IDuser,
        'namealbum': nameAlbum,
        'idphoto': await tokenimage,
      }),
    );
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return (await jsonDecode(response.body));
    } else {
      throw Exception('Failed to Delete image incHome.');
    }
  }
}

*/