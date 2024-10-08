import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/configs/app_color.dart';
import 'package:movie/configs/app_router.dart';
import 'package:movie/configs/locator.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/screens/home/bloc/home_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // transparent status bar
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black));
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = getIt<AppRouter>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('===MyApp build');
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRepository>(
          create: (context) {
            debugPrint('===Creating RepositoryProvider');
            return MovieRepository();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider<SplashBloc>(
          //   create: (context) {
          //     debugPrint('===Creating SplashBloc');
          //     return SplashBloc(context: context);
          //   },
          // ),
          BlocProvider<HomeBloc>(
            create: (context) {
              debugPrint('===Creating HomeBloc');
              return HomeBloc(context: context);
            },
          ),
        ],
        child: MaterialApp.router(
          title: 'Movie',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: AppColor.backgroundColor,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(AppColor.primaryColor), // Primary color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Rounded rectangle shape
                  ),
                ),
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
          // routerDelegate: _appRouter.delegate(),
        ),
      ),
    );
  }
}
