import 'package:flutter/material.dart';
import 'package:frotalog_gestor_v2/app/shared/routes/routes.dart';


class FrotaApp extends StatelessWidget {
  const FrotaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Bloc',
      routerConfig: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}