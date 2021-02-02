import 'dart:ui';

import 'package:taswel/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/state_manager.dart';
//import 'package:todo_app/controllers/authController.dart';

class DeliveryBoySignUp extends GetWidget<AuthController> {
  // final TextEditingController roleController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // TextFormField(
                  //   decoration: InputDecoration(hintText: "إسم المحل"),
                  //   controller: roleController,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "إسم المندوب"),
                    controller: nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "المحافظة"),
                    controller: provinceController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "رقم هاتف المندوب"),
                    controller: phoneNumberController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "الإيميل"),
                    controller: emailController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "الباسورد"),
                    obscureText: true,
                    controller: passwordController,
                  ),
                  FlatButton(
                    child: Text("Sign Up"),
                    onPressed: () {
                      controller.createDeliveryBoy(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        province: provinceController.text,
                        // shopName: roleController.text,
                        shopAddress: '',
                        phoneNumber: '',
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
