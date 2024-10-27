import 'package:go_router/go_router.dart';
import 'package:solva_test_app/components/ui/game_page/game_page.dart';
import 'package:solva_test_app/components/ui/home_page.dart';
import 'package:solva_test_app/components/ui/parameters_page/parameters_page.dart';
import 'package:solva_test_app/components/ui/result_page/result_page.dart';

final GoRouter routes = GoRouter(initialLocation: '/home', routes: <RouteBase>[
  GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: <RouteBase>[
        GoRoute(
            path: 'parameters_page',
            name: 'parametersPage',
            builder: (context, state) => const ParametersPageBody(),
            routes: <RouteBase>[
              GoRoute(
                  path: 'game_page',
                  name: 'gamePage',
                  builder: (context, state) => const GamePage(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'result_page',
                      name: 'resultPage',
                      builder: (context, state) {
                        final bool isVictory = state.extra as bool? ?? false;
                        return ResultPage(isVictory: isVictory);
                      },
                    )
                  ])
            ])
      ])
]);
