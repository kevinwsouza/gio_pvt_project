import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frotalog_gestor_v2/app/features/home%20screen/presenter/bloc/home_screen_controller.dart';
import 'package:frotalog_gestor_v2/app/features/home%20screen/presenter/bloc/home_screen_state.dart';
import 'package:frotalog_gestor_v2/app/features/home%20screen/presenter/widgets/vehicle_list_widget.dart';
import 'package:frotalog_gestor_v2/app/shared/components/custom_app_bar.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenController, HomeScreenState>(builder: (context, state) {
      return Scaffold(
        appBar: CustomAppBar(showLogoutButton: true),
        body: VehicleListWidget(),
      );
    });
  }
}
