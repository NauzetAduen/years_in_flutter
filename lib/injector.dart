import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:years_in_flutter/data/datasources/pixel_datasource.dart';

import 'cubit/pixelsinyears_cubit.dart';
import 'data/repository/pixel_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  await Hive.initFlutter();
  sl.registerLazySingleton<HiveInterface>(() => Hive);
  sl.registerLazySingleton<PixelDatasource>(() => PixelDatasourceImpl(sl()));
  sl.registerLazySingleton<PixelRepository>(() => PixelRepositoryImpl(sl()));
  sl.registerFactory<PixelsinyearsCubit>(() => PixelsinyearsCubit(sl()));
}
