import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solva_test_app/components/bloc/game_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.isVictory});

  final bool isVictory;

  List<Color> _resultColors() {
    return isVictory
        ? [
            const Color.fromRGBO(59, 217, 6, 1),
            const Color.fromRGBO(0, 106, 255, 1)
          ]
        : [
            const Color.fromRGBO(217, 6, 6, 1),
            const Color.fromRGBO(230, 0, 255, 1)
          ];
  }

  TextStyle _textStyle(BuildContext context, double fontSize) {
    return Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontSize: fontSize, fontFamily: 'BadComic');
  }

  Widget _gameResultTitle(BuildContext context) {
    return Text(
      isVictory ? 'Вы выиграли!' : 'Вы проиграли!',
      style: _textStyle(context, 40),
      textAlign: TextAlign.center,
    );
  }

  Widget _showTrueGuessedNumber(BuildContext context, int randNumber) {
    return Column(
      children: [
        Text(
          'Загаданное число было:',
          style: _textStyle(context, 24),
          textAlign: TextAlign.center,
        ),
        Text(
          '$randNumber',
          style: _textStyle(context, 40),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _restartButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed('parametersPage'),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 60,
        width: double.infinity,
        child: Text(
          'Начать заново',
          style: _textStyle(context, 24).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _resultColors(),
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _gameResultTitle(context),
                    _showTrueGuessedNumber(context, state.randNumber),
                    _restartButton(context),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
