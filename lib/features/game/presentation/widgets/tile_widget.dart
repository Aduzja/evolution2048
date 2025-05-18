import 'dart:math' as math;
import 'package:evolution2048/features/game/logic/tile.dart';
import 'package:evolution2048/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TileWidget extends StatefulWidget {
  final Tile? tile;
  final double size;

  const TileWidget({super.key, required this.tile, required this.size});

  @override
  State<TileWidget> createState() => _TileWidgetState();
}

class _TileWidgetState extends State<TileWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    _scaleAnimation = Tween<double>(
      begin: widget.tile?.isNew ?? false ? 0 : 1,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    _opacityAnimation = Tween<double>(
      begin: widget.tile?.isNew ?? false ? 0 : 1,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuad));

    _controller.forward();
  }

  @override
  void didUpdateWidget(TileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.tile != null && (oldWidget.tile == null || widget.tile!.value != oldWidget.tile!.value)) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tile == null) {
      return EmptyTile(size: widget.size);
    }

    final loc = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(opacity: _opacityAnimation.value, child: child),
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.tile!.baseColor,
          boxShadow: [
            BoxShadow(
              color: widget.tile!.baseColor.withAlpha((0.3 * 255).round()),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: widget.tile!.baseColor.withAlpha((0.8 * 255).round()), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.tile!.tileIcon, size: math.min(widget.size * 0.35, 24), color: widget.tile!.textColor),
            const SizedBox(height: 4),
            Text(
              '${widget.tile!.value}',
              style: TextStyle(
                color: widget.tile!.textColor,
                fontSize: getAdaptiveFontSize(widget.tile!.value, widget.size),
                fontWeight: FontWeight.bold,
              ),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _getTileDisplayName(context, widget.tile!, loc),
                style: TextStyle(
                  color: widget.tile!.textColor,
                  fontSize: math.max(widget.size * 0.12, 10),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTileDisplayName(BuildContext context, Tile tile, AppLocalizations loc) {
    switch (tile.value) {
      case 2:
        return loc.prokaryote;
      case 4:
        return loc.amoeba;
      case 32:
        return loc.fish;
      case 256:
        return loc.mammal;
      case 2048:
        return loc.human;
      default:
        return tile.displayName;
    }
  }

  double getAdaptiveFontSize(int value, double tileSize) {
    final digitCount = value.toString().length;
    final baseFontSize = tileSize * 0.22;

    if (digitCount <= 2) {
      return baseFontSize;
    } else if (digitCount == 3) {
      return baseFontSize * 0.85;
    } else {
      return baseFontSize * 0.7;
    }
  }
}

class EmptyTile extends StatelessWidget {
  final double size;

  const EmptyTile({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade800.withAlpha((0.2 * 255).round()),
      ),
    );
  }
}
