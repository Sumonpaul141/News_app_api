import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullNewsPage extends StatefulWidget {
  final String blogUrl, blogTitle;

  const FullNewsPage({
    Key key,
    @required this.blogUrl,
    @required this.blogTitle,
  }) : super(key: key);

  @override
  _FullNewsPageState createState() => _FullNewsPageState();
}

class _FullNewsPageState extends State<FullNewsPage> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.blogTitle,
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogUrl,
          onWebViewCreated: ((WebViewController webViewController) {
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
