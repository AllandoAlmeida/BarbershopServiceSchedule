import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_theme.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/feateres/auth/login/login_page.dart';
import 'package:dw_barbershop/src/feateres/auth/register/user_register_page.dart';
import 'package:dw_barbershop/src/feateres/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
      return MaterialApp(
      title: "DW Barbershop",
      theme: BarbershopTheme.themeData,
      navigatorObservers: [asyncNavigatorObserver],
      navigatorKey: BarbershopNavGlobalKey.instance.navKey,
      routes: {
        '/': (_) => const SplashPage(),
        '/auth/login': (_) => const LoginPage(),
        '/auth/register/user': (_) => const UserRegisterPage(),
        '/home/adm': (_) => const Text('ADM'),
        '/home/employee': (_) => const Text('EMPLOYEE'),
      },
    );
    },
    );
  }
}
