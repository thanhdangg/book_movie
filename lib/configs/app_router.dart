import 'package:auto_route/auto_route.dart';
import 'package:movie/screens/home/home_page.dart';
import 'package:movie/screens/splash/splash_page.dart';
part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
    @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeRoute.page, initial: false),
  ];
}