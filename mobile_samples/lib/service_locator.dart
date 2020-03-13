import 'package:get_it/get_it.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/core-npm/UserServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';
import 'package:tradeleaves/tl-services/login/LoginServiceImpl.dart';


GetIt locator = GetIt.instance;

setupServiceLocator() {
   locator.registerLazySingleton(() => CatalogServiceImpl());
  locator.registerLazySingleton(() => CrmServiceImpl());
  locator.registerLazySingleton(() => LogInServiceImpl());
  locator.registerLazySingleton(() => UserServiceImpl());
}