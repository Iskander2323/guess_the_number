import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final titleStyle = theme.titleLarge!.copyWith(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      fontFamily: 'BadComic',
    );
    final bodyStyle = theme.bodyLarge!.copyWith(
      fontSize: 24,
      fontFamily: 'BadComic',
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(61, 224, 6, 1),
                  Color.fromRGBO(255, 204, 0, 1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Угадай число',
                  style: titleStyle,
                ),
                Text(
                  'Для победы надо угадать загаданное число за ограниченное количество попыток',
                  textAlign: TextAlign.center,
                  style: bodyStyle,
                ),
                GestureDetector(
                  onTap: () => context.goNamed('parametersPage'),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: constraints.maxHeight * 0.09,
                    width: double.infinity,
                    child: Text(
                      'К игре',
                      style: titleStyle.copyWith(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
