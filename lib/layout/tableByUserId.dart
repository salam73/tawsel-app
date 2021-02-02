import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taswel/controllers/authController.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:get/get.dart';
import 'package:taswel/controllers/orderController.dart';
import 'package:taswel/models/order.dart';
import 'package:taswel/screens/adminScreen/orderDetailByAdmin.dart';
import 'package:taswel/screens/appByUser/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:taswel/services/fireDb.dart';
import 'package:taswel/testing/cloudMessigeHttp.dart';

// ignore: must_be_immutable
class TableByUserId extends StatelessWidget {
  final String tokenEmail;

  var orderStatusOBX = ''.obs;
  var headerStatusOBX = ''.obs;
  var orderTitleStatusOBX = ''.obs;
  var _valueOBX = 0.obs;

  var myStatus = '';

  var fireDb = FireDb();

  var _listOption = [
    'تم الإستلام',
    'راجع',
    'مؤجل',
    'قيد التوصيل',
    'واصل',
    'تم الدفع'
  ];

  OrderModel orderModel = OrderModel();
  OrderController orderController = Get.put(OrderController());
  UserController _userController = Get.find();
  var statusTitleController = TextEditingController();
  var deliveryCostController = TextEditingController();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  TableByUserId({Key key, this.tokenEmail}) : super(key: key);

  void updateLayout({String status}) {
    orderController.streamOrdersByUserAndStatus(
        status: status ?? orderController.orderStatusByUser.value,
        clientId: orderController.clientId.value);
  }

  List<String> tokenList;

  void _onPressed() {
    print('user email ' + _userController.userModel.value.email);

    _firebaseFirestore
        .collection("cloudmessages")
        .where('userEmail', isEqualTo: tokenEmail)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        tokenList.add(result.data()['token']);
        print('my tokens is' + result.data()['token']);
      });
    });
    tokenList = [];
    print(tokenList);
  }

  @override
  Widget build(BuildContext context) {
    updateLayout(status: 'جاهز');
    _onPressed();

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Get.find<UserController>().currentUser.value,
              style: GoogleFonts.cairo()),
        ),
        body: Center(
            /**/
            child: Column(
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    myStatus,
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    orderController.allOrdersUser.length.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //Obx(() => Text(orderController.allOrders.length.toString())),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  statusButton(
                    title: 'جاهز',
                    controller: orderController,
                    status: 'جاهز',
                  ),
                  statusButton(
                    title: 'تم الإستلام',
                    controller: orderController,
                    status: 'تم الإستلام',
                  ),
                  statusButton(
                    title: 'راجع',
                    controller: orderController,
                    status: 'راجع',
                  ),
                  statusButton(
                    title: 'مؤجل',
                    controller: orderController,
                    status: 'مؤجل',
                  ),
                  statusButton(
                    title: 'قيد التوصيل',
                    controller: orderController,
                    status: 'قيد التوصيل',
                  ),
                  statusButton(
                    title: 'واصل',
                    controller: orderController,
                    status: 'واصل',
                  ),
                  statusButton(
                    title: 'تم الدفع',
                    controller: orderController,
                    status: 'تم الدفع',
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //جدول المعلومات

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text('Nr.'),
                ),
                headerTitle(
                    arbTitle: 'الرقم',
                    engTitle: 'orderNumber',
                    controller: orderController),
                headerTitle(
                    arbTitle: 'الإسم',
                    engTitle: 'customerName',
                    controller: orderController),
                headerTitle(
                    arbTitle: 'المحافظة',
                    engTitle: 'deliveryToCity',
                    controller: orderController),
                headerTitle(
                    arbTitle: 'المبلغ',
                    engTitle: 'amountAfterDelivery',
                    controller: orderController),
                headerTitle(
                    arbTitle: 'النقل',
                    engTitle: 'deliveryCost',
                    controller: orderController),
                headerTitle(
                    arbTitle: 'التاريخ',
                    engTitle: 'dateCreated',
                    controller: orderController),
                Expanded(
                  child: Text('الحالة'),
                ),
                Expanded(
                  child: Text('سبب الحالة'),
                )
              ],
            ),
            Divider(
              thickness: 1,
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            GetX<OrderController>(
              init: Get.put(OrderController()),
              builder: (OrderController orderController) {
                // orderController.sumAmount.value = 0;
                if (orderController != null &&
                    orderController.allOrdersUser != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: orderController.allOrdersUser.length,
                      itemBuilder: (_, index) {
                        // orderController.sumAmount.value =
                        //     orderController.sumAmount.value +
                        //         orderController
                        //             .allOrders[index].amountAfterDelivery;

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    (index + 1).toString(),
                                  ),
                                ),
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    Get.to(OrderDetailByAdmin(
                                      orderId: orderController
                                          .allOrdersUser[index].orderId,
                                      userId: orderController
                                          .allOrdersUser[index].byUserId,
                                    ));
                                  },
                                  child: Text(orderController
                                      .allOrdersUser[index].orderNumber),
                                )),
                                Expanded(
                                    child: Text(orderController
                                        .allOrdersUser[index].customerName)),
                                Expanded(
                                    child: Text(orderController
                                        .allOrdersUser[index].deliveryToCity)),
                                Expanded(
                                    child: Text(orderController
                                        .allOrdersUser[index]
                                        .amountAfterDelivery
                                        .toString())),

                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                        textCancel: 'إلغاء',
                                        onCancel: null,
                                        textConfirm: 'ok',
                                        confirmTextColor: Colors.white,
                                        onConfirm: () {
                                          orderModel = orderController
                                              .allOrdersUser[index];

                                          orderModel.deliveryCost = int.parse(
                                              deliveryCostController.text);

                                          // statusTitleController.text

                                          FireDb().updateOrderByUserId(
                                              order: orderModel,
                                              clientId: orderController
                                                  .clientId.value,
                                              uid: orderController
                                                  .allOrdersUser[index]
                                                  .orderId);

                                          /*orderController.streamStatus(
                                              status: orderController
                                                  .orderStatus.value,
                                              orderByName: orderController
                                                  .orderBySortingName.value,
                                              clientId: orderController
                                                  .clientId.value);*/
                                          /*  getAllAmount(
                                              status: orderController
                                                  .orderStatus.value,
                                              sortingByName: orderController
                                                  .orderBySortingName.value);*/

                                          // print(_listOption[_valueOBX.value]);
                                          Get.back();
                                        },
                                        title:
                                            'تغير سعر النقل ${orderController.allOrdersUser[index].orderNumber} إلى ',
                                        content: TextField(
                                          controller: deliveryCostController,
                                        ));
                                  },
                                  child: Text(orderController
                                      .allOrdersUser[index].deliveryCost
                                      .toString()),
                                )),
                                Expanded(
                                  child: Text(
                                    DateFormat('yyyy-MM-dd').format(
                                        orderController
                                            .allOrdersUser[index].dateCreated
                                            .toDate()),
                                  ),
                                ),
                                Expanded(
                                    child: Text(orderController
                                        .allOrdersUser[index].status)),
                                // هنا قسم الحالة وعن طريقة يمكن تغير الحاله
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      // print(orderController
                                      //     .allOrders[index].orderId);
                                      // print(orderStatusOBX);
                                      // print(_valueOBX.value);
                                      // print('orderTitleStatusOBX ' +
                                      //     orderTitleStatusOBX.value);

                                      _valueOBX.value = 0;
                                      orderTitleStatusOBX.value = '';
                                      statusTitleController.text = '';
                                      // orderStatusOBX.value = 'واصل';

                                      Get.defaultDialog(

                                          //confirm: Text('ok'),
                                          textCancel: 'إلغاء',
                                          onCancel: null,
                                          textConfirm: 'ok',
                                          confirmTextColor: Colors.white,
                                          onConfirm: () {
                                            orderModel = orderController
                                                .allOrdersUser[index];

                                            orderModel.status =
                                                _listOption[_valueOBX.value];

                                            orderModel.statusTitle =
                                                statusTitleController.text;
                                            /*  if (_listOption[_valueOBX.value] ==
                                              'راجع') */
                                            CloudMessigeHttp()
                                                .sendAndRetrieveMessage(
                                                    title: orderModel.status,
                                                    orderNr:
                                                        orderModel.orderNumber,
                                                    token: tokenList);

                                            // statusTitleController.text

                                            print('clinetid ' +
                                                orderController.clientId.value);

                                            FireDb().updateOrderByUserId(
                                                order: orderModel,
                                                clientId: orderController
                                                    .clientId.value,
                                                uid: orderController
                                                    .allOrdersUser[index]
                                                    .orderId);

                                            updateLayout();

                                            /* orderController.streamStatus(
                                              status: orderController
                                                  .orderStatus.value,
                                              orderByName: orderController
                                                  .orderBySortingName.value,
                                              clientId: orderController
                                                  .clientId.value);*/
                                            /*  getAllAmount(
                                              status: orderController
                                                  .orderStatus.value,
                                              sortingByName: orderController
                                                  .orderBySortingName.value);*/

                                            print(_listOption[_valueOBX.value]);
                                            Get.back();
                                          },
                                          title:
                                              'تغير حالة الطلب ${orderController.allOrdersUser[index].orderNumber} إلى :',
                                          content: Column(
                                            children: [
                                              for (int i = 0;
                                                  i < _listOption.length;
                                                  i++)
                                                ListTile(
                                                  title: Text(
                                                    _listOption[i],
                                                  ),
                                                  leading: Obx(() => Radio(
                                                        value: i,
                                                        groupValue:
                                                            _valueOBX.value,
                                                        activeColor:
                                                            Color(0xFF6200EE),
                                                        onChanged: (value) {
                                                          _valueOBX.value =
                                                              value;
                                                          // orderStatus.value =
                                                          //     _listOption[value];
                                                          orderTitleStatusOBX
                                                                  .value =
                                                              _listOption[
                                                                  value];
                                                          orderStatusOBX.value =
                                                              _listOption[
                                                                  value];
                                                          // statusTitleController.text= _listOption[value];

                                                          print(_valueOBX);
                                                          print(
                                                              'orderStatusOBX.value' +
                                                                  orderStatusOBX
                                                                      .value);
                                                        },
                                                      )),
                                                ),
                                              Obx(
                                                () => TextField(
                                                  controller:
                                                      statusTitleController,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        orderTitleStatusOBX
                                                            .value,
                                                    labelStyle:
                                                        TextStyle(fontSize: 14),
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          middleText: orderController
                                              .allOrdersUser[index].orderId);
                                    },
                                    child: Container(
                                      child: Text(orderController
                                          .allOrdersUser[index].statusTitle),
                                      color: Colors.lightBlueAccent,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              thickness: 2,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        value: 10,
                      ),
                    ),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('المبلغ مع التوصيل: '),
                // Expanded(
                //   child: Obx(
                //     () => Container(
                //       alignment: Alignment.centerRight,
                //       child: Text(
                //         orderController.getAllAmount().toString(),
                //       ),
                //     ),
                //   ),
                // ),
                // Text('كلفة النقل: '),
                // Expanded(
                //     child: Obx(() =>
                //         Text(orderController.getDeliveryCost().toString()))),
                Text('صافي المبلغ: '),
                Obx(
                  () => Text(
                    (orderController.getAllAmount() -
                            orderController.getDeliveryCost())
                        .toString(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        )),
      ),
    );
  }

  Widget statusButton({
    String title,
    OrderController controller,
    String status,
  }) {
    return RaisedButton(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title),
      ),
      onPressed: () {
        controller.orderStatusByUser.value = status;
        // orderStatus.value = status;
        // myStatus = status;

        controller.streamOrdersByUserAndStatus(
            status: status, clientId: orderController.clientId.value);

        /*  getAllAmount(status: status);*/
      },
    );
  }

  Widget headerTitle({
    String arbTitle,
    String engTitle,
    OrderController controller,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.orderBySortingName.value = engTitle;

          controller.streamOrdersByUserAndStatus(
              orderByName: engTitle,
              status: orderController.orderStatusByUser.value,
              clientId: controller.clientId.value);
        },
        child: Text(arbTitle),
      ),
    );
  }
}
