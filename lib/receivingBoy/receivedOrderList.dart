// import 'package:flutter/material.dart';
// import 'package:taswel/controllers/orderController.dart';
// import 'package:taswel/controllers/userController.dart';
// import 'package:taswel/models/order.dart';
// import 'package:taswel/models/user.dart';
// import 'package:taswel/services/fireDb.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import 'dart:ui' as ui;
//
// class ReceivedOrderList extends StatelessWidget {
//   var sumOfAmountOBX = 0.obs;
//   var sumOfDeliveryCostOBX = 0.obs;
//   var orderStatusOBX = ''.obs;
//   var headerStatusOBX = ''.obs;
//   var orderTitleStatusOBX = ''.obs;
//   var _valueOBX = 0.obs;
//
//   String orderCondition = '';
//   var fireDb = FireDb();
//
//   var _listOption = ['واصل', 'راجع', 'مؤجل', 'قيد الإرسال'];
//
//   OrderModel orderModel = OrderModel();
//   OrderController orderController = Get.put(OrderController());
//   UserModel _userModel = UserModel();
//   var statusTitleController = TextEditingController();
//   var deliveryCostController = TextEditingController();
//
//   void getAllAmount({String status, String sortingByName, String clientId}) {
//     // orderController.streamStatus(
//     //     clientId: clientId, status: status, orderByName: sortingByName);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: ui.TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(Get.find<UserController>().currentUser.value ?? ''),
//         ),
//         body: Center(
//             child: Column(
//           children: [
//             //جدول المعلومات
//
//             GetX<OrderController>(
//               init: Get.put(OrderController()),
//               builder: (OrderController orderController) {
//                 // orderController.sumAmount.value = 0;
//                 if (orderController != null &&
//                     orderController.allOrdersUser != null) {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: orderController.allOrdersUser.length,
//                       itemBuilder: (_, index) {
//                         print('length ' +
//                             orderController.allOrdersUser.length.toString());
//                         // orderController.sumAmount.value =
//                         //     orderController.sumAmount.value +
//                         //         orderController
//                         //             .allOrders[index].amountAfterDelivery;
//
//                         return Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     (index + 1).toString(),
//                                   ),
//                                 ),
//                                 Expanded(
//                                     child: InkWell(
//                                   onTap: () {
//                                     // Get.to(OrderDetailByAdmin(
//                                     //   orderId: orderController
//                                     //       .allOrders[index].orderId,
//                                     //   userId: orderController
//                                     //       .allOrders[index].byUserId,
//                                     // ));
//                                   },
//                                   child: Text(orderController
//                                       .allOrdersUser[index].orderNumber),
//                                 )),
//                                 Expanded(
//                                     child: Text(orderController
//                                         .allOrdersUser[index].customerName)),
//                                 Expanded(
//                                     child: Text(orderController
//                                         .allOrdersUser[index].deliveryToCity)),
//                                 Expanded(
//                                     child: Text(orderController
//                                         .allOrdersUser[index]
//                                         .amountAfterDelivery
//                                         .toString())),
//                                 Expanded(
//                                     child: InkWell(
//                                   onTap: () {
//                                     Get.defaultDialog(
//                                       title:
//                                           'تغير قيمة النقل للطلب رقم${orderController.allOrdersUser[index].orderNumber} إلى :',
//                                       content: TextField(
//                                         controller: deliveryCostController,
//                                       ),
//                                       textCancel: 'إلغاء',
//                                       onCancel: null,
//                                       textConfirm: 'ok',
//                                       confirmTextColor: Colors.white,
//                                       onConfirm: () {
//                                         orderModel = orderController
//                                             .allOrdersUser[index];
//
//                                         orderModel.deliveryCost = int.parse(
//                                             deliveryCostController.text);
//
//                                         // statusTitleController.text
//
//                                         print('clinetid ' +
//                                             orderController.clientId.value);
//
//                                         FireDb().updateOrderByUserId(
//                                             order: orderModel,
//                                             clientId:
//                                                 orderController.clientId.value,
//                                             uid: orderController
//                                                 .allOrdersUser[index].orderId);
//
//                                         orderController
//                                             .streamOrdersByUserAndStatus(
//                                                 status: orderController
//                                                     .orderStatusByUser.value,
//                                                 orderByName:
//                                                     orderController
//                                                         .orderBySortingName
//                                                         .value,
//                                                 clientId: orderController
//                                                     .clientId.value);
//                                         getAllAmount(
//                                             status: orderController
//                                                 .orderStatusByUser.value,
//                                             sortingByName: orderController
//                                                 .orderBySortingName.value);
//
//                                         print(_listOption[_valueOBX.value]);
//                                         Get.back();
//                                       },
//                                     );
//                                   },
//                                   child: Text(orderController
//                                       .allOrdersUser[index].deliveryCost
//                                       .toString()),
//                                 )),
//                                 Expanded(
//                                   child: Text(
//                                     DateFormat('yyyy-MM-dd').format(
//                                         orderController
//                                             .allOrdersUser[index].dateCreated
//                                             .toDate()),
//                                   ),
//                                 ),
//
//                                 // هنا قسم الحالة وعن طريقة يمكن تغير الحاله
//                                 Expanded(
//                                   child: InkWell(
//                                     onTap: () {
//                                       // print(orderController
//                                       //     .allOrders[index].orderId);
//                                       // print(orderStatusOBX);
//                                       // print(_valueOBX.value);
//                                       // print('orderTitleStatusOBX ' +
//                                       //     orderTitleStatusOBX.value);
//
//                                       _valueOBX.value = 0;
//                                       orderTitleStatusOBX.value = '';
//                                       statusTitleController.text = '';
//                                       orderStatusOBX.value = 'واصل';
//
//                                       // this is Dialog section
//                                       Get.defaultDialog(
//
//                                           //confirm: Text('ok'),
//                                           textCancel: 'إلغاء',
//                                           onCancel: null,
//                                           textConfirm: 'ok',
//                                           confirmTextColor: Colors.white,
//                                           onConfirm: () {
//                                             orderModel = orderController
//                                                 .allOrdersUser[index];
//                                             orderModel.status =
//                                                 _listOption[_valueOBX.value];
//                                             orderModel.statusTitle =
//                                                 statusTitleController.text;
//
//                                             // statusTitleController.text
//
//                                             print('clinetid ' +
//                                                 orderController.clientId.value);
//
//                                             FireDb().updateOrderByUserId(
//                                                 order: orderModel,
//                                                 clientId: orderController
//                                                     .clientId.value,
//                                                 uid: orderController
//                                                     .allOrdersUser[index]
//                                                     .orderId);
//
//                                             orderController
//                                                 .streamOrdersByUserAndStatus(
//                                                     status: orderController
//                                                         .orderStatusByUser
//                                                         .value,
//                                                     orderByName: orderController
//                                                         .orderBySortingName
//                                                         .value,
//                                                     clientId: orderController
//                                                         .clientId.value);
//                                             getAllAmount(
//                                                 status: orderController
//                                                     .orderStatusByUser.value,
//                                                 sortingByName: orderController
//                                                     .orderBySortingName.value);
//
//                                             print(_listOption[_valueOBX.value]);
//                                             Get.back();
//                                           },
//                                           title:
//                                               'تغير حالة الطلب ${orderController.allOrdersUser[index].orderNumber} إلى :',
//                                           content: Column(
//                                             children: <Widget>[
//                                               for (int i = 0;
//                                                   i < _listOption.length;
//                                                   i++)
//                                                 ListTile(
//                                                   title: Text(
//                                                     _listOption[i],
//                                                   ),
//                                                   leading: Obx(() => Radio(
//                                                         value: i,
//                                                         groupValue:
//                                                             _valueOBX.value,
//                                                         activeColor:
//                                                             Color(0xFF6200EE),
//                                                         onChanged: (value) {
//                                                           _valueOBX.value =
//                                                               value;
//                                                           // orderStatus.value =
//                                                           //     _listOption[value];
//                                                           orderTitleStatusOBX
//                                                                   .value =
//                                                               _listOption[
//                                                                   value];
//                                                           orderStatusOBX.value =
//                                                               _listOption[
//                                                                   value];
//                                                           // statusTitleController.text= _listOption[value];
//
//                                                           print(_valueOBX);
//                                                           print(
//                                                               'orderStatusOBX.value' +
//                                                                   orderStatusOBX
//                                                                       .value);
//                                                         },
//                                                       )),
//                                                 ),
//                                               Obx(() => orderStatusOBX.value !=
//                                                       'واصل'
//                                                   ? TextField(
//                                                       controller:
//                                                           statusTitleController,
//                                                       decoration:
//                                                           InputDecoration(
//                                                         labelText:
//                                                             orderTitleStatusOBX
//                                                                 .value,
//                                                         labelStyle: TextStyle(
//                                                             fontSize: 14),
//                                                         hintStyle: TextStyle(
//                                                             color: Colors.grey,
//                                                             fontSize: 10),
//                                                       ),
//                                                     )
//                                                   : Container())
//                                             ],
//                                           ),
//                                           middleText: orderController
//                                               .allOrdersUser[index].orderId);
//                                     },
//                                     child: Container(
//                                       child: Text(orderController
//                                           .allOrdersUser[index].statusTitle),
//                                       color: Colors.lightBlueAccent,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Divider(
//                               thickness: 2,
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   );
//                 } else {
//                   return Container(
//                     child: Center(
//                       child: CircularProgressIndicator(
//                         value: 10,
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Text('المجموع: '),
//                 Obx(
//                   () => Container(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       sumOfAmountOBX.value.toString(),
//                     ),
//                   ),
//                 ),
//                 Text('النقل: '),
//                 Obx(() => Text(sumOfDeliveryCostOBX.value.toString())),
//                 Text('الباقي: '),
//                 Obx(
//                   () => Text(
//                     (sumOfAmountOBX.value - sumOfDeliveryCostOBX.value)
//                         .toString(),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//           ],
//         )),
//       ),
//     );
//   }
//
//   Widget statusButton({
//     String title,
//     OrderController controller,
//     String status,
//   }) {
//     return RaisedButton(
//       child: Text(title),
//       onPressed: () {
//         controller.orderStatusByUser.value = status;
//         // orderStatus.value = status;
//
//         controller.streamOrdersByUserAndStatus(
//             status: status, clientId: orderController.clientId.value);
//         getAllAmount(status: status);
//       },
//     );
//   }
//
//   Widget headerTitle({
//     String arbTitle,
//     String engTitle,
//     OrderController controller,
//   }) {
//     return Expanded(
//       child: InkWell(
//         onTap: () {
//           controller.orderBySortingName.value = engTitle;
//           getAllAmount(
//               sortingByName: engTitle,
//               status: orderController.orderStatusByUser.value);
//           controller.streamOrdersByUserAndStatus(
//               orderByName: engTitle,
//               status: orderController.orderStatusByUser.value,
//               clientId: orderController.clientId.value);
//         },
//         child: Text(arbTitle),
//       ),
//     );
//   }
// }
