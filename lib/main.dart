import 'package:e_commerce_app/Core/ViewModels/CRUDModel.dart';
import 'package:e_commerce_app/Core/locater.dart';
import 'package:e_commerce_app/Screens/ClientScreen/Cart.dart';
import 'package:e_commerce_app/Screens/ClientScreen/Details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/ClientScreen/Home.dart';
import 'Screens/ClientScreen/ScopeManage.dart';
import 'Screens/router.dart';
import 'Screens/splash_screen.dart';

void main() {
  setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppModel appModel = AppModel();

  final routes = <String, WidgetBuilder>{
    Home.route: (BuildContext context) => Home(),
    Details.route: (BuildContext context) => Details(),
    Cart.route: (BuildContext context) => Cart()
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => getIt<CURDModel>())
      ],
      child: MaterialApp(
        home: SplashScreen(),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
