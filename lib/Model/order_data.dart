class OrderData{
  String productName;
  String price;
  String clientName;
  String city;
  OrderData.fromJson(Map<String,dynamic> map, String id):
  this.productName = map['ProductName'],
    this.price = map['Price'],
    this.clientName = map['ClientName'],
    this.city = map['City'];
  toJson(){
    return{
      'ProductName':productName,
      'Price':price,
      'ClientName':clientName,
      'City':city,
    };
  }
  static final getData = [
   {
     'ProductName': 'Puma Descendant Ind',
     'Price': '\$299.00',
     'ClientName': 'Lina',
     'City' : 'Gaza'
   },
   {
     'ProductName': 'Running Shoe Brooks',
     'Price': '\$3001.00',
     'ClientName': 'Ahmed',
     'City' : 'Rafah'
   },
   {
     'ProductName': 'Ugly Shoe Trends',
     'Price': '\$25.00',
     'ClientName': 'Mohammed',
     'City' : 'Egypt'
   },
   {
     'ProductName': 'Nordstorm',
     'Price': '\$210.00',
     'ClientName': 'Rozan',
     'City' : 'Turkish'
   },
 ];
}