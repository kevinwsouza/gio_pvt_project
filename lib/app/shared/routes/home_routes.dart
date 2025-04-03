import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frotalog_gestor_v2/app/features/Login/presenter/bloc/login_controller.dart';
import 'package:frotalog_gestor_v2/app/features/Login/presenter/pages/login_page.dart';
import 'package:frotalog_gestor_v2/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/detail screen/presenter/bloc/details_screen_controller.dart';

import '../../features/detail screen/presenter/pages/details_screen_page.dart';
import '../../features/home screen/presenter/bloc/home_screen_controller.dart';
import '../../features/home screen/presenter/pages/home_screen_page.dart';
import '../mocks/vehicle_model.dart';

class HomeRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String details = '/details';

  static HomeRoutes? _instance;

  static HomeRoutes getinstance() => _instance ??= HomeRoutes();

  final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage(
        child: const SplashScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider(
          create: (_) => LoginController(),
          child: const LoginPage(),
        ),
      ),
    ),
    GoRoute(
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(
                child: BlocProvider(
              create: (_) => HomeScreenController(),
              child: const HomeScreenPage(),
            ))),
    GoRoute(
      path: '/details',
      pageBuilder: (context, state) {
        final vehicle = state.extra as VehicleModel;
        return MaterialPage(
          child: BlocProvider(
            create: (_) => DetailsScreenController(),
            child: DetailsScreenPage(vehicle: vehicle),
          ),
        );
      },
    ),
  ];
}
