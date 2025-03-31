import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frotalog_gestor_v2/app/features/Login/presenter/bloc/login_controller.dart';
import 'package:frotalog_gestor_v2/app/features/Login/presenter/pages/login_page.dart';
import 'package:frotalog_gestor_v2/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/home screen/presenter/bloc/home_screen_controller.dart';
import '../../features/home screen/presenter/pages/home_screen_page.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) => 
      MaterialPage(
        child: const SplashScreen(),
      ),
  ),
  GoRoute(
    path: '/login',
    pageBuilder: (context, state) => 
      MaterialPage(
        child: BlocProvider(
          create: (_) => LoginController(), 
          child: const LoginPage(),
        ),
      ),
  ),
  GoRoute(
    path: '/home',
    pageBuilder: (context, state) =>
      MaterialPage(
        child: BlocProvider(
          create: (_) => HomeScreenController(),
          child: const HomeScreenPage(),
          )
      )
  )
]);