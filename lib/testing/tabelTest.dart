import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taswel/controllers/orderController.dart';

class TableTest extends StatelessWidget {
  OrderController status = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    // status.orderStatus.value = 'hello';
    return Scaffold(
      appBar: AppBar(
        title: Text('tabletest'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Table",
              textScaleFactor: 2,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              textDirection: TextDirection.rtl,
              // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
              // border:TableBorder.all(width: 2.0,color: Colors.red),
              children: [
                TableRow(children: [
                  Text(
                    "Education",
                    textScaleFactor: 1.5,
                  ),
                  Text("Institution name", textScaleFactor: 1.5),
                  Text("University", textScaleFactor: 1.5),
                ]),
                TableRow(children: [
                  Text("B.Tech", textScaleFactor: 1.5),
                  Text("ABESEC", textScaleFactor: 1.5),
                  Text("AKTU", textScaleFactor: 1.5),
                ]),
                TableRow(children: [
                  Text("12th", textScaleFactor: 1.5),
                  Text("Delhi Public School", textScaleFactor: 1.5),
                  Text("CBSE", textScaleFactor: 1.5),
                ]),
                TableRow(children: [
                  Text("High School", textScaleFactor: 1.5),
                  Text("SFS", textScaleFactor: 1.5),
                  Text("ICSE", textScaleFactor: 1.5),
                ]),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
