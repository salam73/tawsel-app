import 'package:taswel/controllers/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taswel/controllers/authController.dart';
import 'package:taswel/screens/auth/deliveryBoysingup.dart';
import 'signup.dart';

class Login extends GetWidget<AuthController> {
//  var _auth = Get.put(AuthController());

  final AuthController _authController = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(hintText: "Email"),
                controller: emailController,
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                controller: passwordController,
                obscureText: true,
              ),
              RaisedButton(
                child: Text("Log In"),
                onPressed: () {
                  controller.login(
                      emailController.text, passwordController.text);
                },
              ),
              FlatButton(
                child: Text("Sign Up"),
                onPressed: () {
                  Get.to(SignUp());
                },
              ),
              // FlatButton(
              //   child: Text("تسجيل مندوب"),
              //   onPressed: () {
              //     Get.to(DeliveryBoySignUp());
              //   },
              // ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _authController.logOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
