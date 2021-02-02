import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taswel/controllers/authController.dart';
import 'package:taswel/models/order.dart';
import 'package:get/get.dart';
import 'package:taswel/services/fireDb.dart';

class OrderDetail extends StatelessWidget {
  final AuthController _authController = Get.find();

  //final String orderId;
  final OrderModel order;

  OrderDetail({
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('order detail'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رقم الطلب : ' + order.orderNumber,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'حالة الطلب : ' + order.status,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'السبب : ' + order.statusTitle,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'إسم الزبون : ' + order.customerName,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'عنوان المبون :' + order.customerAddress,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'هاتف الزبون : ' + order.customerPhone,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'المحافظة : ' + order.deliveryToCity,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'المبلغ مع التوصيل : ' + order.amountAfterDelivery.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'تكلفة التوصيل : ' + order.deliveryCost.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'المحتوى : ' + order.orderType,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'ملاحظة : ' + order.commit,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding orderDetialText(String name, String detailName) {
    return Padding(
      padding: EdgeInsets.only(right: 18.0),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          '$name: $detailName',
          style: TextStyle(fontSize: 27),
        ),
      ),
    );
  }
}
