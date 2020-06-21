import 'package:e_commerce_app/Screens/MershatScreens/add_product.dart';
import 'package:e_commerce_app/Screens/MershatScreens/m_home_screen.dart';
import 'package:e_commerce_app/Screens/MershatScreens/order_details.dart';
import 'package:e_commerce_app/Screens/MershatScreens/orders_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (context)=>MershantHomeScreen());
      case '/addProduct':
        return MaterialPageRoute(builder: (context)=>AddProduct());
      case '/order':
        return MaterialPageRoute(builder: (context)=>OrderScreen());
      case '/orderDetails':
        return MaterialPageRoute(builder: (context)=>OrderDetails());
      default:
        return MaterialPageRoute(builder: (context){
          return Scaffold(body: Center(child: Text('not found'),),);
          });

    }

  }
}