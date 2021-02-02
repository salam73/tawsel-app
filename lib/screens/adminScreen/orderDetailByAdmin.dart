import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taswel/controllers/authController.dart';
import 'package:get/get.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:taswel/services/fireDb.dart';

class OrderDetailByAdmin extends StatelessWidget {
  final AuthController _authController = Get.find();
  final firestoreInstance = FirebaseFirestore.instance;

  final String orderId;
  final String userId;

  OrderDetailByAdmin({this.orderId, this.userId});

  _onPressed2(String uid) {
    firestoreInstance.collection("users").doc(uid).get().then((querySnapshot) {
      print((querySnapshot.data()['shopName']));
    });
  }

  getUserName(String uid) {
    return GetX<UserController>(
      // init: Get.put(UserController()),
      initState: (_) async {
        await FireDb().getUser(uid: userId);
      },
      builder: (_userController) {
        return Column(
          children: [
            Text(_userController.user.shopName.toString()),
            Text(_userController.user.name.toString()),
            Text(_userController.user.phoneNumber.toString()),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var shopName = _onPressed2(_authController.user.uid) ?? 'asd';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الطلبية',
          style: GoogleFonts.cairo(),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          alignment: Alignment.centerRight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 60,
                child: Text(
                  "التفاصيل",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              StreamBuilder(
                // initialData: FireDb().getOrder(uid: _authController.user.uid, orderId:orderId ),
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .collection('orders')
                    .doc(orderId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  // print('orderId :' + snapshot.data.id);
                  // print('orderId2 :' + orderId);
                  return Column(
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          //  print(snapshot.data.id);
                          return Text(snapshot.data['shopName']);
                        },
                      ),
                      // ترتيب الجداول
                      Column(
                        children: [
                          orderDetialText(
                              'رقم الطلب', snapshot.data['orderNumber']),
                          orderDetialText('إسم الزبون',
                              snapshot.data['customerName'] ?? ''),
                          orderDetialText('عنوان الزبون',
                              snapshot.data['customerAddress'] ?? ''),
                          orderDetialText('تليفون الزبون',
                              snapshot.data['customerPhone'] ?? ''),
                          orderDetialText(
                              'المبلغ بعد التوصيل',
                              snapshot.data['amountAfterDelivery'].toString() ??
                                  ''),
                          orderDetialText('المحتوى',
                              snapshot.data['orderType'].toString() ?? ''),
                          orderDetialText('ملاحظة',
                              snapshot.data['commit'].toString() ?? ''),
                          orderDetialText('الحالة',
                              snapshot.data['status'].toString() ?? ''),
                        ],
                      ),
                      // orderDetialText('إسم المتجر', snapshot.data['shopName']),
                      // orderDetialText(
                      //     'المدينة', snapshot.data['deliveryToCity'] ?? ''),
                      //   orderDetialText(
                      //       'رقم الوكيل', snapshot.data['clientPhone'] ?? ''),

                      /*   orderDetialText('تم الإستلام',
                          snapshot.data['isPickup'] ? 'نعم' : 'لا'),
                      orderDetialText(
                          'تم التوصيل', snapshot.data['done'] ? 'نعم' : 'لا'), */
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget orderDetialText(String name, String detailName) {
    return Padding(
      padding: EdgeInsets.only(
        right: 18.0,
      ),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text(
          '$name: $detailName',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
