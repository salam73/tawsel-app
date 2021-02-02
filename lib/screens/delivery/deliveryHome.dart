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
class DeliveryHome extends StatelessWidget {
  final String province;

  var orderStatusOBX = ''.obs;
  var headerStatusOBX = ''.obs;
  var orderTitleStatusOBX = ''.obs;
  var _valueOBX = 0.obs;

  var fireDb = FireDb();

  var _listOption = [
    'تم الإستلام',
    'واصل',
    'راجع',
    'مؤجل',
    'قيد التوصيل',
    'تم الدفع'
  ];

  OrderModel orderModel = OrderModel();
  OrderController orderController = Get.put(OrderController());
  var statusTitleController = TextEditingController();
  var deliveryCostController = TextEditingController();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  UserController _userController = Get.find();

  DeliveryHome({Key key, this.province}) : super(key: key);

  void updateLayout({String status}) {
    orderController.streamOrdersByProvinceAndStatus(
        status: status ?? orderController.orderStatusByProvince.value,
        deliveryToCity: orderController.deliveryToCity.value);

    print('provinceName: ${orderController.deliveryToCity.value}');
  }

  List<String> tokenList;

  void _onPressed({String clientEmail}) {
    print('user email ' + clientEmail);

    _firebaseFirestore
        .collection("cloudmessages")
        .where('userEmail', isEqualTo: clientEmail)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        tokenList.add(result.data()['token']);
        print('my tokens is' + result.data()['token']);
      });
    }).then((value) => CloudMessigeHttp().sendAndRetrieveMessage(
            title: orderModel.status,
            orderNr: orderModel.orderNumber,
            token: tokenList));

    tokenList = [];
  }

  @override
  Widget build(BuildContext context) {
    orderController.deliveryToCity.value = this.province;

    updateLayout(status: 'جاهز');
    //_onPressed();

    //print('orderController orderStatus:' + orderController.orderStatus.value);
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(orderController.deliveryToCity.value,
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
                  Obx(
                    () => Text(
                      orderController.orderStatusByProvince.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    orderController.allOrdersProvince.length.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //Obx(() => Text(orderController.allOrdersProvince.length.toString())),
            Wrap(
              alignment: WrapAlignment.center,
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
                    title: 'واصل', controller: orderController, status: 'واصل'),
                statusButton(
                    title: 'راجع', controller: orderController, status: 'راجع'),
                statusButton(
                    title: 'مؤجل', controller: orderController, status: 'مؤجل'),
                statusButton(
                    title: 'قيد التوصيل',
                    controller: orderController,
                    status: 'قيد التوصيل'),
                statusButton(
                    title: 'تم الدفع',
                    controller: orderController,
                    status: 'تم الدفع'),
              ],
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
                /*  headerTitle(
                    arbTitle: 'المحافظة',
                    engTitle: 'deliveryToCity',
                    controller: orderController),*/
                headerTitle(
                    arbTitle: 'المبلغ',
                    engTitle: 'amountAfterDelivery',
                    controller: orderController),
                /*  headerTitle(
                    arbTitle: 'النقل',
                    engTitle: 'deliveryCost',
                    controller: orderController),*/
                // headerTitle(
                //     arbTitle: 'التاريخ',
                //     engTitle: 'dateCreated',
                //     controller: orderController),
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
                    orderController.allOrdersProvince != null) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: orderController.allOrdersProvince.length,
                      itemBuilder: (_, index) {
                        // orderController.sumAmount.value =
                        //     orderController.sumAmount.value +
                        //         orderController
                        //             .allOrdersProvince[index].amountAfterDelivery;

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
                                          .allOrdersProvince[index].orderId,
                                      userId: orderController
                                          .allOrdersProvince[index].byUserId,
                                    ));
                                  },
                                  child: Text(orderController
                                      .allOrdersProvince[index].orderNumber),
                                )),
                                Expanded(
                                    child: Text(orderController
                                        .allOrdersProvince[index]
                                        .customerName)),
                                // Expanded(
                                //     child: Text(orderController
                                //         .allOrdersProvince[index]
                                //         .deliveryToCity)),
                                Expanded(
                                    child: Text(orderController
                                        .allOrdersProvince[index]
                                        .amountAfterDelivery
                                        .toString())),
                                // Expanded(
                                //     child: Text(orderController
                                //         .allOrdersProvince[index].deliveryCost
                                //         .toString())),
                                // Expanded(
                                //   child: Text(
                                //     DateFormat('yyyy-MM-dd').format(
                                //         orderController.allOrdersProvince[index]
                                //             .dateCreated
                                //             .toDate()),
                                //   ),
                                // ),
                                Expanded(
                                    child: Text(orderController
                                        .allOrdersProvince[index].status)),

                                // هنا قسم الحالة وعن طريقة يمكن تغير الحاله
                                Expanded(
                                    child: InkWell(
                                  onTap: () {
                                    // print(orderController
                                    //     .allOrdersProvince[index].orderId);
                                    // print(orderStatusOBX);
                                    // print(_valueOBX.value);
                                    // print('orderTitleStatusOBX ' +
                                    //     orderTitleStatusOBX.value);

                                    _valueOBX.value = 0;
                                    orderTitleStatusOBX.value = '';
                                    statusTitleController.text = '';
                                    orderStatusOBX.value = 'واصل';

                                    return showDialog(
                                      context: context,
                                      builder: (ctx) => Directionality(
                                        textDirection: ui.TextDirection.rtl,
                                        child: AlertDialog(
                                          title: Text(
                                              'تغير حالة الطلب ${orderController.allOrdersProvince[index].orderNumber} إلى :'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                for (int i = 0;
                                                    i < _listOption.length;
                                                    i++)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        _listOption[i],
                                                      ),
                                                      Obx(() => Radio(
                                                            value: i,
                                                            groupValue:
                                                                _valueOBX.value,
                                                            activeColor: Color(
                                                                0xFF6200EE),
                                                            onChanged: (value) {
                                                              _valueOBX.value =
                                                                  value;
                                                              // orderStatus.value =
                                                              //     _listOption[value];
                                                              orderTitleStatusOBX
                                                                      .value =
                                                                  _listOption[
                                                                      value];
                                                              orderStatusOBX
                                                                      .value =
                                                                  _listOption[
                                                                      value];
                                                            },
                                                          )),
                                                    ],
                                                  ),
                                                Obx(
                                                  () => TextField(
                                                    controller:
                                                        statusTitleController,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          orderTitleStatusOBX
                                                              .value,
                                                      labelStyle: TextStyle(
                                                          fontSize: 14),
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();

                                                orderModel = orderController
                                                    .allOrdersProvince[index];

                                                orderModel.status = _listOption[
                                                    _valueOBX.value];

                                                orderModel.statusTitle =
                                                    statusTitleController.text;

                                                // statusTitleController.text

                                                _onPressed(
                                                    clientEmail: orderController
                                                        .allOrdersProvince[
                                                            index]
                                                        .clientEmail);

                                                FireDb().updateOrderByUserId(
                                                    order: orderModel,
                                                    clientId:
                                                        orderModel.byUserId,
                                                    uid: orderController
                                                        .allOrdersProvince[
                                                            index]
                                                        .orderId);

                                                updateLayout();
                                              },
                                              child: Text("تم"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                    /* Get.defaultDialog(

                                        //confirm: Text('ok'),
                                        // textCancel: 'إلغاء',
                                        // onCancel: null,
                                        textConfirm: 'ok',
                                        confirmTextColor: Colors.white,
                                        onConfirm: () {
                                          orderModel = orderController
                                              .allOrdersProvince[index];

                                          orderModel.status =
                                              _listOption[_valueOBX.value];

                                          orderModel.statusTitle =
                                              statusTitleController.text;

                                          // statusTitleController.text

                                          print('clinetid ' +
                                              orderController.clientId.value);

                                          print('client email ' +
                                              orderController
                                                  .allOrdersProvince[index]
                                                  .clientEmail);

                                          _onPressed(
                                              clientEmail: orderController
                                                  .allOrdersProvince[index]
                                                  .clientEmail);

                                          FireDb().updateOrderByUserId(
                                              order: orderModel,
                                              clientId: orderModel.byUserId,
                                              uid: orderController
                                                  .allOrdersProvince[index]
                                                  .orderId);

                                          updateLayout();

                                          */
                                    /* orderController.streamStatus(
                                              status: orderController
                                                  .orderStatus.value,
                                              orderByName: orderController
                                                  .orderBySortingName.value,
                                              clientId: orderController
                                                  .clientId.value);*/ /*
                                          */
                                    /*  getAllAmount(
                                              status: orderController
                                                  .orderStatus.value,
                                              sortingByName: orderController
                                                  .orderBySortingName.value);*/
                                    /*

                                          print('orderController orderStatus:' +
                                              orderController
                                                  .orderStatusByUser.value);

                                          print(_listOption[_valueOBX.value]);
                                          Get.back();
                                        },
                                        title:
                                            'تغير حالة الطلب ${orderController.allOrdersProvince[index].orderNumber} إلى :',
                                        content: Directionality(
                                          textDirection: ui.TextDirection.rtl,
                                          child: SingleChildScrollView(
                                            physics: ScrollPhysics(),
                                            child: Column(
                                              children: <Widget>[
                                                for (int i = 0;
                                                    i < _listOption.length;
                                                    i++)
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        _listOption[i],
                                                      ),
                                                      Obx(() => Radio(
                                                            value: i,
                                                            groupValue:
                                                                _valueOBX.value,
                                                            activeColor: Color(
                                                                0xFF6200EE),
                                                            onChanged: (value) {
                                                              _valueOBX.value =
                                                                  value;
                                                              // orderStatus.value =
                                                              //     _listOption[value];
                                                              orderTitleStatusOBX
                                                                      .value =
                                                                  _listOption[
                                                                      value];
                                                              orderStatusOBX
                                                                      .value =
                                                                  _listOption[
                                                                      value];
                                                            },
                                                          )),
                                                    ],
                                                  ),
                                                Obx(
                                                  () => TextField(
                                                    controller:
                                                        statusTitleController,
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          orderTitleStatusOBX
                                                              .value,
                                                      labelStyle: TextStyle(
                                                          fontSize: 14),
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        middleText: orderController
                                            .allOrdersProvince[index].orderId);*/
                                  },
                                  child: Container(
                                    child: Text(orderController
                                        .allOrdersProvince[index].statusTitle),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text('المبلغ مع التوصيل: '),
                // Obx(
                //   () => Container(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       orderController.getAllAmount().toString(),
                //     ),
                //   ),
                // ),
                // Text('كلفة النقل: '),
                // Obx(() => Text(orderController.getDeliveryCost().toString())),
                Text('صافي المبلغ: '),
                Obx(
                  () => Text(
                    (orderController.getAllAmountProvince() -
                            orderController.getDeliveryCostProvince())
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
        controller.orderStatusByProvince.value = status;
        // orderStatus.value = status;

        controller.streamOrdersByProvinceAndStatus(
            status: status,
            deliveryToCity: orderController.deliveryToCity.value);

        print('orderController orderStatus:' +
            controller.orderStatusByProvince.value);
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

          // controller.streamStatus(
          //     orderByName: engTitle,
          //     status: controller.orderStatus.value,
          //     clientId: controller.clientId.value);

          print('orderController orderStatus:' +
              controller.orderStatusByUser.value);
        },
        child: Text(arbTitle),
      ),
    );
  }
}
