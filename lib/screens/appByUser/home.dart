import 'package:taswel/controllers/authController.dart';
import 'package:taswel/controllers/themeController.dart';
import 'package:taswel/controllers/orderController.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:taswel/models/user.dart';
import 'package:taswel/screens/appByUser/orderInput.dart';
import 'package:taswel/screens/auth/login.dart';
import 'package:taswel/services/fireDb.dart';
import 'package:taswel/widgets/orderCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taswel/widgets/orderAlert.dart';

class Home extends StatelessWidget {
  final AuthController _authController = Get.find();
  final UserController userModel = Get.find();
  //
  final ThemeController _themeController = Get.put(ThemeController());

  getLightIcon() {
    if (_themeController.themeChange) {
      return Icon(Icons.lightbulb);
    } else {
      return Icon(Icons.lightbulb_outline);
    }
  }

  getUserName() {
    return GetX<UserController>(
      init: Get.put(UserController()),
      initState: (_) async {
        Get.find<UserController>().user =
            await FireDb().getUser(uid: Get.find<AuthController>().user.uid);
      },
      builder: (_userController) {
        return Text((_userController.user == null)
            ? ""
            : _userController.user.name.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(userModel.user.role);

    return Scaffold(
      appBar: AppBar(
        title: getUserName(),
        centerTitle: true,
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
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logOut();
              // Get.to(Login());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // OrderAlert().addOrderDialog();
          Get.to(OrderInput());
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "الطلبات",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(() => Text(
                userModel.user.role ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
          GetX<OrderController>(
            init: Get.put<OrderController>(OrderController()),
            builder: (OrderController orderController) {
              if (orderController != null &&
                  orderController.allOrdersUser != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: orderController.allOrdersUser.length,
                    itemBuilder: (_, index) {
                      // return Text('salam');
                      return OrderCard(
                          uid: _authController.user.uid,
                          order: orderController.allOrdersUser[index]);
                    },
                  ),
                );
              } else {
                return Container(
                    child: Center(
                        child: CircularProgressIndicator(
                  value: 10,
                )));
              }
            },
          )
        ],
      ),
    );
  }
}
