import 'package:e_commerce_app/Core/ViewModels/CRUDModel.dart';
import 'package:get_it/get_it.dart';

import 'Services/Api.dart';

GetIt getIt = GetIt.instance;

setUpLocator(){
  //getIt.registerLazySingleton(() => Api('Products'));
  getIt.registerLazySingleton(() => Api('Orders'));
  getIt.registerLazySingleton(() => CURDModel());
}