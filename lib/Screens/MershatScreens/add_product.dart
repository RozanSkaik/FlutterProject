import 'dart:io';

import 'package:e_commerce_app/Data/database_helper.dart';
import 'package:e_commerce_app/Model/product.dart';
import 'package:e_commerce_app/Utilis/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'm_home_screen.dart';

class AddProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddProductState();
  }
}

class AddProductState extends State<AddProduct> {
  Future<File> imageFile;
  var product;
  Image image;
  File _image;
  DatabaseHelper dbHelper;
  List<Product> images;
  String imgString;

  Future getImage() async {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      imgString = Utility.base64String(imgFile.readAsBytesSync());
      _showSnackBar("Image Selected");
    });
  }

  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _name, _price, _category, _description;

  String priceValidation(value) {
    if (value.isEmpty) {
      return 'Price Required !!';
    }
  }

  String nameValidation(value) {
    if (value.isEmpty) {
      return 'Name Required !!';
    }
  }

  String categoryValidation(value) {
    if (value.isEmpty) {
      return 'Category Required !!';
    }
  }

  String descriptionValidation(value) {
    if (value.isEmpty) {
      return 'Description Required !!';
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<Product>(
          create: (BuildContext context) { 
            return Product(_name,_price,_category,_description,imgString);
           },
          child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: initScreen(context),
        ),
      ),
    );
  }

  initScreen(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            "Add Product",
            style: TextStyle(fontSize: 30.0),
          ),
        ),

        // Product Name Edit text
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _name = val,
                  validator: nameValidation,
                  decoration: InputDecoration(
                      labelText: "Product Name", border: OutlineInputBorder()),
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _price = val,
                  validator: priceValidation,
                  decoration: InputDecoration(
                    labelText: "Product Price", // Set text upper animation
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                ),
              ),
              // Product Category Edit text
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _category = val,
                  validator: categoryValidation,
                  decoration: InputDecoration(
                    labelText: "Product Category", // Set text upper animation
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                ),
              ),
              // Discription Edit text
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                child: TextFormField(
                  onSaved: (val) => _description = val,
                  validator: descriptionValidation,
                  decoration: InputDecoration(
                    labelText: "Discription", // Set text upper animation
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Center(
              //     child: imageFile == null
              //         ? Text('No image selected.')
              //         : Flexible(
              //             child: _image,
              //           ),
              //   ),
              // ),

              Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: RaisedButton(
                        onPressed:
                            getImage, // When Click on Button goto Login Screen

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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 300.0,
                                minHeight:
                                    40.0), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: const Text(
                              'Pick Image',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ))),
              Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        onPressed: () {
                          _submit();
                        }, 

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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxWidth: 300.0,
                                minHeight:
                                    40.0), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: const Text(
                              'Add Product',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ))),
            ],
          ),
        ),

        // Product Price Edit text
      ],
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        product =
            new Product(_name, _price, _category, _description, imgString);
        print(product.name + "*******");
        var db = new DatabaseHelper();
        db.saveProduct(product);
        _isLoading = false;
        _showSnackBar(product.name + " Added Successfully !");
      });
    }
  }
}
