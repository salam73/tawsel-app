import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryBoyModel {
  String id;
  String name;
  String email;
  String password;

  String province;
  String shopName;
  String phoneNumber;
  String shopAddress;
  // bool isShopOwner;
  // bool isDeliveryBoy;
  // bool isDeliveryProvince;
  String role;

  DeliveryBoyModel(
      {this.id,
      this.name,
      this.email,
      this.province,
      this.shopName,
      this.shopAddress,
      this.phoneNumber,
      this.password,
      // this.isShopOwner,
      // this.isDeliveryBoy,
      // this.isDeliveryProvince,
      // this.isAdmin
      this.role});

  DeliveryBoyModel.fromSnapShot(DocumentSnapshot userSnapShot) {
    this.id = userSnapShot.id;
    this.name = userSnapShot['name'];
    this.email = userSnapShot['email'];
    this.password = userSnapShot['password'];
    this.province = userSnapShot['province'];
    this.shopName = userSnapShot['shopName'];
    this.shopAddress = userSnapShot['shopAddress'];
    this.phoneNumber = userSnapShot['phoneNumber'];
    this.role = userSnapShot['role'];
    // this.isShopOwner = userSnapShot['isShopOwner'];
    // this.isDeliveryBoy = userSnapShot['isDeliveryBoy'];
    // this.isDeliveryProvince = userSnapShot['isDeliveryProvince'];
    // this.isAdmin = userSnapShot['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['province'] = this.province;
    data['shopName'] = this.shopName;
    data['shopAddress'] = this.shopAddress;
    data['phoneNumber'] = this.phoneNumber;
    data['role'] = this.role;
    // data['isShopOwner'] = this.isShopOwner;
    // data['isDeliveryBoy'] = this.isDeliveryBoy;
    // data['isDeliveryProvince'] = this.isDeliveryProvince;
    // data['isAdmin'] = this.isAdmin;
    return data;
  }
}
