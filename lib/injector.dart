import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:years_in_flutter/core/network/network_info.dart';
import 'package:years_in_flutter/data/datasources/pixel_datasource.dart';

import 'cubit/pixelsinyears_cubit.dart';

final GetIt sl = GetIt.instance;

//PixelsinyearsCubit(PixelRepositoryImpl(
//             PixelDatasourceImpl(Hive), NetworkInfoImpl(Connectivity()))),
void init() {
  sl.registerLazySingleton(() => PixelsinyearsCubit(sl()));
  sl.registerLazySingleton(() => PixelDatasourceImpl(sl()));
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Hive);
}
