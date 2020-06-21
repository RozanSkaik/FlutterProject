import 'package:e_commerce_app/Core/ViewModels/CRUDModel.dart';
import 'package:e_commerce_app/Data/database_helper.dart';
import 'package:e_commerce_app/Screens/MershatScreens/orders_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_product.dart';

class MershantHomeScreen extends StatelessWidget{
  //var db= DatabaseHelper();
  @override
  Widget build(BuildContext context) {
   // final productsProvider = Provider.of<CURDModel>(context);
    // TODO: implement build
    return Scaffold(
      body: init(context),
    );
  }
   init(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: <Widget>[  
         Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Text(
            "Welcome To your Store",
            style: TextStyle(
              fontSize: 25.0,
              color: new Color(0xff374ABE)
            ),
          ),
        ), 
        Container(
          alignment: AlignmentDirectional.center,
          margin: EdgeInsets.only(top: 30.0,right: 30,left: 30),
          child: Image(image: merchantImage())
        ), 
        Container(
          margin: EdgeInsets.only(top: 20.0,left: 50,right: 50),
          child: RaisedButton(

            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
            }, // When Click on Button goto Login Screen

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [new Color(0xff374ABE), new Color(0xff64B6FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 250.0, minHeight: 40.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  'Add Products',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          )
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0,left: 50,right: 50),
          child: RaisedButton(

            onPressed: () {
             // db.saveOrders();
              Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()));
            }, // When Click on Button goto Login Screen

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
            padding: const EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [new Color(0xff374ABE), new Color(0xff64B6FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                ),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 250.0, minHeight: 40.0), // min sizes for Material buttons
                alignment: Alignment.center,
                child: const Text(
                  'Orders',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          )
        ),
      ],
      
      );
   }
   ImageProvider merchantImage() {
    AssetImage assetImage = AssetImage("images/merchant.png");
    return assetImage;
  }
}