import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:taswel/controllers/authController.dart';
import 'package:taswel/controllers/userController.dart';

import 'appByUser/orderDetail.dart';

/*
class OrdersListByUser extends StatelessWidget {
  final AuthController _authController = Get.find();
  final UserController _userControler = Get.put(UserController());

  final String userId;

  OrdersListByUser({Key key, this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_userControler.user.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logOut();
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('byUserId', isEqualTo: userId)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            print(snapshot.data.docs.length.toString());

            return GroupedListView<dynamic, String>(
              elements: snapshot.data.docs,
              groupBy: (element) => DateFormat('yyyy-MM-dd')
                  .format(element['dateCreated'].toDate())
                  .toString(),
              //element.deliveryToCity,
              groupComparator: (value1, value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) =>
                  item1['deliveryToCity'].compareTo(item2['deliveryToCity']),
              order: GroupedListOrder.ASC,
              useStickyGroupSeparators: true,
              groupSeparatorBuilder: (String value) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              itemBuilder: (c, element) {
                return InkWell(
                  onTap: () {
                    Get.to(OrderDetail(
                      order: element,
                    ));
                  },
                  child: Card(
                    color: element['done'] ? Colors.green : Colors.grey,
                    elevation: 8.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Icon(Icons.account_circle),
                        title: Text('${element['deliveryToCity']} - '
                            '${element['amountAfterDelivery']} - '
                            '${element['orderNumber']}'),
                        trailing: Wrap(
                          spacing: 10,
                          children: [
                            //  Icon(Icons.arrow_forward),

                            Icon(
                              Icons.get_app,
                              color:
                                  element['done'] ? Colors.green : Colors.black,
                            ),
                            Icon(
                              Icons.input,
                              color:
                                  element['done'] ? Colors.green : Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );

            */
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
            ).toList());*/ /*

          }),
    );
  }
}
*/
