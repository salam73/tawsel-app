import 'package:taswel/controllers/userController.dart';
import 'package:taswel/models/order.dart';
import 'package:taswel/services/fireDb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
/*
class OrderAlert {
  TextEditingController _textEditingController = TextEditingController();
  UserController _userController = Get.find();

  addOrderDialog() {
    Get.defaultDialog(
        title: "Add",
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                child: Text(
                  "Ok",
                ),
                onPressed: () {
                  if (_textEditingController.text != "") {
                    FireDb().addOrder(
                      orderType: _textEditingController.text,
                      uid: _userController.user.id,
                    );
                    _textEditingController.clear();
                    Get.back();
                  }
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          ),
        ]);
  }

  editOrderDialog(OrderModel orderModel) {
    _textEditingController.text = orderModel.orderType;
    Get.defaultDialog(
        title: "Edit",
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                child: Text(
                  "Edit",
                ),
                onPressed: () {
                  if (_textEditingController.text != "") {
                    orderModel.orderType = _textEditingController.text;
                    FireDb().updateOrder(orderModel, _userController.user.id);
                    _textEditingController.clear();
                    Get.back();
                  }
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          ),
        ]);
  }
}
*/
