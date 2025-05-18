import 'dart:math';
import 'tile.dart';

enum GameDirection { up, right, down, left }

int _tileIdCounter = 0;

class GameState {
  final List<List<Tile?>> board;
  final int score;
  final int bestScore;
  final bool gameOver;
  final bool gameWon;

  static const int boardSize = 4;
  static const int winningValue = 2048;

  const GameState({
    required this.board,
    this.score = 0,
    this.bestScore = 0,
    this.gameOver = false,
    this.gameWon = false,
  });

  bool get isGameOver => gameOver;
  bool get isGameWon => gameWon;

  factory GameState.newGame({int? savedBestScore}) {
    final List<List<Tile?>> emptyBoard = List.generate(boardSize, (row) => List.generate(boardSize, (col) => null));
    final random = Random();
    final positions = <List<int>>[];
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        positions.add([row, col]);
      }
    }
    positions.shuffle(random);
    final first = positions[0];
    final second = positions[1];
    final boardWithTiles = List<List<Tile?>>.from(emptyBoard.map((r) => List<Tile?>.from(r)));
    boardWithTiles[first[0]][first[1]] = Tile(
      id: _tileIdCounter++,
      value: 2,
      row: first[0],
      col: first[1],
      isNew: true,
    );
    boardWithTiles[second[0]][second[1]] = Tile(
      id: _tileIdCounter++,
      value: 2,
      row: second[0],
      col: second[1],
      isNew: true,
    );
    return GameState(board: boardWithTiles, score: 0, bestScore: savedBestScore ?? 0);
  }

  List<List<int>> get emptyPositions {
    final List<List<int>> empty = [];
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (board[row][col] == null) {
          empty.add([row, col]);
        }
      }
    }
    return empty;
  }

  GameState addRandomTile() {
    final positions = emptyPositions;
    if (positions.isEmpty) return this;
    final random = Random();
    final randomPosition = positions[random.nextInt(positions.length)];
    final row = randomPosition[0];
    final col = randomPosition[1];
    final value = random.nextDouble() < 0.9 ? 2 : 4;
    final newBoard = List<List<Tile?>>.from(board.map((r) => List<Tile?>.from(r)));
    newBoard[row][col] = Tile(id: _tileIdCounter++, value: value, row: row, col: col, isNew: true);
    return GameState(board: newBoard, score: score, bestScore: bestScore, gameOver: gameOver, gameWon: gameWon);
  }

  bool get hasMoves {
    if (emptyPositions.isNotEmpty) return true;
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        final Tile? tile = board[row][col];
        if (tile != null) {
          final directions = [
            [-1, 0],
            [0, 1],
            [1, 0],
            [0, -1],
          ];
          for (final dir in directions) {
            final newRow = row + dir[0];
            final newCol = col + dir[1];
            if (newRow >= 0 && newRow < boardSize && newCol >= 0 && newCol < boardSize) {
              final Tile? adjacent = board[newRow][newCol];
              if (adjacent != null && adjacent.value == tile.value) {
                return true;
              }
            }
          }
        }
      }
    }
    return false;
  }

  bool isMerged(int row, int col) {
    final tile = board[row][col];
    return tile != null && tile.merged;
  }

  GameState resetMergeFlags() {
    final newBoard = List<List<Tile?>>.from(
      board.map((row) => List<Tile?>.from(row.map((tile) => tile?.copyWith(merged: false, isNew: false)))),
    );
    return GameState(
      board: newBoard,
      score: score,
      bestScore: max(bestScore, score),
      gameOver: gameOver,
      gameWon: gameWon,
    );
  }

  GameState move(GameDirection direction) {
    if (gameOver) return this;
    final List<List<Tile?>> newBoard = List.generate(
      boardSize,
      (row) => List.generate(boardSize, (col) => board[row][col]),
    );
    bool moved = false;
    int addedScore = 0;
    switch (direction) {
      case GameDirection.up:
        for (int col = 0; col < boardSize; col++) {
          for (int row = 1; row < boardSize; row++) {
            if (newBoard[row][col] != null) {
              int currentRow = row;
              while (currentRow > 0) {
                if (newBoard[currentRow - 1][col] == null) {
                  newBoard[currentRow - 1][col] = newBoard[currentRow][col]!.copyWith(row: currentRow - 1);
                  newBoard[currentRow][col] = null;
                  currentRow--;
                  moved = true;
                } else if (newBoard[currentRow - 1][col]!.value == newBoard[currentRow][col]!.value &&
                    !isMerged(currentRow - 1, col)) {
                  final mergedValue = newBoard[currentRow][col]!.value * 2;
                  newBoard[currentRow - 1][col] = newBoard[currentRow - 1][col]!.copyWith(
                    value: mergedValue,
                    merged: true,
                  );
                  newBoard[currentRow][col] = null;
                  addedScore += mergedValue;
                  moved = true;
                  break;
                } else {
                  break;
                }
              }
            }
          }
        }
        break;
      case GameDirection.right:
        for (int row = 0; row < boardSize; row++) {
          for (int col = boardSize - 2; col >= 0; col--) {
            if (newBoard[row][col] != null) {
              int currentCol = col;
              while (currentCol < boardSize - 1) {
                if (newBoard[row][currentCol + 1] == null) {
                  newBoard[row][currentCol + 1] = newBoard[row][currentCol]!.copyWith(col: currentCol + 1);
                  newBoard[row][currentCol] = null;
                  currentCol++;
                  moved = true;
                } else if (newBoard[row][currentCol + 1]!.value == newBoard[row][currentCol]!.value &&
                    !isMerged(row, currentCol + 1)) {
                  final mergedValue = newBoard[row][currentCol]!.value * 2;
                  newBoard[row][currentCol + 1] = newBoard[row][currentCol + 1]!.copyWith(
                    value: mergedValue,
                    merged: true,
                  );
                  newBoard[row][currentCol] = null;
                  addedScore += mergedValue;
                  moved = true;
                  break;
                } else {
                  break;
                }
              }
            }
          }
        }
        break;
      case GameDirection.down:
        for (int col = 0; col < boardSize; col++) {
          for (int row = boardSize - 2; row >= 0; row--) {
            if (newBoard[row][col] != null) {
              int currentRow = row;
              while (currentRow < boardSize - 1) {
                if (newBoard[currentRow + 1][col] == null) {
                  newBoard[currentRow + 1][col] = newBoard[currentRow][col]!.copyWith(row: currentRow + 1);
                  newBoard[currentRow][col] = null;
                  currentRow++;
                  moved = true;
                } else if (newBoard[currentRow + 1][col]!.value == newBoard[currentRow][col]!.value &&
                    !isMerged(currentRow + 1, col)) {
                  final mergedValue = newBoard[currentRow][col]!.value * 2;
                  newBoard[currentRow + 1][col] = newBoard[currentRow + 1][col]!.copyWith(
                    value: mergedValue,
                    merged: true,
                  );
                  newBoard[currentRow][col] = null;
                  addedScore += mergedValue;
                  moved = true;
                  break;
                } else {
                  break;
                }
              }
            }
          }
        }
        break;
      case GameDirection.left:
        for (int row = 0; row < boardSize; row++) {
          for (int col = 1; col < boardSize; col++) {
            if (newBoard[row][col] != null) {
              int currentCol = col;
              while (currentCol > 0) {
                if (newBoard[row][currentCol - 1] == null) {
                  newBoard[row][currentCol - 1] = newBoard[row][currentCol]!.copyWith(col: currentCol - 1);
                  newBoard[row][currentCol] = null;
                  currentCol--;
                  moved = true;
                } else if (newBoard[row][currentCol - 1]!.value == newBoard[row][currentCol]!.value &&
                    !isMerged(row, currentCol - 1)) {
                  final mergedValue = newBoard[row][currentCol]!.value * 2;
                  newBoard[row][currentCol - 1] = newBoard[row][currentCol - 1]!.copyWith(
                    value: mergedValue,
                    merged: true,
                  );
                  newBoard[row][currentCol] = null;
                  addedScore += mergedValue;
                  moved = true;
                  break;
                } else {
                  break;
                }
              }
            }
          }
        }
        break;
    }
    if (!moved) return this;
    final newScore = score + addedScore;
    final newBestScore = max(bestScore, newScore);
    bool hasWon = false;
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (newBoard[row][col] != null && newBoard[row][col]!.value >= winningValue) {
          hasWon = true;
          break;
        }
      }
      if (hasWon) break;
    }
    final updatedState = GameState(
      board: newBoard,
      score: newScore,
      bestScore: newBestScore,
      gameWon: hasWon ? true : gameWon,
      gameOver: false,
    );
    final stateWithNewTile = updatedState.addRandomTile().resetMergeFlags();
    final isGameOver = !stateWithNewTile.hasMoves;
    return GameState(
      board: stateWithNewTile.board,
      score: stateWithNewTile.score,
      bestScore: stateWithNewTile.bestScore,
      gameWon: stateWithNewTile.gameWon,
      gameOver: isGameOver,
    );
  }
}
