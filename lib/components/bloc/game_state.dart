part of 'game_bloc.dart';

final class GameState extends Equatable {
  final int numberOfTrys;
  final int maxNumber;
  final int guessedNumber;

  GameState(
      {this.numberOfTrys = 0, this.maxNumber = 0, this.guessedNumber = 0});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
