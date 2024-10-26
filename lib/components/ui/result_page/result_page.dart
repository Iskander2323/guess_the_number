import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.isVictory});

  final bool isVictory;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<Color> _resultColors(bool result) {
    if (result) {
      return [Color.fromRGBO(59, 217, 6, 1), Color.fromRGBO(0, 106, 255, 1)];
    } else {
      return [Color.fromRGBO(217, 6, 6, 1), Color.fromRGBO(230, 0, 255, 1)];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, contrains) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: contrains.maxHeight,
          width: contrains.maxWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _resultColors(widget.isVictory),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isVictory ? 'Вы выиграли!' : 'Вы проиграли!',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 40),
              ),
              GestureDetector(
                onTap: () => context.goNamed('parametersPage'),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.redAccent),
                  height: contrains.maxHeight * 0.09,
                  width: double.infinity,
                  child: Text('Начать заново'),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
