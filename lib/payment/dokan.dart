import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taswel/payment/paytasdid.dart';
import 'package:taswel/payment/product.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class Dokan extends StatelessWidget {
  final String serverToken =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyZjY5MWYwZC0yOTgxLTQ3MjUtOWYzYy0wYjg2YjE2YjJjODEiLCJlbWFpbCI6InNhbGFtLmFwcEB0YXNkaWQubmV0IiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6InNhbGFtLmFwcCIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IlByb3ZpZGVyIiwiRmVSb2xlIjoiUHJvdmlkZXIiLCJmaXJzdExvZ2luIjoiRmFsc2UiLCJmaWxlSWQiOiIiLCJtZXRob2QiOiIwIiwianRpIjoiZjg3ODVlMDEtNjhkYS00MWM4LTliMTEtMDE3Y2M3OTM3MTJkIiwibmJmIjoxNjExNzgyOTUwLCJleHAiOjE2MTIwNDIxNTAsImlzcyI6Iklzc3VlciIsImF1ZCI6IkF1ZGllbmNlIn0.75YLgxbOb3YIlwBA9Bz_mHkEQekr9RI5T9drEFBqB50';

  var billAmount = TextEditingController();

  var billNr = 11117;

  var _waiting = ''.obs;
  RxList<dynamic> myImageList = [].obs;

  Future<String> addBill() async {
    //

    var data;
    billNr++;
    _waiting.value = 'الرجاء الإنتظار';
    myImageList.assignAll([]);

    var response = await http
            .get(
              'https://quickcash.vip/wp-json/wc/v3/products?'
              'consumer_key=ck_a0961fadb5c0d92528db91a385d23cd1185abc08'
              '&'
              'consumer_secret=cs_1ba9a498ff26a38d7edacdbb12723221b1633060'
              '&'
              'per_page=100',
            )
            .then((value) => {
                  _waiting.value = '',

                  data = json.decode(value.body),
                  print(data.length),
                  //
                  for (int x = 0; x < data.length; x++)
                    for (int i = 0; i < data[x]['images'].length; i++)
                      {
                        print(data[x]['images'].length.toString()),
                        print(data[x]['images'][i]['src']),
                        myImageList.add(Column(
                          children: [
                            Text(data[x]['name']),
                            // Text(data[x]['description']),
                            // Text(data[x]['short_description']),
                            Image.network(
                              data[x]['images'][i]['src'],
                              height: 100,
                            ),
                          ],
                        ))
                      }
                })
        /* .then((value) => {
              data = json.decode(value.body),
              print(data[0]['images']),
              //  print(value.body),
              _waiting.value = ''
            })*/

        ;

    /* var response = await http.get(
      'https://jsonplaceholder.typicode.com/posts/',
      headers: <String, String>{
        'Content-Type': 'application/json',
        // 'Authorization': '$serverToken',
      },
    );
*/
    // print(response.body);
  }

  Future<Product> fetchAlbum() async {
    final response =
        await http.get('https://quickcash.vip/wp-json/wc/v3/products?'
            'consumer_key=ck_c688de1bcd9678f85645033817568e21e4069f51'
            '&'
            'consumer_secret=cs_bd923225cdbd6ba9fffae211cf8f4f878ba841c8');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Product.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: billAmount,
                ),
                RaisedButton(
                  onPressed: () => {addBill()},
                  child: Text('add bill'),
                ),
                Obx(() => Text(_waiting.value)),
                Obx(
                  () => Wrap(
                    children: [
                      for (int x = 0; x < myImageList.length; x++)
                        myImageList[x]
                    ],
                  ),
                ),
              ],
            ),
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
