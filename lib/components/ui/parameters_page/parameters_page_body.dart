import 'package:flutter/material.dart';

class ParametersPageBody extends StatefulWidget {
  const ParametersPageBody({super.key});

  @override
  State<ParametersPageBody> createState() => _ParametersPageBodyState();
}

class _ParametersPageBodyState extends State<ParametersPageBody> {
  TextEditingController maxNumberTextController = TextEditingController();
  TextEditingController tryCountsTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget _textField(
        TextEditingController textEditingController, String hintText) {
      return TextField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        controller: textEditingController,
        keyboardType: TextInputType.numberWithOptions(),
      );
    }

    return Scaffold(
      body: LayoutBuilder(builder: (context, contrains) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: contrains.maxHeight,
          width: contrains.maxWidth,
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
                //onTap: () => context.goNamed(),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.redAccent),
                  height: contrains.maxHeight * 0.09,
                  width: double.infinity,
                  child: Text('Начать игру'),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
