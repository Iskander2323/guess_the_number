import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solva_test_app/components/bloc/game_bloc.dart';
import 'package:solva_test_app/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: MaterialApp.router(
        title: 'Guess the number',
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
      ),
    );
  }
}
