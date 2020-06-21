import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier{
  String id;
  String _name;
  String _price;
  String _category;
  String _description;
  String _image;


  Product(this._name, this._price, this._category,this._description,this._image );

  Product.fromJson(Map<String,dynamic> map, String id):this.id = id ?? ''
  ,this._name = map['name'],
    this._price = map['price'],
    this._category = map['category'],
    this._description = map['description'],
    this._image = map['image'];
  toJson(){
    return{
      'id':id,
      'name':_name,
      'price':_price,
      'category':_category,
      'description':_description,
      'image':_image
    };
  }
  Product.map(dynamic obj) {
    this._name = obj['name'];
    this._price = obj['price'];
    this._category = obj['category'];
    this._description = obj['description'];
    this._image = obj['image'];
  }


  String get name => _name;
  String get price => _price;
  String get category => _category;
  String get image => _image;
  String get description => _description;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["price"] = _price;
    map["category"] = _category;
    map["description"] = _description;
    map["image"] = _image;
    return map;
  }
}
