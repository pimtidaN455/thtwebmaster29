// ignore_for_file: unnecessary_new

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:convert';

import '../../Web/notification.dart';

class ScanQR extends StatelessWidget {
  const ScanQR({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(centerTitle: true,title: const Text('แสกนจ่าย / รับ'),backgroundColor: Color.fromARGB(255, 103, 33, 243),),
      body: Center(
        child: QRViewExample(),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ScanQRPageState();
}

class _ScanQRPageState extends State<QRViewExample> {
  ////////////////////////////////////////////////////

  String? data;

  void _importFile() async {
    try{
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false,
  type: FileType.custom,
  allowedExtensions: ['jpg','png'],);
    if (result != null) {
      //File _file = File(result.files.single.path!);
      File _file = result.paths.map((path) => File(path!)) as File;
     // final rest = await FlutterQrReader.imgScan(File(_file.toString()));
      print("อันนี้ปริ้น _file $_file");
    // print('อันนี้ปริ้น rest $rest');
   // setState(() { data = rest!;});
    } else {
      print("User canceled the picker");
    }    
  }catch(e){
    print(e);
  }
  }

  ////////////////////////////////////////////////////

  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  Barcode? result;
//in order to get hot reload to work.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
          NotiView(),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: onQRViewCreated,
                  overlay: QrScannerOverlayShape(
//customizing scan area
                    borderWidth: 10,
                    borderColor: Color.fromARGB(255, 15, 163, 255),
                    borderLength: 20,
                    borderRadius: 10,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                                SizedBox(
                width: 11.0,
              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.flip_camera_ios,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    await controller.flipCamera();
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.flash_on,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () async {
                                    await controller.toggleFlash();
                                  }),
                                  
                            ],
                          ),
                          Row(children: [
                            IconButton(
                                icon: Icon(
                                  Icons.add_photo_alternate_outlined,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                                onPressed: () async {
                                  _importFile();
                                }),
                                SizedBox(
                width: 6.0,
              ),
                          ])
                        ]),
                  ),
                )
              ],
            ),
          ),
           Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(8.0),
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: result != null || data!= null
                    ? Column(
                        children: [
                          Text('Code: ${result!.code}'),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text('Format: ${result!.format}'),
                        Text('rawData: $data'),
                        ],
                      )
                    : Text('Scan Code\nrawData'),
                    
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onQRViewCreated(QRViewController p1) {
    this.controller = p1;
    controller!.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        //openBrowserTab();
        FlutterWebBrowser.openWebPage(url: result!.code.toString());
      });
    });

    controller!.pauseCamera();
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}