import 'dart:ui';

import 'package:taswel/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/state_manager.dart';
//import 'package:todo_app/controllers/authController.dart';

class SignUp extends GetWidget<AuthController> {
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopAddressController = TextEditingController();
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
                  TextFormField(
                    decoration: InputDecoration(hintText: "إسم المحل"),
                    controller: shopNameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "إسم العميل"),
                    controller: nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "عنوان العميل"),
                    controller: shopAddressController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "رقم العميل"),
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
                      controller.createUser(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        shopName: shopNameController.text,
                        shopAddress: shopAddressController.text,
                        phoneNumber: phoneNumberController.text,
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
