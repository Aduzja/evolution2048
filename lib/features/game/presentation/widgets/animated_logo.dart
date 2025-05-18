
import 'package:evolution2048/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedLogoSection extends StatefulWidget {
  const AnimatedLogoSection({super.key});

  @override
  State<AnimatedLogoSection> createState() => _AnimatedLogoSectionState();
}

class _AnimatedLogoSectionState extends State<AnimatedLogoSection> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeInAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.0, 0.7, curve: Curves.easeOut)));
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: const Interval(0.3, 1.0, curve: Curves.elasticOut)));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeInAnimation.value,
          child: Transform.scale(scale: _scaleAnimation.value, child: child),
        );
      },
      child: Column(
        children: [
          Text(
            loc.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.exo2(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF20E3B2),
              letterSpacing: 2.0,
              shadows: [
                Shadow(
                  offset: const Offset(2, 2),
                  blurRadius: 10.0,
                  color: Colors.black.withAlpha((0.8 * 255).round()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            loc.subtitle,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.white.withAlpha((0.8 * 255).round()),
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
