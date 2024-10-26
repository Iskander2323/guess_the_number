part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

final class ChooseRandomNumber extends GameEvent {}

final class SetParametersEvent extends GameEvent {
  final int maxNumber;
  final int tryCounts;
  final int randNumber;
  SetParametersEvent(
      {required this.maxNumber,
      required this.tryCounts,
      required this.randNumber});
}

final class GuessingNumber extends GameEvent {
  final int guessedNumber;
  GuessingNumber({required this.guessedNumber});
}
