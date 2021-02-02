import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:taswel/models/order.dart';
import 'package:taswel/screens/appByUser/orderDetail.dart';
import 'package:taswel/services/fireDb.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taswel/widgets/orderAlert.dart';

class OrderCard extends StatelessWidget {
  final String uid;
  final OrderModel order;

  var mycolor = Color(0xff885566);

  OrderCard({Key key, this.uid, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (order.status) {
      case 'جاهز':
        {
          mycolor = Color(0xff808080);
        }
        break;
      case 'تم الإستلام':
        {
          mycolor = Color(0xff2b8dad);
        }
        break;

      case 'راجع':
        {
          mycolor = Color(0xff7a2a2a);
        }
        break;
      case 'مؤجل':
        {
          mycolor = Color(0xffada92b);
        }
        break;
      case 'قيد التوصيل':
        {
          mycolor = Color(0xff2b50ad);
        }
        break;
      case 'واصل':
        {
          mycolor = Color(0xff2a6e2e);
        }
        break;

      case 'تم الدفع':
        {
          mycolor = Colors.green;
        }
        break;

      default:
        {
          //statements;
        }
        break;
    }

    return InkWell(
      onTap: () {
        Get.to(OrderDetail(order: order));
      },
      child: Card(
        color: mycolor,
        margin: EdgeInsets.fromLTRB(10, 2.5, 10, 2.5),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      //alignment: Alignment.center,
                      child: Text(
                        order.orderNumber,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                            // color: (order.done) ? Colors.green : Colors.white
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        order.status,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                            // color: (order.done) ? Colors.green : Colors.white
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        order.statusTitle,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                            // color: (order.done) ? Colors.green : Colors.white
                            ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                thickness: 2,
                color: Colors.white,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'تكلفة النقل :${order.deliveryCost.toString()}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                            // color: (order.done) ? Colors.green : Colors.white
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'المبلغ :${order.amountAfterDelivery.toString()}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                            // color: (order.done) ? Colors.green : Colors.white
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
