import 'package:e_commerce_app/Data/database_helper.dart';
import 'package:e_commerce_app/Screens/MershatScreens/order_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  var db = new DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: init(context)));
  }

  init(BuildContext context) {
    int index;
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
          child: FutureBuilder<List>(
            future: db.getAllRecords(),
            initialData: List(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, int position) {
                        index = position;
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
                                                Text(snapshot.data[position]
                                                          .row[1] +
                                                      '\n',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    "Price: " +
                                                        snapshot.data[position]
                                                            .row[2] +
                                                        '\n',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text(
                                                    "Client Name: " +
                                                        snapshot.data[position]
                                                            .row[3],
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                        'City: ' +
                                                            snapshot
                                                                .data[position]
                                                                .row[4],
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
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        )
      ]),
    );
  }
}
