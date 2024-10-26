import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Угадай число',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 40),
              ),
              Text(
                  'Для победы надо угадать загаданное число за ограниченное количество попыток',
                  style: Theme.of(context).textTheme.bodyLarge),
              GestureDetector(
                onTap: () => context.goNamed('parametersPage'),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.redAccent),
                  height: contrains.maxHeight * 0.09,
                  width: double.infinity,
                  child: Text('К игре'),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
