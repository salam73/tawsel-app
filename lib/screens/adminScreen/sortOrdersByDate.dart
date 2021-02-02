import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:taswel/screens/adminScreen/orderDetailByAdmin.dart';
import 'package:taswel/screens/appByUser/orderDetail.dart';

class SortOrdersByDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              // .where('byUserId', isEqualTo: userId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            //  print(snapshot.data.docs.length.toString());

            return Column(
              children: [
                Expanded(
                  child: GroupedListView<dynamic, String>(
                    elements: snapshot.data.docs,
                    groupBy:
                        // (element) => element['deliveryToCity'],
                        (element) => DateFormat('yyyy-MM-dd')
                            .format(element['dateCreated'].toDate())
                            .toString(),
                    //element.deliveryToCity,
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    itemComparator: (item1, item2) => item1['deliveryToCity']
                        .compareTo(item2['deliveryToCity']),
                    order: GroupedListOrder.ASC,
                    //floatingHeader: false,
                    // useStickyGroupSeparators: true,
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    itemBuilder: (c, element) {
                      // int f = 0;
                      return InkWell(
                        onTap: () {
                          Get.to(OrderDetailByAdmin(
                            orderId: element.id,
                            userId: element['byUserId'],
                          ));
                        },
                        child: Card(
                          color: element['done'] ? Colors.green : Colors.grey,
                          elevation: 7.0,
                          child: Container(
                            child: Column(
                              children: [
                                ListTile(
                                  // contentPadding: EdgeInsets.symmetric(
                                  //     horizontal: 20.0, vertical: 10.0),
                                  // leading: Icon(Icons.account_circle),
                                  title: Text(
                                    '${element['deliveryToCity']} - '
                                    '${element['amountAfterDelivery']} - '
                                    '${element['status']} - '
                                    '${element['orderNumber']} - '
                                    //'${element['byUserId']} - '
                                    // 'order id: ${element.id}'
                                    // '${element['byUserId']}'
                                    ,
                                    textAlign: TextAlign.end,
                                  ),
                                  trailing: Wrap(
                                    spacing: 10,
                                    children: [
                                      //  Icon(Icons.arrow_forward),

                                      element['done']
                                          ? Icon(Icons.input)
                                          : Text(''),
                                      element['isPickup']
                                          ? Icon(Icons.get_app)
                                          : Text(''),
                                      // Icon(Icons.get_app)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );

            /*ListView(
                children: snapshot.data.docs.map(
              (document) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(document['shopName'].toString() ?? ''),
                    Text(document['deliveryToCity'].toString() ?? ''),
                    Text(document['clientPhone'].toString() ?? ''),
                    Text(document['customerAddress'].toString() ?? ''),
                    Text(document['customerPhone'].toString() ?? ''),
                    Text(document['done'].toString() ?? ''),
                  ],
                );
              },
            ).toList());*/
          }),
    );
  }
}
