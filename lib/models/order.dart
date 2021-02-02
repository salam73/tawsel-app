import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  // String content;
  String orderId;
  Timestamp dateCreated;
  // bool done;

  String orderNumber;
  String byUserId;
  String clientEmail;

  String deliveryToCity;
  int deliveryCost;

  String customerName;
  String customerAddress;
  String customerPhone;

  int amountAfterDelivery;
  String orderType;
  String commit;
/*
  bool isPickup;
  bool isReturn;
  bool isSolve;*/

  String status;
  String statusTitle;

  OrderModel(
      // this.content,
      {
    this.orderId,
    this.byUserId,
    this.dateCreated,
    // this.done,
    this.orderNumber,
    this.deliveryToCity,
    this.deliveryCost,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.amountAfterDelivery,
    this.orderType,
    this.commit,
    this.status,
    this.statusTitle,
    // this.isPickup,
    // this.isReturn,
    // this.isSolve
  });

  OrderModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    orderId = documentSnapshot.id;
    // content = documentSnapshot["content"];
    byUserId = documentSnapshot["byUserId"];
    clientEmail = documentSnapshot["clientEmail"];
    dateCreated = documentSnapshot["dateCreated"];
    // done = documentSnapshot["done"];
    orderNumber = documentSnapshot["orderNumber"];
    //
    deliveryToCity = documentSnapshot["deliveryToCity"];
    deliveryCost = documentSnapshot["deliveryCost"];
    customerName = documentSnapshot["customerName"];
    customerAddress = documentSnapshot["customerAddress"];
    customerPhone = documentSnapshot["customerPhone"];
    amountAfterDelivery = documentSnapshot["amountAfterDelivery"];
    orderType = documentSnapshot["orderType"];
    commit = documentSnapshot["commit"];
    status = documentSnapshot["status"];
    statusTitle = documentSnapshot["statusTitle"];
    /*  isPickup = documentSnapshot["isPickup"];
    isReturn = documentSnapshot["isReturn"];
    isSolve = documentSnapshot["isSolve"];*/
  }

  Map<String, dynamic> toJson() {
    //For Json Change
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['content'] = this.content;
    data['byUserId'] = this.byUserId;
    data['clientEmail'] = this.clientEmail;
    data['dateCreated'] = this.dateCreated;
    // data['done'] = this.done;
    data['orderNumber'] = this.orderNumber;

    data['deliveryToCity'] = this.deliveryToCity;
    data['deliveryCost'] = this.deliveryCost;
    data['customerName'] = this.customerName;
    data['customerAddress'] = this.customerAddress;
    data['customerPhone'] = this.customerPhone;
    data['amountAfterDelivery'] = this.amountAfterDelivery;
    data['orderType'] = this.orderType;
    data['commit'] = this.commit;
    data['status'] = this.status;
    data['statusTitle'] = this.statusTitle;
    /* data['isPickup'] = this.isPickup;
    data['isReturn'] = this.isReturn;
    data['isSolve'] = this.isSolve;*/
    return data;
  }
}
