import 'package:evolution2048/features/game/presentation/widgets/animated_button.dart';
import 'package:evolution2048/features/game/presentation/widgets/animated_logo.dart';
import 'package:evolution2048/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF101935), Color(0xFF090F1D)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(Icons.help_outline, color: Colors.white),
                  onPressed: () => _showHelpDialog(context, loc),
                  tooltip: loc.howToPlay,
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AnimatedLogoSection(),
                    const SizedBox(height: 80),
                    AnimatedPlayButton(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GameScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
