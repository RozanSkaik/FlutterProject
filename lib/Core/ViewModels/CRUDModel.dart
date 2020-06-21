import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/Core/Services/Api.dart';
import 'package:e_commerce_app/Core/locater.dart';
import 'package:e_commerce_app/Model/order_data.dart';
import 'package:e_commerce_app/Model/product.dart';
import 'package:e_commerce_app/Model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CURDModel extends ChangeNotifier {
  Api _api = getIt<Api>();
  List<Product> products;
  List<User> users;
  List<OrderData> orders;

  Future<List<Product>> fetchProduct() async {
    var results = await _api.getCollectionDocs();
    products = results.documents
        .map((doc) => Product.fromJson(doc.data, doc.documentID))
        .toList();
    return products;
  }

  Future<List<OrderData>> fetchOrders() async {
    var results = await _api.getCollectionDocs();
    orders = results.documents
        .map((doc) => OrderData.fromJson(doc.data, doc.documentID))
        .toList();
    return orders;
  }

  Stream<QuerySnapshot> fetchProductAsStream() {
    return _api.getCollectionDocsAsStream();
  }
  Stream<QuerySnapshot> fetchOrderAsStream() {
    return _api.getCollectionDocsAsStream();
  }
  Future<Product> getProductById(String id) async {
    DocumentSnapshot documentSnapshot = await _api.getDocumentById(id);
    Product product = Product.fromJson(documentSnapshot.data, id);
    return product;
  }

  Future<String> addProduct(Product product) async {
    DocumentReference documentReference =
        await _api.addDocument(product.toJson());
    notifyListeners();
    return documentReference.documentID;
  }

  removeProduct(String id) async {
    _api.deleteDocument(id);
    notifyListeners();
  }

  updateProduct(String id, Map data) async {
    _api.updateDocument(id, data);
    notifyListeners();
  }


  getType() async {
    var results = await _api.getCollectionDocs();
    users = results.documents
        .map((doc) => User.fromJson(doc.data, doc.documentID))
        .toList();
    return users[0].type;
  }

  Future<String> getTypeById(String id) async {
    DocumentSnapshot documentSnapshot = await _api.getDocumentById(id);
    User user = User.fromJson(documentSnapshot.data, id);
    return user.type;
  }
  
}
