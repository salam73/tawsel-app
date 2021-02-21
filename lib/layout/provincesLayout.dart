import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taswel/layout/tableByProvinceId.dart';
import 'package:taswel/layout/tableByUserId.dart';
import 'package:get/get.dart';
import 'package:taswel/controllers/authController.dart';
import 'package:taswel/controllers/orderController.dart';
import 'package:taswel/controllers/themeController.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:taswel/models/order.dart';
import 'package:taswel/models/user.dart';
import 'package:taswel/screens/adminScreen/orderInputByAdmin.dart';
import 'package:taswel/screens/homeAdmin.dart';
import 'package:taswel/services/fireDb.dart';
// import 'flutter_web2/tutorial/getOrderList.dart';
import 'package:taswel/screens/OrdersListByUser.dart';
import 'package:taswel/testing/mainTest.dart';

import '../screens/adminScreen/orderInputByAdmin.dart';
import '../screens/adminScreen/orderInputByAdmin.dart';

// ignore: must_be_immutable
class ProvincesLayout extends StatelessWidget {
  // var userList = FireDb().getUsers();

  final OrderController orderController = Get.put(OrderController());
  // final AuthController _authController = Get.find();
  final ThemeController _themeController = Get.put(ThemeController());
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final UserModel userModel = Get.put(UserModel());
  getLightIcon() {
    if (_themeController.themeChange) {
      return Icon(Icons.lightbulb);
    } else {
      return Icon(Icons.lightbulb_outline);
    }
  }

  getUserName() {
    // return GetX<UserController>(
    //   init: Get.put(UserController()),
    //   initState: (_) async {
    //     Get.find<UserController>().user =
    //         await FireDb().getUser(uid: Get.find<AuthController>().user.uid);
    //   },
    //   builder: (_userController) {
    //     return Text((_userController.user == null)
    //         ? ""
    //         : _userController.user.name.toString());
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Obx(
                () => IconButton(
                  icon: getLightIcon(),
                  onPressed: () {
                    if (Get.isDarkMode) {
                      Get.changeTheme(ThemeData.light());
                      _themeController.themeChange = false;
                    } else {
                      Get.changeTheme(ThemeData.dark());
                      _themeController.themeChange = true;
                    }
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Wrap(
              children: OrderInputByAdmin()
                  .iraqProvinces
                  .map(
                    (item) => StreamBuilder(
                        stream: _firestore
                            .collection('orders')
                            // .where('byUserId', isEqualTo: _authController.user.uid)
                            .where('deliveryToCity', isEqualTo: item)
                            .snapshots(),
                        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData)
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  orderController.deliveryToCity.value = item;

                                  Get.to(TableByProvinceId());
                                },
                                child: Wrap(
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                25),
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child:
                                          Text('${snapshot.data.docs.length}'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          return Text('loading');
                        }),
                  )
                  .toList()
                  .cast<Widget>(),
            ),
          )
          // ListView.builder(
          //   itemCount: OrderInputByAdmin().country.length,
          //   itemBuilder: (_, index) {
          //     return StreamBuilder(
          //         stream: _firestore
          //             .collection('orders')
          //             // .where('byUserId', isEqualTo: _authController.user.uid)
          //             .where('deliveryToCity',
          //                 isEqualTo: OrderInputByAdmin().country[index])
          //             .snapshots(),
          //         builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          //           if (snapshot.hasData)
          //             return Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: InkWell(
          //                 onTap: () {
          //                   orderController.deliveryToCity.value =
          //                       OrderInputByAdmin().country[index];
          //                   Get.to(TableByProvinceId());
          //                 },
          //                 child: Wrap(
          //                   children: [
          //                     Text('${OrderInputByAdmin().country[index]}'),
          //                     Text('${snapshot.data.docs.length}'),
          //                   ],
          //                 ),
          //               ),
          //             );
          //           return Text('loading');
          //         });

          //     //  Text(OrderInputByAdmin().country[index]);
          //   },
          // ),

          //   ListView.builder(
          //     itemCount: OrderInputByAdmin().country.length,
          //     itemBuilder: (_, index) {
          //       orderController.streamOrdersByProvince(
          //           deliveryToCity: OrderInputByAdmin().country[index]);
          //       return InkWell(
          //         onTap: () {
          //           orderController.deliveryToCity.value =
          //               OrderInputByAdmin().country[index];
          //           Get.to(TableByProvinceId());
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Container(
          //             alignment: Alignment.center,
          //             // padding: EdgeInsets.all(8.0),
          //             constraints: BoxConstraints(minWidth: 100),
          //             decoration: BoxDecoration(
          //               border: Border.all(),
          //             ),
          //             child: Text(
          //               OrderInputByAdmin().country[index],
          //               style: TextStyle(fontSize: 25),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          ),
    );
  }
}
