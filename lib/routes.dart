import 'package:go_router/go_router.dart';
import 'package:solva_test_app/components/ui/home_page.dart';
import 'package:solva_test_app/components/ui/parameters_page/parameters_page_body.dart';

final GoRouter routes = GoRouter(initialLocation: '/home', routes: <RouteBase>[
  GoRoute(
      path: '/home',
      builder: (context, state) => HomePage(),
      routes: <RouteBase>[
        GoRoute(
          path: 'parameters_page',
          name: 'parametersPage',
          builder: (context, state) => ParametersPageBody(),
        )
      ])
]);
