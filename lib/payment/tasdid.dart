import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taswel/payment/paytasdid.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class Tasdid extends StatelessWidget {
  final String serverToken =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyZjY5MWYwZC0yOTgxLTQ3MjUtOWYzYy0wYjg2YjE2YjJjODEiLCJlbWFpbCI6InNhbGFtLmFwcEB0YXNkaWQubmV0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6InNhbGFtLmFwcCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlByb3ZpZGVyIiwiRmVSb2xlIjoiUHJvdmlkZXIiLCJmaXJzdExvZ2luIjoiRmFsc2UiLCJmaWxlSWQiOiIiLCJtZXRob2QiOiIwIiwianRpIjoiZjg3ODVlMDEtNjhkYS00MWM4LTliMTEtMDE3Y2M3OTM3MTJkIiwibmJmIjoxNjExNzgyOTUwLCJleHAiOjE2MTIwNDIxNTAsImlzcyI6Iklzc3VlciIsImF1ZCI6IkF1ZGllbmNlIn0.75YLgxbOb3YIlwBA9Bz_mHkEQekr9RI5T9drEFBqB50';

  var billAmount = TextEditingController();

  var billNr = 11117;

  var _waiting = ''.obs;

  Future<String> addBill() async {
    billNr++;
    _waiting.value = 'الرجاء الإنتظار';
    Map<String, dynamic> data;
    var response = await http
        .put(
          'https://api-uat.tasdid.net/v1/api/Provider/AddBill',
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': '$serverToken',
          },
          body: jsonEncode(
            <String, dynamic>{
              "payId": "$billNr",
              "customerName": "سلام الكشميري",
              "dueDate": "2021-01-30T21:37:02.815Z",
              "payDate": "2021-01-28T21:37:02.815Z",
              "status": 0,
              "clientId": 0,
              "phoneNumber": "07703143818",
              "serviceId": "d3b653b0-a02a-4d17-91a9-da90db30975a",
              "amount": billAmount.text,
              "note": "دفع اونلاين"
            },
          ),
        )
        .then((value) => {
              data = json.decode(value.body),
              // print(data['data']['payId']),
              if (data['message'] == 'Duplicate PayId')
                {print(_waiting.value), _waiting.value = '', addBill()},
              if (data['message'] == 'Bill Created Successfully')
                Get.to(PayTasdid(id: data['data']['payId'])),
            });

    /* var response = await http.get(
      'https://jsonplaceholder.typicode.com/posts/',
      headers: <String, String>{
        'Content-Type': 'application/json',
        // 'Authorization': '$serverToken',
      },
    );
*/
    //print(response.body);
    // Map<String, dynamic> data = json.decode(response.body);
    // print(data['data']['payId']);
    // print(data['data']['id']);
    // print(data['data']['customerName']);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('NewCash'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: billAmount,
              ),
              RaisedButton(
                onPressed: () => addBill(),
                child: Text('add bill'),
              ),
              Obx(() => Text(_waiting.value))
            ],
          ),
        ),

        /* WebView(
          initialUrl:
              'https://pay.tasdid.net/?id=05670121003414351&url=https://facebook.com',
          javascriptMode: JavascriptMode.unrestricted,
        ),*/
      ),
    );
  }
}
