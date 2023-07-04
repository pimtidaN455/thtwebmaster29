import 'dart:math';
import 'Use_Api.dart';
import 'User_data.dart';

class check_user {
  //ตัวแปร id_device ระบุเลขเครื่องของผู้ใช้ไอดีนี้
  var id_device = "";
  use_API use_api = new use_API();

  login(username, password) async {
    var id_device = null;
    if (await id_device == null) {
      Random r = new Random();
      var iddevice = String.fromCharCode(r.nextInt(26) + 65) +
          String.fromCharCode(r.nextInt(26) + 65);
      for (int i = 0; i < 10; ++i) {
        var num = r.nextInt(10);
        iddevice += num.toStringAsFixed(0);
      }
      id_device = await iddevice;
    }
    print("---------------------สร้าง ID device-----------------------");
    print(id_device);
    print("----------------------------------------------------------");

    var login = await use_api.Login(username, password, id_device);
    print(login);
    var message = await login["status"];
    var datauser = await login["detail"]["firstname"];
    print("loginUUU");
    print(message);
    print(datauser);
    if (await message == 'success') {
      //await userdata_file.write_user_file(datauser);
      
    }
    print(" -------------------------- Login success --------------------------");
    return await login;
  }
}
/*
import 'dart:math';
import 'Use_Api.dart';
import 'User_data.dart';

class check_user {
  //ตัวแปร id_device ระบุเลขเครื่องของผู้ใช้ไอดีนี้
  var id_device = "";
  use_API use_api = new use_API();

  login(username, password) async {
    //user_file userdata_file = await new user_file();
    //await userdata_file.getdata_user_file();
    //var id_device = await userdata_file.Id_device;
    var id_device = null;
    if (await id_device == null) {
      Random r = new Random();
      var iddevice = String.fromCharCode(r.nextInt(26) + 65) +
          String.fromCharCode(r.nextInt(26) + 65);
      for (int i = 0; i < 10; ++i) {
        var num = r.nextInt(10);
        iddevice += num.toStringAsFixed(0);
      }
      id_device = await iddevice;
    }
    print("---------------------สร้าง ID device-----------------------");
    print(id_device);
    print("----------------------------------------------------------");

    var login = await use_api.Login(username, password, id_device);
    print(login);
    var message = await login["status"];
    var datauser = await login["detail"]["firstname"];
    print("loginUUU");
    print(message);
    print(datauser);
    if (await message == 'success') {
      //await userdata_file.write_user_file(datauser);
    }
    print(
        " -------------------------- Login success --------------------------");
    return await login;
  }
}
*/