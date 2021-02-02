class GeneratOrders {
  List<OrderModel> ordersList = [];
  OrderModel orderModel = OrderModel();

  List con = ['سلام'];
  List deliveryToCity = ['كربلاء'];
  List typeOrder = ['احذية'];
  List amountAfterDelivery = [10, 4, 2, 6, 4, 23, 543, 36, 24, 542, 645];

  getRandomOrder() {
    orderModel.deliveryToCity = deliveryToCity[0];
    orderModel.orderType = typeOrder[0];
    orderModel.amountAfterDelivery = amountAfterDelivery[9];

    ordersList.add(orderModel);

    orderModel.deliveryToCity = deliveryToCity[0];
    orderModel.orderType = typeOrder[0];
    orderModel.amountAfterDelivery = amountAfterDelivery[7];

    ordersList.insert(0, orderModel);

    print(ordersList[0].amountAfterDelivery);

    orderModel.deliveryToCity = deliveryToCity[0];
    orderModel.orderType = typeOrder[0];
    orderModel.amountAfterDelivery = amountAfterDelivery[4];

    ordersList.insert(1, orderModel);

    print(ordersList[1].amountAfterDelivery);
  }
}

void main() {
  OrderModel orderModel = OrderModel();
  OrderModel orderModel1 = OrderModel();
  OrderModel orderModel2 = OrderModel();
  List<OrderModel> ordersList = [];

  // generatOrders.orderModel.amountAfterDelivery =
  orderModel.amountAfterDelivery = 3;
  ordersList.add(orderModel);
  orderModel1.amountAfterDelivery = 2;
  ordersList.add(orderModel1);
  orderModel2.amountAfterDelivery = 7;
  ordersList.add(orderModel2);

  print(ordersList[0].amountAfterDelivery);
  print(ordersList[1].amountAfterDelivery);
  print(ordersList[2].amountAfterDelivery);
}

class OrderModel {
  // String content;
  String orderId;

  bool done;

  String orderNumber;

  String deliveryToCity;

  String customerName;
  String customerAddress;
  String customerPhone;

  int amountAfterDelivery;
  String orderType;
  String commit;

  bool isPickup;
  bool isReturn;
  bool isSolve;

  OrderModel(
      // this.content,
      {this.orderId,
      this.done,
      this.orderNumber,
      this.deliveryToCity,
      this.customerName,
      this.customerAddress,
      this.customerPhone,
      this.amountAfterDelivery,
      this.orderType,
      this.commit,
      this.isPickup,
      this.isReturn,
      this.isSolve});
}
