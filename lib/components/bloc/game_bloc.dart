import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState()) {
    on<SetParametersEvent>((event, emit) => _setParameters(event, emit));
    on<GuessingNumber>((event, emit) => _guessingNumber(event, emit));
  }

  void _setParameters(SetParametersEvent event, Emitter<GameState> emit) async {
    emit(state.copyWith(
        maxNumber: event.maxNumber,
        tryCounts: event.tryCounts,
        randNumber: event.randNumber,
        isVictory: false));
  }

  void _guessingNumber(GuessingNumber event, Emitter<GameState> emit) async {
    if (event.guessedNumber == state.randNumber) {
      log('PLAYER WON THE GAME');
      emit(state.copyWith(isVictory: true));
    } else {
      log('WRONG ANSWER');
      final int decreasedTryCounts = state.tryCounts - 1;
      emit(state.copyWith(tryCounts: decreasedTryCounts, isWrongAttempt: true));
      await Future.delayed(Duration(milliseconds: 500));
      emit(state.copyWith(isWrongAttempt: false));
    }
  }
}
