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
    getIt.registerLazySingleton<MemberApiRepository>(
      () => MemberHttpApiRepository(),
    ); // Registering MemberHttpApiRepository as a lazy singleton for MemberApiRepository
    getIt.registerLazySingleton<TreeApiRepository>(
      () => TreeHttpApiRepository(),
    ); // Registering TreeHttpApiRepository as a lazy singleton for TreeApiRepository
  }
}
