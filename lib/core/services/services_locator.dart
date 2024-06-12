import 'package:get_it/get_it.dart';



final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// DATA SOURCE
    // sl.registerLazySingleton<BaseOneToOne_DateSource>(
    //     () => OneToOneDateSource());
    //
    // /// Repository
    // sl.registerLazySingleton<BaseOneToOneRepository>(
    //     () => OneToOneRepository(baseOneToOne_DateSource: sl()));
    //
    // // /// Use Cases
    // sl.registerLazySingleton(
    //     () => GetHistoryUsersChat_UseCase(baseOneToOneRepository: sl()));
    //
    // sl.registerLazySingleton(
    //         () => Get_UserChatByUserName_UseCase(baseOneToOneRepository: sl()));
    //
    //
    //
    // // Bloc
    // sl.registerFactory(() => ChatCubit(sl(),sl()));
  }
}
