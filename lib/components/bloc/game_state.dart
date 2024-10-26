part of 'game_bloc.dart';

final class GameState extends Equatable {
  final int tryCounts;
  final int maxNumber;
  final int randNumber;
  final bool isVictory;

  const GameState(
      {this.tryCounts = 0,
      this.maxNumber = 0,
      this.randNumber = 1,
      this.isVictory = false});

  GameState copyWith(
      {int? tryCounts, int? maxNumber, int? randNumber, bool? isVictory}) {
    return GameState(
        tryCounts: tryCounts ?? this.tryCounts,
        maxNumber: maxNumber ?? this.maxNumber,
        randNumber: randNumber ?? this.randNumber,
        isVictory: isVictory ?? this.isVictory);
  }

  @override
  List<Object?> get props => [tryCounts, maxNumber, randNumber, isVictory];
}
