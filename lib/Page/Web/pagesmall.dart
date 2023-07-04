import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//import 'package:open_file/open_file.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
//import 'package:url_launcher/url_launcher.dart';

class PageSmallScreen extends StatelessWidget {
  var WebResetPass; 
  PageSmallScreen({
    required this.WebResetPass,
  });
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: PageSmallScreen2(WebResetPass: this.WebResetPass),
      );
}

class PageSmallScreen2 extends StatefulWidget {
  final String WebResetPass; //ชื่อรูปภาพ
  PageSmallScreen2({
    required this.WebResetPass,
  });
  @override
  _PageSmallScreen2State createState() =>
      _PageSmallScreen2State(WebResetPass: WebResetPass);
}

class _PageSmallScreen2State extends State<PageSmallScreen2>
    with TickerProviderStateMixin {
  String WebResetPass;
  _PageSmallScreen2State({required this.WebResetPass});
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? _webViewController;
  late PullToRefreshController pullToRefreshController;
  final urlController = TextEditingController();
  double progress = 0;
  String cookiesString = '';
  double progresss = 0;
  // Track if the PDF was downloaded here.
  bool didDownloadPDF = false;
  // Show the progress status to the user.
  String progressString = 'File has not been downloaded yet.';
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (await _webViewController!.canGoBack()) {
            _webViewController!.goBack();
            return false;
          }
          return true;
        },
        //child: Scaffold(
        //  body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        key: webViewKey,
                        initialUrlRequest: URLRequest(
                          url:
                              Uri.parse(WebResetPass.toString()),
                          headers: {},
                        ),
                        initialOptions: options,
                        pullToRefreshController: pullToRefreshController,
                        //////////////////////////////////////////////////
                        // ignore: deprecated_member_use
                        onDownloadStart: (controller, url) async {
                          // dowfnloading a file in a webview application
                          final tempDir = await getTemporaryDirectory();
                          var finalpath =
                              (await getExternalStorageDirectory())!.path;
                          final path = '${tempDir.path}/' + finalpath + '.jpg';
                          final pathpdf =
                              '${tempDir.path}/' + finalpath + '.pdf';
                          print("////////////////////////////////////");
                          print("controller: $controller");
                          print("url: $url");
                          print((await getExternalStorageDirectory())!.path);
                          print("tempDir: $tempDir");
                          print("path: $path");
                          print("pathpdf: $pathpdf");
                          print("////////////////////////////////////");

                          List<String> imagePathArr = url.toString().split(".");
                          List<String> imagePathArr2 =
                              url.toString().split("/");
                          print("image's type  =  ${imagePathArr[3]}");
                          print("image's type2  =  ${imagePathArr2[8]}");
                          var typefile = imagePathArr[3];

                          if (typefile == "jpg") {
                            await Dio().download(url.toString(), path);
                            await ImageGallerySaver.saveFile(path);

                            await showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text('Download image successfully'),
                              ),
                            );
                          }
                        },
                        onWebViewCreated: (controller) {
                          _webViewController = controller;
                        },

                        /*onLoadStart: (controller, url) {
                          if (url
                              .toString()
                              .startsWith(WebResetPass.toString())) {
                            setState(() {
                              WebResetPass = url.toString();
                              urlController.text = this.WebResetPass;
                              print('อันนี้ m2face : ' + url.toString());
                            });
                          } else {
                            // FlutterWebBrowser.openWebPage(url: url.toString());
                            print('อันนี้ไม่ใช่ m2face : ' + url.toString());
                          }
                        },*/

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
                            this.WebResetPass = url.toString();
                            urlController.text = this.WebResetPass;
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
                            urlController.text = this.WebResetPass;
                          });
                        },

                        /*shouldOverrideUrlLoading:
                            (controller, navigationAction) async {
                          final uri = navigationAction.request.url!;
                          bool t = false;
                          print("uri = " + uri.toString());
                          if (uri
                              .toString()
                              .startsWith('https://www.m2face.com/')) {
                            t = true;
                            print("กรี๊ดดดด" + t.toString());
                          } else if (t == false) {
                            print("กรี๊ดดดด" + t.toString());
                            FlutterWebBrowser.openWebPage(url: uri.toString());
                            return NavigationActionPolicy.CANCEL;
                          }
                          return NavigationActionPolicy.ALLOW;
                        },*/
                        onUpdateVisitedHistory:
                            (controller, url, androidIsReload) {
                          setState(() {
                            this.WebResetPass = url.toString();
                            urlController.text = this.WebResetPass;
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
                                  Color.fromARGB(255, 30, 156, 21)),
                            )
                          : Center(),
                    ],
                  ),
                ),
              ],
            ),
          );
        //));
  }
}
