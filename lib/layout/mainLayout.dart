import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taswel/controllers/authController.dart';
import 'package:taswel/controllers/userController.dart';
import 'package:taswel/layout/provincesLayout.dart';
import 'package:taswel/screens/auth/login.dart';
import 'package:get/get.dart';
import 'package:taswel/layout/usersLayout.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLayout extends StatelessWidget {
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إسم الشركة', style: GoogleFonts.cairo()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logOut();
              // Get.to(Login());
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Get.to(UsersLayout());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.deepOrangeAccent,
                  child: Text(
                    'العميل',
                    style: TextStyle(
                        fontSize: (MediaQuery.of(context).size.width * 0.3) / 4,
                        color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(ProvincesLayout());
                },
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Colors.lightBlueAccent,
                    child: Text(
                      'محافظات',
                      style: TextStyle(
                          fontSize:
                              (MediaQuery.of(context).size.width * 0.3) / 5,
                          color: Colors.white),
                    )),
              ),
              /* RaisedButton(
                onPressed: () {
                  Get.to(UserList());
                },
                child: Text('المحلات'),
              ),
              RaisedButton(
                onPressed: () {
                  Get.to(SortOrdersByDate());
                },
                child: Text('التاريخ'),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
