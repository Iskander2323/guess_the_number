import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:solva_test_app/components/bloc/game_bloc.dart';

class ParametersPageBody extends StatefulWidget {
  const ParametersPageBody({super.key});

  @override
  State<ParametersPageBody> createState() => _ParametersPageBodyState();
}

class _ParametersPageBodyState extends State<ParametersPageBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController maxNumberTextController = TextEditingController();
  TextEditingController tryCountsTextController = TextEditingController();

  Widget _textField(
      TextEditingController textEditingController, String hintText) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      controller: textEditingController,
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(59, 217, 6, 1),
                      Color.fromRGBO(255, 195, 0, 1)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Задайте условия',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 40),
                      ),
                      _textField(maxNumberTextController, 'Максимальное число'),
                      _textField(tryCountsTextController, 'Количество попыток'),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final int maxNumber =
                                int.parse(maxNumberTextController.text);
                            final int randNumber =
                                1 + Random().nextInt(maxNumber);
                            final int tryCounts =
                                int.parse(tryCountsTextController.text);
                            context.read<GameBloc>().add(SetParametersEvent(
                                maxNumber: maxNumber,
                                tryCounts: tryCounts,
                                randNumber: randNumber));
                            context.goNamed('gamePage');
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.redAccent),
                          height: constraints.maxHeight * 0.09,
                          width: double.infinity,
                          child: Text('Начать игру'),
                        ),
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
