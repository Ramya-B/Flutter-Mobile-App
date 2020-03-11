import 'package:get_it/get_it.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';
import 'package:tradeleaves/tl-services/crm/CrmServiceImpl.dart';


GetIt locator = GetIt.instance;

setupServiceLocator() {
   locator.registerLazySingleton(() => CatalogServiceImpl());
  locator.registerLazySingleton(() => CrmServiceImpl());
}