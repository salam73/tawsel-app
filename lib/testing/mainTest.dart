import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:taswel/controllers/orderController.dart';
import 'package:taswel/models/order.dart';
import 'package:taswel/screens/adminScreen/orderDetailByAdmin.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:taswel/services/fireDb.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class MainTest extends StatelessWidget {
  var orderController = Get.put(OrderController());

  var _listOption = ['تم الإستلام', 'واصل', 'راجع', 'مؤجل', 'قيد التوصيل'];
  var orderStatusOBX = ''.obs;
  var headerStatusOBX = ''.obs;
  var orderTitleStatusOBX = ''.obs;
  var _valueOBX = 0.obs;
  var statusTitleController = TextEditingController();

  OrderModel orderModel = OrderModel();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateOrder2(
      {OrderModel order, String clientId, String uid}) async {
    try {
      _firestore
          .collection("users")
          .doc(clientId)
          .collection("orders")
          .doc(uid)
          .update(order.toJson());

      //     .update(order.toJson());

      //  _firestore.collection("orders").doc(uid).update({'status': 'واصل'});
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    orderController.streamOrdersByUserAndStatus(
        clientId: 'zPx1WqwCg3W64KfbSYyZSJvH11y2');

    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
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
                        title: 'واصل',
                        controller: orderController,
                        status: 'واصل'),
                    statusButton(
                        title: 'راجع',
                        controller: orderController,
                        status: 'راجع'),
                    statusButton(
                        title: 'مؤجل',
                        controller: orderController,
                        status: 'مؤجل'),
                    statusButton(
                        title: 'قيد التوصيل',
                        controller: orderController,
                        status: 'قيد التوصيل'),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                          .allOrdersUser[index]
                                          .deliveryToCity)),
                                  Expanded(
                                      child: Text(orderController
                                          .allOrdersUser[index]
                                          .amountAfterDelivery
                                          .toString())),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {},
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
                                      orderStatusOBX.value = 'واصل';

                                      Get.defaultDialog(

                                          //confirm: Text('ok'),
                                          textCancel: 'إلغاء',
                                          onCancel: null,
                                          textConfirm: 'ok',
                                          confirmTextColor: Colors.white,
                                          onConfirm: () {
                                            // statusTitleController.text

                                            print('clinetid ' +
                                                orderController.clientId.value);

                                            orderModel = orderController
                                                .allOrdersUser[index];
                                            orderModel.status =
                                                _listOption[_valueOBX.value];

                                            updateOrder2(
                                                order: orderModel,
                                                clientId:
                                                    'zPx1WqwCg3W64KfbSYyZSJvH11y2',
                                                uid: orderController
                                                    .allOrdersUser[index]
                                                    .orderId);

                                            //  updateLayout();

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

                                            Get.back();
                                          },
                                          title:
                                              'تغير حالة الطلب ${orderController.allOrdersUser[index].orderNumber} إلى :',
                                          content: Column(
                                            children: <Widget>[
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
                                  ))
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
            ],
          ),
        ),
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
        // controller.orderStatus.value = status;
        // orderStatus.value = status;

        controller.streamOrdersByUserAndStatus(
            status: title, clientId: 'zPx1WqwCg3W64KfbSYyZSJvH11y2');

        print('orderController orderStatus:' +
            controller.orderStatusByUser.value);
        print('orderStatusOBX:' + orderStatusOBX.value);
        print('status:' + status);
        /*  getAllAmount(status: status);*/
      },
    );
  }
}
