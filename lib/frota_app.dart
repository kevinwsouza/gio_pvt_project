import 'package:flutter/material.dart';

import 'package:frotalog_gestor_v2/app/shared/routes/router_register.dart';

class FrotaApp extends StatelessWidget {
  const FrotaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final routerInstance = RouterRegister.getInstance().router;

    return MaterialApp.router(
      title: 'Flutter Bloc',
      routerConfig: routerInstance,
      debugShowCheckedModeBanner: false,
    );
  }
}
