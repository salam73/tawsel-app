import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taswel/controllers/authController.dart';
import 'package:taswel/controllers/orderController.dart';
import 'package:taswel/controllers/themeController.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:taswel/screens/appByUser/orderInput.dart';
import 'package:taswel/services/fireDb.dart';
import 'package:taswel/utils/root.dart';
import 'package:taswel/widgets/orderAlert.dart';
import 'package:taswel/widgets/orderCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';
/*

class HomeAdmin extends StatelessWidget {
  final AuthController _authController = Get.find();
//  final UserController _userController = Get.put(UserController());
  final ThemeController _themeController = Get.put(ThemeController());

  final OrderController orderController = Get.put(OrderController());

  final String userId;

  HomeAdmin({Key key, this.userId}) : super(key: key);

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
    print(userId);
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

              Get.to(Root());
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
            "'الطلبات'",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('orders')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              orderController.orderByUser(userId: userId);

              if (!snapshot.hasData) return Text('loading');
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (_, index) {
                    print(snapshot.data.docs[index]);
                    return Column(
                      children: [
                        Text(DateFormat('yyyy-MM-dd')
                            .format(snapshot.data.docs[index]['dateCreated']
                                .toDate())
                            .toString()),
                        OrderCard(
                            uid: userId, order: orderController.orders[index]),
                      ],
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
*/
