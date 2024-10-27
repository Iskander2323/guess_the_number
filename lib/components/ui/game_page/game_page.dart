import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solva_test_app/components/bloc/game_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController guessedNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final titleStyle =
        theme.titleLarge!.copyWith(fontSize: 40, fontFamily: 'BadComic');
    final subtitleStyle = theme.titleLarge!
        .copyWith(fontSize: 20, fontFamily: 'BadComic', color: Colors.black);

    // Анимированный виджет с кругом и вопросительным знаком
    Widget _animatedCircleAvatar(GameState state) {
      return CircleAvatar(
        backgroundColor: Colors.orangeAccent,
        radius: 40,
        child: const Text('?',
            style: TextStyle(color: Colors.white, fontSize: 54)),
      ).animate(target: state.isWrongAttempt ? 1 : 0).shake(
            duration: 200.ms,
            curve: Curves.bounceOut,
            offset: const Offset(10, 10),
          );
    }

    // Поле ввода с параметрами
    Widget _buildGuessInput() {
      return TextFormField(
        textAlign: TextAlign.center,
        decoration: const InputDecoration(hintText: 'Введите число'),
        style: const TextStyle(fontSize: 42, fontFamily: 'BadComic'),
        controller: guessedNumberController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Введите число';
          }
          final enteredNumber = int.tryParse(value);
          if (enteredNumber == null || enteredNumber < 1) {
            return 'Пожалуйста, введите число больше ноля';
          }
          return null;
        },
      );
    }

    // Кнопка для подтверждения

    // Сообщение с ошибкой
    void _showSnackBar(BuildContext context, String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          content: Text(message, style: const TextStyle(color: Colors.black)),
        ),
      );
    }

    Widget _buildGuessButton(
        BuildContext context, GameState state, BoxConstraints constraints) {
      return GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            final guessedNumber = int.parse(guessedNumberController.text);
            context
                .read<GameBloc>()
                .add(GuessingNumber(guessedNumber: guessedNumber));
            if (state.tryCounts > 0 && guessedNumber != state.randNumber) {
              _showSnackBar(context, 'Не угадали! Попробуйте снова!');
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          height: constraints.maxHeight * 0.09,
          width: double.infinity,
          child: const Text(
            'Угадать',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'BadComic'),
          ),
        ),
      );
    }

    return Scaffold(
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (state.tryCounts == 0 || state.isVictory) {
            context.goNamed('resultPage', extra: state.isVictory);
          }
        },
        builder: (context, state) {
          log(state.maxNumber.toString(), name: 'MAX NUMBER', level: 500);
          log(state.tryCounts.toString(), name: 'NUMBER OF TRIES', level: 500);
          log(state.randNumber.toString(), name: 'RAND NUMBER', level: 500);
          return LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(196, 6, 217, 1),
                      Color.fromRGBO(255, 195, 0, 1)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Угадайте число', style: titleStyle),
                      _animatedCircleAvatar(state),
                      Text('Осталось попыток: ${state.tryCounts}',
                          style: subtitleStyle),
                      _buildGuessInput(),
                      _buildGuessButton(context, state, constraints),
                      TextButton(
                        onPressed: () => context.goNamed('parametersPage'),
                        child: Text('Изменить параметры',
                            style: subtitleStyle.copyWith(
                                color: const Color.fromARGB(255, 50, 46, 46))),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
