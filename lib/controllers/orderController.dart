import 'package:taswel/models/order.dart';

import 'package:taswel/controllers/authController.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:taswel/services/fireDb.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  Rx<List<OrderModel>> orderList = Rx<List<OrderModel>>();
  Rx<List<OrderModel>> allOrderListByUser = Rx<List<OrderModel>>();
  Rx<List<OrderModel>> allOrderListByProvince = Rx<List<OrderModel>>();
  Rx<List<OrderModel>> allOrderListByProvinceFilterByProvince =
      Rx<List<OrderModel>>();

  var orderStatusByUser = ''.obs;
  var orderStatusByProvince = ''.obs;
  var deliveryToCity = ''.obs;
  var orderBySortingName = 'dateCreated'.obs;
  var sumAmount = 0.obs;
  var sumDelivery = 0.obs;
  var clientId = ''.obs;

  var sumOfAmountOBX = 0.obs;
  var sumOfDeliveryCostOBX = 0.obs;

  List<OrderModel> get orders => orderList.value;
  List<OrderModel> get allOrdersUser => allOrderListByUser.value;
  List<OrderModel> get allOrdersProvince => allOrderListByProvince.value;
  List<OrderModel> get allOrdersProvinceFilterByProvince =>
      allOrderListByProvinceFilterByProvince.value;

  @override
  @mustCallSuper
  void onInit() async {
    var fireUser = Get.find<AuthController>().user;
    clear();

    if (fireUser != null) {
      await FireDb().getUser(uid: Get.find<AuthController>().user.uid);
      var user = Get.find<UserController>().user;
      orderList.bindStream(FireDb().orderStream(user.id));
    }
    allOrderListByUser.bindStream(FireDb().allOrderStreamByUserAndStatus(
        status: orderStatusByUser.value, sortBy: orderBySortingName.value));
    //stream coming from firebase For todo List
    allOrderListByProvince.bindStream(FireDb().allOrderStreamByUserAndStatus(
        status: orderStatusByProvince.value,
        sortBy: orderBySortingName
            .value)); //stream coming from firebase For todo List

    super.onInit();
  }

  void orderByUser({String userId}) {
    orderList.bindStream(FireDb().orderStreamByUserId(userId));
  }

  int getAllAmount() {
    int allAmount = 0;
    allOrdersUser.forEach((element) {
      allAmount = allAmount + element.amountAfterDelivery;
    });
    return allAmount;
  }

  int getAllAmountProvince() {
    int allAmount = 0;
    allOrdersProvince.forEach((element) {
      allAmount = allAmount + element.amountAfterDelivery;
    });
    return allAmount;
  }

  int getDeliveryCost() {
    int deliveryCost = 0;
    allOrdersUser.forEach((element) {
      deliveryCost = deliveryCost + element.deliveryCost;
    });
    return deliveryCost;
  }

  int getDeliveryCostProvince() {
    int deliveryCost = 0;
    allOrdersProvince.forEach((element) {
      deliveryCost = deliveryCost + element.deliveryCost;
    });
    return deliveryCost;
  }

  // String printOrder() {
  //   return 'printController' + sumAmount.toString();
  // }

  void streamOrdersByUserAndStatus(
      {String status, String orderByName, String clientId}) {
    allOrderListByUser.bindStream(FireDb().allOrderStreamByUserAndStatus(
        status: status, sortBy: orderBySortingName.value, clientId: clientId));
  }

  void streamOrdersByProvinceAndStatus({String deliveryToCity, String status}) {
    allOrderListByProvince.bindStream(FireDb().orderStreamByProvinceAndStatus(
        deliveryToCity: deliveryToCity, status: status));
  }

  void streamOrdersByProvince({String deliveryToCity}) {
    allOrderListByProvinceFilterByProvince.bindStream(
        FireDb().orderStreamByProvince(deliveryToCity: deliveryToCity));
  }

  void clear() {
    // ignore: deprecated_member_use
    this.orderList.value = List<OrderModel>();
    // ignore: deprecated_member_use
    this.allOrderListByUser.value = List<OrderModel>();
    this.allOrderListByProvince.value = List<OrderModel>();
  }
}
