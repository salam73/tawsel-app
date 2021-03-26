import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taswel/layout/tableByUserId.dart';
import 'package:taswel/models/deliveryBoy.dart';
import 'package:taswel/models/order.dart';
import 'package:taswel/models/user.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;

class FireDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "shopName": user.shopName,
        "shopAddress": user.shopAddress,
        'phoneNumber': user.phoneNumber,
        'province': user?.province ?? '',
        // 'isShopOwner': false,
        // 'isDeliveryBoy': false,
        // 'isDeliveryProvince': false,
        // 'isAdmin': false,
        'role': user?.role ?? 'mandob'
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> createNewDeliveryBoy(DeliveryBoyModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "province": user.province,

        'phoneNumber': user.phoneNumber,
        "shopName": user.shopName,
        "shopAddress": user.shopAddress,

        // 'isShopOwner': false,
        // 'isDeliveryBoy': false,
        // 'isDeliveryProvince': false,
        // 'isAdmin': false,
        'role': user.role ?? 'delivery'
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser({String uid}) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(uid).get();

      return UserModel.fromSnapShot(_doc);
    } catch (e) {
      rethrow;
    }
  }

  Future<DeliveryBoyModel> getDeliveryBoy({String uid}) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("deliveryboy").doc(uid).get();

      return DeliveryBoyModel.fromSnapShot(_doc);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrder({
    String uid,
    String clientEmail,
    String orderNumber,
    String deliveryToCity,
    int deliveryCost,
    String customerName,
    String customerAddress,
    String customerPhone,
    int amountAfterDelivery,
    String orderType,
    // String content,
    String commit,
    // bool isPickup,
    // bool isReturn,
    // bool isSolve,
    String status,
    String statusTitle,
  }) async {
    var orderID = randomAlpha(20);

    try {
      await _firestore
          .collection("users")
          .doc(uid)
          .collection("orders")
          .doc(orderID)
          .set({
        'dateCreated': Timestamp.now(),
        'byUserId': uid,
        'clientEmail': clientEmail,
        // 'content': content ?? '',
        'deliveryBoyId': '',
        'done': false,
        'orderNumber': orderNumber ?? '',
        'deliveryToCity': deliveryToCity ?? '',
        'deliveryCost': deliveryCost ?? 5000,
        'customerName': customerName ?? '',
        'customerAddress': customerAddress ?? '',
        'customerPhone': customerPhone ?? '',
        'amountAfterDelivery': amountAfterDelivery ?? 0,
        'orderType': orderType ?? '',
        'commit': commit ?? '',
        // 'content': content ?? '',
        'status': status ?? 'جاهز',
        'statusTitle': statusTitle ?? 'جاهز',
        // 'isPickup': isPickup ?? false,
        // 'isReturn': isReturn ?? false,
        // 'isSolve': isSolve ?? false,
      });
    } catch (e) {
      print(e);
      rethrow;
    }

    try {
      await _firestore.collection("orders").doc(orderID).set({
        'dateCreated': Timestamp.now(),
        'byUserId': uid,
        'deliveryBoyId': '',
        'clientEmail': clientEmail,
        // 'content': content,
        'done': false,
        'orderNumber': orderNumber ?? '',
        'deliveryToCity': deliveryToCity ?? '',
        'deliveryCost': deliveryCost ?? 5000,
        'customerName': customerName ?? '',
        'customerAddress': customerAddress ?? '',
        'customerPhone': customerPhone ?? '',
        'amountAfterDelivery': amountAfterDelivery ?? 0,
        'orderType': orderType ?? '',
        'commit': commit ?? '',
        // 'content': content ?? '',
        'status': status ?? 'جاهز',
        'statusTitle': statusTitle ?? 'جاهز',
        // 'isPickup': isPickup ?? false,
        // 'isReturn': isReturn ?? false,
        // 'isSolve': isSolve ?? false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getUserList({String role = 'shopOwner'}) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: role)
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getMandobs({String provinceName = ''}) {
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'mandob')
          .where('province', isEqualTo: provinceName)
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getOrdersList() {
    try {
      return FirebaseFirestore.instance
          .collection('orders')
          .where('type', isEqualTo: 'shop')
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderModel>> orderStream(String uid) {
    // print('user id' + uid);
    return _firestore
        // .collection("users")
        // .doc(uid)
        .collection("orders")
        .where('byUserId', isEqualTo: uid ?? '')
        // .orderBy("dateCreated", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<OrderModel>> allOrderStreamByUserAndStatus(
      {String status, String sortBy, String clientId}) {
    return _firestore
        // .collection("users")
        // .doc(clientId)
        .collection("orders")
        .where('byUserId', isEqualTo: clientId ?? '')
        .where('status', isEqualTo: status ?? '')
        // .where('byUserId', isEqualTo: clientId ?? '')
        .orderBy(sortBy ?? 'dateCreated', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<OrderModel>> orderStreamByUserId(String uid) {
    return _firestore
        // .collection("users")
        // .doc(uid)
        .collection("orders")
        .where('byUserId', isEqualTo: uid)
        .orderBy('deliveryToCity')
        // .orderBy("dateCreated", descending: true)

        //
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<OrderModel>> orderStreamByProvinceAndStatus({
    String deliveryToCity,
    String status,
  }) {
    return _firestore
        // .collection("users")
        // .doc(uid)
        .collection("orders")
        .where('deliveryToCity', isEqualTo: deliveryToCity)
        .where('status', isEqualTo: status)
        // .orderBy('deliveryToCity')
        // .orderBy("dateCreated", descending: true)

        //
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<List<OrderModel>> orderStreamByMandobId({
    String deliveryBoyId,
    String status,
  }) {
    return _firestore
        // .collection("users")
        // .doc(uid)
        .collection("orders")
        .where('deliveryBoyId', isEqualTo: deliveryBoyId)
        .where('status', isEqualTo: status)
        // .orderBy('deliveryToCity')
        // .orderBy("dateCreated", descending: true)

        //
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Stream<QuerySnapshot> orderStreamByMandobIdAndStatus({
    String deliveryBoyId,
    String status,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection('orders')
          .where('deliveryBoyId', isEqualTo: deliveryBoyId)
          .where('status', isEqualTo: status)
          .snapshots();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<OrderModel>> orderStreamByProvince({
    String deliveryToCity,
  }) {
    return _firestore
        // .collection("users")
        // .doc(uid)
        .collection("orders")
        .where('deliveryToCity', isEqualTo: deliveryToCity)

        // .orderBy('deliveryToCity')
        // .orderBy("dateCreated", descending: true)

        //
        .snapshots()
        .map((QuerySnapshot query) {
      List<OrderModel> retVal = List();
      query.docs.forEach((element) {
        retVal.add(OrderModel.fromDocumentSnapshot(element));
      });
      return retVal;
    });
  }

  Future<void> updateOrder(OrderModel order, String uid) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("orders")
          .doc(order.orderId)
          .update(order.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateOrderByUserId({
    OrderModel order,
    String clientId,
    String uid,
  }) async {
    try {
      _firestore
          .collection("users")
          .doc(clientId)
          .collection("orders")
          .doc(uid)
          //   .update({'status': status});
          //
          // .update({'status': order.status, 'statusTitle': order.statusTitle});

          //  _firestore.collection("orders").doc(uid)
          .update(order.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }

    try {
      _firestore
          .collection("orders")
          .doc(uid)
          //.update({'status': status});
          .update(order.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> updateOrderByMandob({String orderId, String MandobId}) async {
    try {
      _firestore.collection("orders").doc(orderId).update({
        'deliveryBoyId': MandobId,
      });
      // .update(order.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  /*Future<void> updateOrderBy(
      {OrderModel order, String clientId, String uid}) async {
    try {
      _firestore
          .collection("users")
          .doc(clientId)
          .collection("orders")
          .doc(uid)
          // .update({'status': 'راجع'});
          //
          // .update({'status': order.status, 'statusTitle': order.statusTitle});
          .update(order.toJson());

      //  _firestore.collection("orders").doc(uid).update(order.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }

    try {
      _firestore
          .collection("orders")
          .doc(uid)
          // .update({'status': order.status, 'statusTitle': order.statusTitle});
          .update(order.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }*/

  Future<void> deleteOrder(OrderModel order, String uid) async {
    try {
      _firestore
          .collection("users")
          .doc(uid)
          .collection("orders")
          .doc(order.orderId)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

//-----------
  Stream<QuerySnapshot> getFBPageOrders(String userId, String status) {
    return _firestore
        .collection('orders')
        .where('byUserId', isEqualTo: userId)
        .where('status', isEqualTo: status)
        .orderBy('dateCreated', descending: true)
        .snapshots();
  }
}
