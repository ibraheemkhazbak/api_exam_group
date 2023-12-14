
import 'package:apiexam/features/data/repository/cat_image_repository.dart';
import 'package:apiexam/features/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

import '../database/api/api_consumer.dart';
import '../database/api/dio_consumer.dart';
import '../database/cache_helper/cache_helper.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

void initServiceLoactor(){
  sl.registerLazySingleton(()=> CacheHelper());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(sl()));
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => CatImageRepository(apiConsumer: sl<ApiConsumer>()));
  sl.registerLazySingleton(() => HomeCubit(sl<CatImageRepository>()));

}