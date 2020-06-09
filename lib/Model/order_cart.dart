import 'package:flutter/material.dart';

class OrderCart extends ChangeNotifier{
  int orderCount;
  OrderCart({@required this.orderCount});

  increamentOrder(){
    orderCount++;
    notifyListeners();
  }
}