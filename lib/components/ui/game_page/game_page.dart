import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solva_test_app/components/bloc/game_bloc.dart';
import 'package:go_router/go_router.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController guessedNumberTextEditingController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GameBloc, GameState>(
        listener: (context, state) {
          if (!state.isVictory && state.tryCounts == 0) {
            context.goNamed('resultPage', extra: state.isVictory);
          } else if (state.isVictory && state.tryCounts > 0) {
            context.goNamed('resultPage', extra: state.isVictory);
          }
        },
        builder: (context, state) {
          log(state.maxNumber.toString(), name: 'MAX NUMBER');
          log(state.tryCounts.toString(), name: 'NUMBER OF TRYS');
          log(state.randNumber.toString(), name: 'RAND NUMBER');
          return LayoutBuilder(builder: (context, contrains) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              height: contrains.maxHeight,
              width: contrains.maxWidth,
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
                    Text(
                      'Угадайте число',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 40),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      radius: 40,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Введите число',
                      ),
                      controller: guessedNumberTextEditingController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                    ),
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey,
                        height: contrains.maxHeight * 0.09,
                        width: double.infinity,
                        child: Text(
                          'Поменять параметры',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final int guessedNumber = int.parse(
                              guessedNumberTextEditingController.text);
                          context.read<GameBloc>().add(
                              GuessingNumber(guessedNumber: guessedNumber));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.red,
                        height: contrains.maxHeight * 0.09,
                        width: double.infinity,
                        child: Text(
                          'Угадать',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
