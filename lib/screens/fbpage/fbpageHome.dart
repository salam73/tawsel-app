import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:taswel/controllers/authController.dart';

import 'package:taswel/screens/adminScreen/orderDetailByAdmin.dart';
import 'package:taswel/screens/appByUser/orderInput.dart';

import 'package:taswel/services/fireDb.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'dart:ui' as ui;

class FbPageHome extends StatelessWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController _authController = Get.find();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  var myStatus = 'تم الإستلام'.obs;
  int getAmount(List<QueryDocumentSnapshot> list) {
    int start = 0;
    list.forEach((element) {
      start = start + element['amountAfterDelivery'];
    });
    return start;
  }

  int getDeliveryCost(List<QueryDocumentSnapshot> list) {
    int start = 0;
    list.forEach((element) {
      start = start + element['deliveryCost'];
    });
    return start;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                _authController.logOut();
                // Get.to(Login());
              },
            ),
          ],
          title: Text(''),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // OrderAlert().addOrderDialog();
            Get.to(OrderInput());
          },
        ),
        body: Center(
          child: Container(
            child: Obx(
              () => StreamBuilder(
                stream: FireDb()
                    .getFBPageOrders(_authController.user.uid, myStatus.value),
                builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Obx(
                          () => Text(
                              '${myStatus.value}: ${snapshot.data.docs.length}'),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            statusButton(title: 'جاهز', color: Colors.blue),
                            statusButton(
                                title: 'تم الإستلام', color: Colors.grey),
                            statusButton(
                              title: 'راجع',
                              color: Colors.red,
                            ),
                            statusButton(title: 'مؤجل', color: Colors.purple),
                            statusButton(
                                title: 'قيد التوصيل', color: Colors.amber),
                            statusButton(
                                title: 'واصل', color: Colors.greenAccent),
                            statusButton(
                                title: 'تم الدفع', color: Colors.green),
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (_, index) {
                              if (snapshot.data.docs.length > 0)
                                return InkWell(
                                  onTap: () {
                                    // Test2().sendAndRetrieveMessage(
                                    //     title: snapshot.data.docs[index]
                                    //         ['status'],
                                    //     orderNr: snapshot.data.docs[index]
                                    //         ['orderNumber']);

                                    Get.to(OrderDetailByAdmin(
                                      orderId: snapshot.data.docs[index].id,
                                      userId: snapshot.data.docs[index]
                                          ['byUserId'],
                                    ));
                                  },
                                  child: Card(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            '${index + 1}\n${snapshot.data.docs[index]['orderNumber']}',
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'customerName'),
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'customerAddress'),
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'deliveryToCity'),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'customerPhone'),
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'orderType'),
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'commit'),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            children: [
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'amountAfterDelivery'),
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'deliveryCost'),
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'dateCreated'),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              /*  buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'status'), */
                                              buttonTitle(
                                                  list: snapshot.data.docs,
                                                  index: index,
                                                  title: 'statusTitle'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              return Text('Loading');
                            },
                          ),
                        ),
                        Column(
                          children: [
                            Text(getAmount(snapshot.data.docs).toString()),
                            Text(
                                getDeliveryCost(snapshot.data.docs).toString()),
                          ],
                        )
                      ],
                    );
                  }

                  return Text('noData');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonTitle(
      {List<QueryDocumentSnapshot> list, int index, String title}) {
    return Container(
      child: title == 'dateCreated'
          ? Text(DateFormat('yyyy-MM-dd').format(list[index][title].toDate()))
          : Text(
              list[index][title].toString(),
            ),
      // alignment: Alignment.centerRight,
    );
  }

  Widget statusButton({
    String title,
    Color color,
  }) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: RaisedButton(
        color: color,
        onPressed: () {
          myStatus.value = title;
        },
        child: Text(title, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
