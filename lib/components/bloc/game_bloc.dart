import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late final int maxNumber;
  late final int tryCounts;
  late final int randNumber;

  GameBloc() : super(GameState()) {
    on<GameEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
