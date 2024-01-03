import 'package:rebustar_driver/data/repositories/home_repo.dart';
import 'package:get_it/get_it.dart';

import '../../utils.dart';

final locator = GetIt.instance;

void setupLocator() async {
  //not using locator.registerLazySingleton(() => NavigationService.getInstance());
  locator.registerLazySingleton(() => AppSecureStorage.getInstance());
  locator.registerLazySingleton(() => PermissionHandler.getInstance());

  //repositories
  locator.registerFactory(() => HomeRepository());

  // final SharedPrefs sharedPrefs = await SharedPrefs.getInstance();
  // locator.registerSingleton(sharedPrefs);
}
