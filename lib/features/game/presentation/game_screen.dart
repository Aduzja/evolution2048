import 'package:evolution2048/features/game/logic/game_cubit.dart';
import 'package:evolution2048/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/game_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF101935),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, loc),
            const SizedBox(height: 20),
            const Expanded(child: Center(child: GameBoard())),
            const SizedBox(height: 20),
            _buildControls(context, loc),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations loc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Column(
            children: [
              Text(
                loc.title,
                style: TextStyle(
                  fontFamily: 'Exo2',
                  color: const Color(0xFF20E3B2),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 3.0,
                      color: Colors.black.withAlpha((0.3 * 255).round()),
                    ),
                  ],
                ),
              ),
              Text(loc.subtitle, style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () => _showHelpDialog(context, loc),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context, AppLocalizations loc) {
    final state = context.watch<GameCubit>().state;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildScoreBox(title: loc.score, score: state.score, color: const Color(0xFF8B5CF6)),
          const SizedBox(width: 16),
          _buildNewGameButton(context, loc),
          const SizedBox(width: 16),
          _buildScoreBox(title: loc.bestScore, score: state.bestScore, color: const Color(0xFF20E3B2)),
        ],
      ),
    );
  }

  Widget _buildScoreBox({required String title, required int score, required Color color}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withAlpha((0.15 * 255).round()),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withAlpha((0.3 * 255).round()), width: 2),
        ),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('$score', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildNewGameButton(BuildContext context, AppLocalizations loc) {
    return ElevatedButton(
      onPressed: () => context.read<GameCubit>().newGame(),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF20E3B2),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(loc.newGame, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  void _showHelpDialog(BuildContext context, AppLocalizations loc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  loc.howToPlay,
                  style: const TextStyle(
                    fontFamily: 'Exo2',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildHelpItem(icon: Icons.swipe, text: loc.helpSwipe),
                const Divider(color: Colors.white24),
                _buildHelpItem(icon: Icons.merge_type, text: loc.helpMerge),
                const Divider(color: Colors.white24),
                _buildHelpItem(icon: Icons.arrow_upward, text: loc.helpEvolve),
                const SizedBox(height: 16),
                _buildEvolutionExample(loc),
                const SizedBox(height: 24),
                _buildCloseButton(context, loc),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHelpItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF20E3B2), size: 28),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16))),
        ],
      ),
    );
  }

  Widget _buildEvolutionExample(AppLocalizations loc) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSmallTile('2', loc.prokaryote, const Color(0xFF9EDFFF)),
          const Icon(Icons.add, color: Colors.white),
          _buildSmallTile('2', loc.prokaryote, const Color(0xFF9EDFFF)),
          const Icon(Icons.arrow_forward, color: Colors.white),
          _buildSmallTile('4', loc.amoeba, const Color(0xFF7CD9F7)),
        ],
      ),
    );
  }

  Widget _buildSmallTile(String value, String label, Color color) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha((0.8 * 255).round()), width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: int.parse(value) <= 4 ? Colors.grey.shade800 : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: int.parse(value) <= 4 ? Colors.grey.shade800 : Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context, AppLocalizations loc) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF20E3B2),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: Text(loc.ok, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}
