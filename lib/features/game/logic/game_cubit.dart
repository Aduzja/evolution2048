import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  static const String bestScoreKey = 'best_score';

  GameCubit() : super(GameState.newGame());

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedBestScore = prefs.getInt(bestScoreKey) ?? 0;
    emit(GameState.newGame(savedBestScore: savedBestScore));
  }

  void move(GameDirection direction) {
    final newState = state.move(direction);
    if (newState.bestScore > state.bestScore) {
      _saveBestScore(newState.bestScore);
    }
    emit(newState);
  }

  Future<void> _saveBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(bestScoreKey, score);
  }

  void newGame() {
    emit(GameState.newGame(savedBestScore: state.bestScore));
  }

  void continueGame() {
    emit(
      GameState(
        board: state.board,
        score: state.score,
        bestScore: state.bestScore,
        gameOver: false,
        gameWon: state.gameWon,
      ),
    );
  }

  int get highestTileValue {
    int highest = 0;
    for (int row = 0; row < GameState.boardSize; row++) {
      for (int col = 0; col < GameState.boardSize; col++) {
        final tile = state.board[row][col];
        if (tile != null && tile.value > highest) {
          highest = tile.value;
        }
      }
    }
    return highest;
  }
}
