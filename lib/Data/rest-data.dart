// import 'dart:async';
// import 'package:e_commerce_app/Model/user.dart';

// import 'database_helper.dart';

// class RestData {
//   static final BASE_URL = "";
//   static final LOGIN_URL = BASE_URL + "/";

//   Future<User> login( String username, String password,String type) async {
//     String flagLogged = "logged";
//     //simulate internet connection by selecting the local database to check if user has already been registered
//     var user = new User(null, username, password, null,type);
//     var db = new DatabaseHelper();
//     var userRetorno = new User(null,null,null,null,null);
//     userRetorno = await db.selectUser(user);
//     if(userRetorno != null){
//       flagLogged = "logged";
//       return new Future.value(new User(null, username, password,flagLogged,type));
//     }else {
//       flagLogged = "not";
//       return new Future.value(new User(null, username, password,flagLogged,type));
//     }
//   }
// }
