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
  final TextEditingController maxNumberTextController = TextEditingController();
  final TextEditingController tryCountsTextController = TextEditingController();

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    double fontSize = 30,
  }) {
    return TextFormField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: 'BadComic'),
      ),
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'BadComic',
      ),
      controller: controller,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final titleStyle = theme.titleLarge!.copyWith(
      fontSize: 40,
      fontFamily: 'BadComic',
    );
    final bodyStyle = theme.bodyLarge!.copyWith(
      fontSize: 20,
      fontFamily: 'BadComic',
    );

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
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(246, 238, 10, 1),
                      Color.fromRGBO(200, 114, 8, 1)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Задайте условия', style: titleStyle),
                      Text(
                        'Числа начинаются от 1',
                        textAlign: TextAlign.center,
                        style: bodyStyle,
                      ),
                      _buildTextField(
                        controller: maxNumberTextController,
                        hintText: 'Максимальное число',
                      ),
                      _buildTextField(
                        controller: tryCountsTextController,
                        hintText: 'Количество попыток',
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final maxNumber =
                                int.parse(maxNumberTextController.text);
                            final randNumber = 1 + Random().nextInt(maxNumber);
                            final tryCounts =
                                int.parse(tryCountsTextController.text);
                            context.read<GameBloc>().add(SetParametersEvent(
                                  maxNumber: maxNumber,
                                  tryCounts: tryCounts,
                                  randNumber: randNumber,
                                ));
                            context.goNamed('gamePage');
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
                            'Начать игру',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BadComic',
                            ),
                          ),
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
