import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Core/ViewModels/CRUDModel.dart';
import 'package:e_commerce_app/Data/database_helper.dart';
import 'package:e_commerce_app/Model/order_cart.dart';
import 'package:e_commerce_app/Model/order_data.dart';
import 'package:e_commerce_app/Screens/MershatScreens/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  //var db = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: init(context)));
  }

  init(BuildContext context) {
    final ordersProvider = Provider.of<CURDModel>(context);
    int position;
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Container(
            margin: EdgeInsets.only(left: 30.0, top: 50.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.keyboard_backspace,
                color: Color(0xffc5ccd6),
                size: 30.0,
              ),
            )),
        Container(
          margin: EdgeInsets.only(top: 20.0, left: 30.0),
          child: Text(
            "Orders",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 200.0,
                child: StreamBuilder(
              stream: ordersProvider.fetchOrderAsStream(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.hasData){
                  List<OrderData> orders = snapshot.data.documents.map((doc) => OrderData.fromJson(doc.data, doc.documentID)).toList();
                     return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                         position =index ;
                          return Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            height: 220,
                            width: double.maxFinite,
                            child: Card(
                              elevation: 5,
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Stack(children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Stack(
                                        children: <Widget>[
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(orders[position].productName + '\n',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      "Price: " +
                                                          orders[index].price +
                                                          '\n',
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                  Text(
                                                      "Client Name: " +
                                                          orders[position].clientName,
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                          'City: ' +
                                                              orders[position].city,
                                                          style: TextStyle(
                                                              fontSize: 16)),
                                                      RaisedButton(
                                                        onPressed: () {
                                                          Route route =
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return OrderDetails(index: position);
                                                          });
                                                          Navigator.push(
                                                              context, route);
                                                        },
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            120.0)),
                                                        padding:
                                                            const EdgeInsets.all(
                                                                0.0),
                                                        child: Ink(
                                                          decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  colors: [
                                                                    new Color(
                                                                        0xff374ABE),
                                                                    new Color(
                                                                        0xff64B6FF)
                                                                  ],
                                                                  begin: Alignment
                                                                      .centerLeft,
                                                                  end: Alignment
                                                                      .centerRight),
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          5.0))),
                                                          child: Container(
                                                            constraints:
                                                                const BoxConstraints(
                                                                    maxWidth:
                                                                        90.0,
                                                                    minHeight:
                                                                        40.0), // min sizes for Material buttons
                                                            alignment:
                                                                Alignment.center,
                                                            child: const Text(
                                                              'Details',
                                                              textAlign: TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            ),
                          );
                         },
                      );
                   
                }else{
                  return Center(child: Text('Empty data'),);
                }
              },
            ),
          ),
        )
      ]),
    );
  }
 
}
