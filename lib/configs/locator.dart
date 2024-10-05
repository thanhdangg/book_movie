import 'package:get_it/get_it.dart';
import 'package:movie/configs/app_dio.dart';
import 'package:movie/configs/app_router.dart';
import 'package:movie/data/models/movie_service.dart';
import 'package:movie/data/repositories/movie_repository.dart';

final getIt = GetIt.instance;

final dio = getIt<AppDio>().dio;

void setupLocator() {
  getIt.registerSingleton<AppRouter>(AppRouter());
  getIt.registerSingleton<AppDio>(AppDio());
  getIt.registerSingleton<MovieService>(MovieService(dio));
  getIt.registerSingleton<MovieRepository>(MovieRepository());
}