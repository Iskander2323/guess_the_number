part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

final class ChooseRandomNumber extends GameEvent {}
