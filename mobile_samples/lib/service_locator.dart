import 'package:get_it/get_it.dart';
import 'package:tradeleaves/tl-services/catalog/CatalogServiceImpl.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton(() => CatalogServiceImpl());
}