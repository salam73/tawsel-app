import 'package:taswel/controllers/authController.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:taswel/layout/mainLayout.dart';

import 'package:taswel/screens/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taswel/screens/delivery/deliveryHome.dart';
import 'package:taswel/screens/fbpage/fbpageHome.dart';
import 'package:taswel/screens/fbpage/fbpageStatus.dart';
import 'package:get/get.dart';
import 'package:taswel/screens/appByUser/orderInput.dart';
import 'package:taswel/screens/homeAdmin.dart';
import 'package:taswel/screens/ordersList.dart';
import 'package:taswel/screens/userList.dart';
import 'package:taswel/services/cloudMessageProvider.dart';
import 'package:taswel/testing/mainTest.dart';
import 'package:taswel/testing/cloudMessigeHttp.dart';

// ignore: must_be_immutable
class Root extends GetWidget<AuthController> {
  //Just For Switching to Home to Login
  // UserController _userModel = Get.find();
  UserController userController = Get.put(UserController());
  UserController userModel = Get.find();
  //final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user != null &&
            userModel.user.name != null) {
          print('role' + userModel.user.role);
          // print('shopAddress ' + userModel.user.shopAddress);

          if (userModel.user.role == 'admin')
            return MainLayout();

          // var user = Get.find<AuthController>().user;

          //    print(user['isAdmin'].toString());
          // return Home();
          // return Test2();

          // return MainTest();
          // return HomeAdmin();
          // return AdminHome();
          //  return ReceiveHome();
          else if (userModel.user.role == 'shopOwner')
            return FbPageHome();
          // return MainLayout();
          else
            return DeliveryHome(
              province: userModel.user?.province,
            );
          // return OrdersList();
          // return UserList();
          // return OrderInput(
          //     //  userId: user.uid,
          //     );
        } else {
          // return Test2();
          // return MainTest();
          // return ReceiveHome();
          // return ProvincesLayout();
          // return MainLayout();
          // return MainTest();
          // return AdminHome();
          // return HomeAdmin();
          // return FbPageStatus();
          return Login();
        }
      },
    );
  }
}
