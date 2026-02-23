import 'package:dadosbr/modules/cep/view/cep_view.dart';
import 'package:dadosbr/modules/cpnj/view/cnpj_view.dart';
import 'package:dadosbr/modules/domain/view/domain_view.dart';
import 'package:dadosbr/modules/home/view/home_view.dart';
import 'package:dadosbr/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return _route(const HomeView());

      case AppRoutes.cep:
        return _route(CepView());

      case AppRoutes.cnpj:
        return _route(const CnpjView());

      case AppRoutes.domain:
        return _route(const DomainView());

      default:
        return _route(const HomeView());
    }
  }

  static MaterialPageRoute _route(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}
