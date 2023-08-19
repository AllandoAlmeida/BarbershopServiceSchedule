import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/feateres/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (AsyncNavigatorObserver) {
      return MaterialApp(
      title: "DW Barbershop",
      navigatorObservers: [AsyncNavigatorObserver],
      routes: {'/': (_) => const SplashPage(),
      },
    );
    },
    );
  }
}
