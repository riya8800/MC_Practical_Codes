// browser_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserScreen extends StatefulWidget {
  @override
  _BrowserScreenState createState() => _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  late InAppWebViewController webViewController;
  String url = "https://flutter.dev";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter InAppWebView'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              if (url.isNotEmpty) {
                // Load the current URL again
                await webViewController.loadUrl(urlRequest: URLRequest(url: WebUri(url)));
              }
            },
          ),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)), // Correctly using WebUri
        onWebViewCreated: (InAppWebViewController controller) {
          webViewController = controller;
        },
        onLoadStart: (InAppWebViewController controller, WebUri? url) {
          setState(() {
            this.url = url?.toString() ?? ''; // Safely handle null
          });
        },
        onLoadStop: (InAppWebViewController controller, WebUri? url) async {
          print("Page finished loading: ${url?.toString()}");
        },
      ),
    );
  }
}
