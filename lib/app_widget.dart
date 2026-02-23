import 'package:dadosbr/core/ds/theme/app_theme.dart';
import 'package:dadosbr/routes/app_router.dart';
import 'package:dadosbr/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DadosBr',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
