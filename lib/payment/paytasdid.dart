import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class PayTasdid extends StatelessWidget {
  final String id;

  const PayTasdid({Key key, this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewCash'),
      ),
      body: WebView(
        initialUrl:
            'https://pay-uat.tasdid.net/?id=${this.id}&url=https://facebook.com',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
