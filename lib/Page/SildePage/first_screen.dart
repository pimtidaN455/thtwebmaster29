import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Design/design_course_app_theme.dart';
import '../../Design/app_theme.dart';
import 'package:dio/dio.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';

import '../Web/notification.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
void didChangeDependencies(){
  _loadData();
  super.didChangeDependencies();
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
  Widget build(BuildContext context) {
    return  Scaffold(
      
      body: Container(
        child: Column(
          children: [
             SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              getAppBarUI(),
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'หน้าหลัก',
                ),
                Tab(
                  text: 'ประชาสัมพันธ์',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    color: Colors.blue,
                    child: Center(
                      child: FirstScreenWeb()
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    child: FirstScreenWeb2()
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 Widget getAppBarUI() {
   return NotiView();
  }
  


}





class FirstScreenWeb extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreenWeb> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  late PullToRefreshController pullToRefreshController;
  final urlController = TextEditingController();
  double progress = 0;
  String url = 'https://appthtweb.tht.pw/fro/module-tht_app-mfile-getmain';
  String cookiesString = '';
  double progresss = 0;
  bool didDownloadPDF = false;
  String progressString = 'File has not been downloaded yet.';
  AnimationController? animationController;
  bool tappedYes = false;
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
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        key: webViewKey,
                        initialUrlRequest: URLRequest(
                          url: Uri.parse('https://appthtweb.tht.pw/fro/module-tht_app-mfile-getmain'),
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
                              .startsWith("https://appthtweb.tht.pw/fro/module-tht_app-mfile-getmain")) {
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
                              .startsWith('https://appthtweb.tht.pw/fro/module-tht_app-mfile-getmain')) {
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
              ],
            ),
          ),
        ));
        
  }
}


class FirstScreenWeb2 extends StatefulWidget {
  @override
  _FirstScreenState2 createState() => _FirstScreenState2();
}

class _FirstScreenState2 extends State<FirstScreenWeb2> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  late PullToRefreshController pullToRefreshController;
  final urlController = TextEditingController();
  double progress = 0;
  String url = 'https://appthtweb.tht.pw/fro/module-tht_app-mfile-getnotify';
  String cookiesString = '';
  double progresss = 0;
  bool didDownloadPDF = false;
  String progressString = 'File has not been downloaded yet.';
  AnimationController? animationController;
  bool tappedYes = false;
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
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        key: webViewKey,
                        initialUrlRequest: URLRequest(
                          url: Uri.parse('https://appthtweb.tht.pw/fro/module-tht_app-mfile-getnotify'),
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
                              .startsWith("https://appthtweb.tht.pw/fro/module-tht_app-mfile-getnotify")) {
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
                              .startsWith('https://appthtweb.tht.pw/fro/module-tht_app-mfile-getnotify')) {
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
              ],
            ),
          ),
        ));
        
  }
}
