import 'package:e_commerce_app/Core/ViewModels/CRUDModel.dart';
import 'package:e_commerce_app/Data/database_helper.dart';
import 'package:e_commerce_app/Model/order_cart.dart';
import 'package:e_commerce_app/Model/order_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:e_commerce_app/screens/MershatScreens/m_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  int index;
  OrderDetails({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<OrderCart>(
      create: (context) => OrderCart(orderCount: 0),
      child: MaterialApp(
          home: Order(
        index: index,
      )),
    );
  }
}

class Order extends StatelessWidget {
  int index;
  Order({Key key, this.index}) : super(key: key);
  //var db = new DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<CURDModel>(context);
    int number = Provider.of<OrderCart>(context).orderCount;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 30.0, top: 50.0, right: 40),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.keyboard_backspace,
                    color: Color(0xffc5ccd6),
                    size: 30.0,
                  ),
                  Spacer(),
                  Stack(children: <Widget>[
                    new Icon(
                      Icons.shopping_cart,
                      color: Color(0xffc5ccd6),
                      size: 30.0,
                    ),
                    new Positioned(
                      top: 0.0,
                      right: 0.0,
                      left: 13.0,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          alignment: Alignment.center,
                          child: Text(
                            '$number',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          )),
                    )
                  ]),
                ],
              ),
            )),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 30.0),
          child: Text(
            "Order Details",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
            child: Text('Client Name: ',
                style: TextStyle(fontSize: 15, color: Colors.grey))),
        Container(
            margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
            child: SizedBox(
              child: StreamBuilder(
                  stream:
                      ordersProvider.fetchOrderAsStream(), //db.getAllRecords()
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var orders = snapshot.data.documents
                          .map((doc) =>
                              OrderData.fromJson(doc.data, doc.documentID))
                          .toList();
                          
                      return Container(
                        margin: EdgeInsets.only(top: 5.0, right: 30.0),
                        child: Text('${orders[index].clientName.toString()}',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                      );
                    } else
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                  }),
            )),
        Container(
          height: 1,
          width: 340,
          color: Colors.grey,
          margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
        ),
        Container(
            margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
            child: Text('Address: ',
                style: TextStyle(fontSize: 15, color: Colors.grey))),
        Container(
            margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
            child: SizedBox(
                  child: StreamBuilder(
                  stream: ordersProvider.fetchOrderAsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var orders = snapshot.data.documents
                          .map((doc) =>
                              OrderData.fromJson(doc.data, doc.documentID))
                          .toList();

                      return Container(
                        margin: EdgeInsets.only(top: 5.0, right: 30.0),
                        child: Text('${orders[index].city.toString()}',
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                      );
                    } else
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                  }),
            )),
        Container(
          height: 1,
          width: 340,
          color: Colors.grey,
          margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
        ),
        Container(
            margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
            child: Text('Product List: ',
                style: TextStyle(fontSize: 15, color: Colors.grey))),
        Container(
            margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
            child: SizedBox(
                  child: StreamBuilder(
                  stream: ordersProvider.fetchOrderAsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var orders = snapshot.data.documents
                          .map((doc) =>
                              OrderData.fromJson(doc.data, doc.documentID))
                          .toList();

                      return Container(
                        margin: EdgeInsets.only(top: 5.0, right: 30.0),
                        child: Text('${orders[index].productName.toString()}',
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                      );
                    } else
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                  }),
            )),
        Container(
          height: 1,
          width: 340,
          color: Colors.grey,
          margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
        ),
        Center(
            child: Container(
                margin: EdgeInsets.only(top: 30.0),
                child: RaisedButton(
                  onPressed: () {
                    Provider.of<OrderCart>(context, listen: false)
                        .increamentOrder();
                  }, // When Click on Button goto Login Screen

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: const EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              new Color(0xff374ABE),
                              new Color(0xff64B6FF)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: Container(
                      constraints: const BoxConstraints(
                          maxWidth: 300.0,
                          minHeight: 40.0), // min sizes for Material buttons
                      alignment: Alignment.center,
                      child: const Text(
                        'Accept',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ))),
      ],
    )));
  }
}
