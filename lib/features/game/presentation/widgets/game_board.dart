import 'package:evolution2048/features/game/logic/game_cubit.dart';
import 'package:evolution2048/features/game/logic/game_state.dart';
import 'package:evolution2048/features/game/logic/tile.dart';
import 'package:evolution2048/features/game/presentation/widgets/tile_widget.dart';
import 'package:evolution2048/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Offset? _startDragPosition;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        final screenWidth = MediaQuery.of(context).size.width;
        final maxBoardSize = screenWidth * 0.9;
        final gridSpacing = 8.0;
        final tileSize = (maxBoardSize - gridSpacing * (GameState.boardSize + 1)) / GameState.boardSize;

        final highestValue = context.read<GameCubit>().highestTileValue;
        final highestTile = Tile(id: 0, value: highestValue, row: 0, col: 0);
        final adaptiveColor = highestTile.baseColor.withAlpha((0.15 * 255).round());

        return GestureDetector(
          onPanStart: (details) {
            _startDragPosition = details.localPosition;
          },
          onPanUpdate: (details) {
            if (_startDragPosition == null) return;
            final currentPosition = details.localPosition;
            final delta = currentPosition - _startDragPosition!;
            if (delta.distance > 20) {
              final GameCubit gameCubit = context.read<GameCubit>();
              if (delta.dx.abs() > delta.dy.abs()) {
                if (delta.dx > 0) {
                  gameCubit.move(GameDirection.right);
                } else {
                  gameCubit.move(GameDirection.left);
                }
              } else {
                if (delta.dy > 0) {
                  gameCubit.move(GameDirection.down);
                } else {
                  gameCubit.move(GameDirection.up);
                }
              }
              _startDragPosition = null;
            }
          },
          onPanEnd: (_) {
            _startDragPosition = null;
          },
          child: Container(
            width: maxBoardSize,
            height: maxBoardSize,
            padding: EdgeInsets.all(gridSpacing),
            decoration: BoxDecoration(
              color: adaptiveColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha((0.2 * 255).round()), blurRadius: 10, spreadRadius: 1),
              ],
            ),
            child: Stack(
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: GameState.boardSize,
                    mainAxisSpacing: gridSpacing,
                    crossAxisSpacing: gridSpacing,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: GameState.boardSize * GameState.boardSize,
                  itemBuilder: (context, index) {
                    return EmptyTile(size: tileSize);
                  },
                ),

                ...buildTileWidgets(state.board, tileSize, gridSpacing),

                if (state.gameOver) _buildGameOverOverlay(maxBoardSize, loc),

                if (state.gameWon && !state.gameOver) _buildWinOverlay(maxBoardSize, loc),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildTileWidgets(List<List<Tile?>> board, double tileSize, double gridSpacing) {
    final List<Widget> tiles = [];
    for (int row = 0; row < GameState.boardSize; row++) {
      for (int col = 0; col < GameState.boardSize; col++) {
        final tile = board[row][col];
        if (tile != null) {
          tiles.add(
            Positioned(
              left: col * (tileSize + gridSpacing),
              top: row * (tileSize + gridSpacing),
              child: TileWidget(tile: tile, size: tileSize),
            ),
          );
        }
      }
    }
    return tiles;
  }

  Widget _buildGameOverOverlay(double boardSize, AppLocalizations loc) {
    return GestureDetector(
      onTap: () => context.read<GameCubit>().newGame(),
      child: Container(
        width: boardSize,
        height: boardSize,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((0.7 * 255).round()),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.gameOver,
              style: TextStyle(
                fontFamily: 'Exo2',
                color: Colors.white,
                fontSize: boardSize * 0.1,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: boardSize * 0.05),
            Text(
              '${loc.score}: ${context.watch<GameCubit>().state.score}',
              style: TextStyle(color: Colors.white, fontSize: boardSize * 0.06),
            ),
            SizedBox(height: boardSize * 0.1),
            ElevatedButton(
              onPressed: () => context.read<GameCubit>().newGame(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF20E3B2),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(loc.playAgain, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWinOverlay(double boardSize, AppLocalizations loc) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: boardSize,
        height: boardSize,
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((0.7 * 255).round()),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.youWin,
              style: TextStyle(
                fontFamily: 'Exo2',
                color: Colors.white,
                fontSize: boardSize * 0.1,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: boardSize * 0.05),
            Text(loc.reachedHuman, style: TextStyle(color: Colors.white, fontSize: boardSize * 0.05)),
            SizedBox(height: boardSize * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<GameCubit>().newGame(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(loc.newGame, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    final gameCubit = context.read<GameCubit>();
                    gameCubit.continueGame();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF20E3B2),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(loc.continueGame, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
