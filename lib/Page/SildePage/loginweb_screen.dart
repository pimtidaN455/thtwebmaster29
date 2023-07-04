import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Design/app_theme.dart';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';


import '../../Design/design_course_app_theme.dart';

class LoginWebScreen extends StatefulWidget {
  @override
  _LoginWebScreenState createState() => _LoginWebScreenState();
}

class _LoginWebScreenState extends State<LoginWebScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  late PullToRefreshController pullToRefreshController;
  final urlController = TextEditingController();
  double progress = 0;
  String url = 'https://appthtweb.tht.pw/fro/module-tht_app-mfile-getlogin-op-joblucky.com';
  String cookiesString = '';
  double progresss = 0;
  bool didDownloadPDF = false;
  String progressString = 'File has not been downloaded yet.';
  AnimationController? animationController;
  String? _controller;
  List<String>? _controller2 = [];
  String? _imageProfile;
  String? _FnameProfile;
  String? _LnameProfile;
  bool tappedYes = false;
  TextEditingController web = TextEditingController();
  TextEditingController passweb = TextEditingController();
  static var decodedMap3;
  static List decodedMap22 = [];
  DateTime currentDate = DateTime.now();
  @override
  void initState() {
   super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(color: Colors.blue),
      onRefresh: () async {
        if (Platform.isAndroid) {
          return _webViewController?.reload();
        } else if (Platform.isIOS) {
          _webViewController?.loadUrl(
              urlRequest: URLRequest(url: await _webViewController?.getUrl()));
        }
      },
    );
  }

    @override
  void dispose() {
    super.dispose();
  }

    _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _controller2 = prefs.getStringList("cart");
    decodedMap22.clear();
    List<String>? cart2 = prefs.getStringList("cart");
    if (cart2 == null) {
    } else {
      int nubcart2 = prefs.get("nub") as int;
      for (int i = 0; i < nubcart2; i++) {
        decodedMap3 = jsonDecode(cart2[i]);
        decodedMap22.add(decodedMap3);
      }
    }
    setState(() {
      _imageProfile = prefs.getString("profilImage");
      _FnameProfile = prefs.getString("firstname");
      _LnameProfile = prefs.getString("lastname");
      _controller = prefs.getString("profilImage");
      _controller2 = prefs.getStringList("cart");
    });
  }

  
  
  @override
void didChangeDependencies(){
  _loadData();
  super.didChangeDependencies();
}

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final Response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
           // receiveTimeout: 0,
          ));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(Response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  CookieManager cookieManager = CookieManager.instance();

  Future<void> updateCookies(Uri url) async {
    List<Cookie> cookies = await cookieManager.getCookies(url: url);
    cookiesString = '';
    for (Cookie cookie in cookies) {
      cookiesString += '${cookie.name}=${cookie.value};';
    }
    print(cookiesString);
  }

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      javaScriptEnabled: true,
      useShouldOverrideUrlLoading: true,
      useOnDownloadStart: true,
      allowFileAccessFromFileURLs: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      initialScale: 100,
      allowFileAccess: true,
      useShouldInterceptRequest: true,
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

   @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
        if(await _webViewController!.canGoBack()){
            _webViewController!.goBack();
            return false;
        }
        return true;
      },
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                getAppBarUI(),
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        key: webViewKey,
                        initialUrlRequest: URLRequest(
                          url: Uri.parse('https://appthtweb.tht.pw/fro/module-tht_app-mfile-getlogin-op-joblucky.com'),
                          headers: {},
                        ),
                        initialOptions: options,
                        pullToRefreshController: pullToRefreshController,
                        //////////////////////////////////////////////////
                        // ignore: deprecated_member_use
                        

                        onWebViewCreated: (controller) {
                          _webViewController = controller;
                        },

                        onLoadStart: (controller, url) {
                          if (url
                              .toString()
                              .startsWith("https://appthtweb.tht.pw/fro/module-tht_app-mfile-getlogin-op-joblucky.com")) {
                            setState(() {
                              this.url = url.toString();
                              urlController.text = this.url;
                              print('อันนี้ m2face : ' + url.toString());
                            });
                          } else {
                            // FlutterWebBrowser.openWebPage(url: url.toString());
                            print('อันนี้ไม่ใช่ m2face : ' + url.toString());
                          }
                        },

                        androidOnPermissionRequest:
                            (controller, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },

                        onLoadStop: (controller, url) async {
                          pullToRefreshController.endRefreshing();
                          if (url != null) {
                            await updateCookies(url);
                          }
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },

                        onLoadError: (controller, url, code, message) {
                          pullToRefreshController.endRefreshing();
                        },

                        onProgressChanged: (controller, progress) {
                          if (progress == 100) {
                            pullToRefreshController.endRefreshing();
                          }
                          setState(() {
                            this.progress = progress / 100;
                            urlController.text = this.url;
                          });
                        },

                        shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          final uri = navigationAction.request.url!;
                          bool t = false;
                          print("uri = " + uri.toString());
                          if (uri
                              .toString()
                              .startsWith('https://appthtweb.tht.pw/fro/module-tht_app-mfile-getlogin-op-joblucky.com')) {
                            t = true;
                            print("กรี๊ดดดด" + t.toString());
                          } else if (t == false) {
                            print("กรี๊ดดดด" + t.toString());
                            FlutterWebBrowser.openWebPage(url: uri.toString());
                            return NavigationActionPolicy.CANCEL;
                          }
                          return NavigationActionPolicy.ALLOW;
                        },
                        onUpdateVisitedHistory:
                            (controller, url, androidIsReload) {
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },

                        onConsoleMessage: (controller, consoleMessage) {
                          print(consoleMessage);
                        },
                      ),
                      progress < 1.0
                          ? LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 161, 161, 161)),
                            )
                          : Center(),
                    ],
                  ),
                ),
                /*ButtonBar(
                  buttonAlignedDropdown: true,
                  buttonPadding: EdgeInsets.all(2),
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ElevatedButton(
                      child: Icon(Icons.arrow_back),
                      onPressed: () {
                        _webViewController?.goBack();
                      },
                    ),
                    ElevatedButton(
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        _webViewController?.goForward();
                      },
                    ),
                    ElevatedButton(
                      child: Icon(Icons.refresh),
                      onPressed: () {
                        _webViewController?.reload();
                      },
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        ));
        
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Hi!',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: 0.2,
                    color: DesignCourseAppTheme.grey,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  _FnameProfile.toString() + " " + _LnameProfile.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 60,
            height: 60,
            child: ClipOval(
              child: Material(
                color: Colors.transparent,
                child: Ink.image(
                  image: _imageProfile == null
                      ? AssetImage("assets/images/rabbit.jpg")
                      //: AssetImage("assets/logojoblucky.png"),
                      : FileImage(File(_imageProfile!)) as ImageProvider,
                  fit: BoxFit.cover,
                  width: 128,
                  height: 128,
                  child: InkWell(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

import '../../Design/app_theme.dart';


class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      color: isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor:
              isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: 16,
                        right: 16),
                    child: Image.asset('assets/images/feedbackImage.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Your FeedBack',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isLightMode ? Colors.black : Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Give your best time for this moment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: isLightMode ? Colors.black : Colors.white),
                    ),
                  ),
                  _buildComposer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isLightMode ? Colors.blue : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  'Send',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: isLightMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                maxLines: null,
                onChanged: (String txt) {},
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: Colors.blue,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your feedback...'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/