import 'package:family_tree/repository/tree_api/tree_http_api_repository.dart';

import '../repository/tree_api/tree_api_repository.dart';
import 'dependency_injection.dart';

// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;

class ServiceLocator {
  void servicesLocator() {
    getIt.registerLazySingleton<AuthApiRepository>(
      () => AuthHttpApiRepository(),
    ); // Registering AuthHttpApiRepository as a lazy singleton for AuthApiRepository
    getIt.registerLazySingleton<MoviesApiRepository>(
      () => MoviesHttpApiRepository(),
    ); // Registering MoviesHttpApiRepository as a lazy singleton for MoviesApiRepository
    getIt.registerLazySingleton<TreeApiRepository>(
      () => TreeHttpApiRepository(),
    ); // Registering MoviesHttpApiRepository as a lazy singleton for MoviesApiRepository
  }
}
