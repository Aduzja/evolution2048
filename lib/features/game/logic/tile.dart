import 'package:evolution2048/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum TileType {
  prokaryote,
  amoeba,
  colony,
  jellyfish,
  fish,
  amphibian,
  reptile,
  mammal,
  primate,
  earlyHuman,
  modernHuman,
  empty,
}

class Tile {
  final int id;
  final int value;
  final int row;
  final int col;
  final bool merged;
  final bool isNew;

  Tile({
    required this.id,
    required this.value,
    required this.row,
    required this.col,
    this.merged = false,
    this.isNew = false,
  });

  TileType get type {
    switch (value) {
      case 2:
        return TileType.prokaryote;
      case 4:
        return TileType.amoeba;
      case 8:
        return TileType.colony;
      case 16:
        return TileType.jellyfish;
      case 32:
        return TileType.fish;
      case 64:
        return TileType.amphibian;
      case 128:
        return TileType.reptile;
      case 256:
        return TileType.mammal;
      case 512:
        return TileType.primate;
      case 1024:
        return TileType.earlyHuman;
      case 2048:
        return TileType.modernHuman;
      default:
        return TileType.empty;
    }
  }


String getTileDisplayName(BuildContext context, Tile tile) {
    final loc = AppLocalizations.of(context)!;
    switch (tile.type) {
      case TileType.prokaryote:
        return loc.prokaryote;
      case TileType.amoeba:
        return loc.amoeba;
      case TileType.colony:
        return loc.colony;
      case TileType.jellyfish:
        return loc.jellyfish;
      case TileType.fish:
        return loc.fish;
      case TileType.amphibian:
        return loc.amphibian;
      case TileType.reptile:
        return loc.reptile;
      case TileType.mammal:
        return loc.mammal;
      case TileType.primate:
        return loc.primate;
      case TileType.earlyHuman:
        return loc.earlyHuman;
      case TileType.modernHuman:
        return loc.modernHuman;
      default:
        return '';
    }
  }

  Color get baseColor {
    switch (type) {
      case TileType.prokaryote:
        return const Color(0xFF9EDFFF);
      case TileType.amoeba:
        return const Color(0xFF7CD9F7);
      case TileType.colony:
        return const Color(0xFF5BCCEF);
      case TileType.jellyfish:
        return const Color(0xFF42B9E5);
      case TileType.fish:
        return const Color(0xFF35A5D9);
      case TileType.amphibian:
        return const Color(0xFF2D92CC);
      case TileType.reptile:
        return const Color(0xFF1F80C2);
      case TileType.mammal:
        return const Color(0xFFAD8A64);
      case TileType.primate:
        return const Color(0xFFBD7B4F);
      case TileType.earlyHuman:
        return const Color(0xFFD48C3C);
      case TileType.modernHuman:
        return const Color(0xFFFFAA00);
      default:
        return Colors.transparent;
    }
  }

  Color get textColor {
    return (value <= 4) ? Colors.grey.shade800 : Colors.white;
  }

  String get pngAssetPath {
    switch (type) {
      case TileType.prokaryote:
        return 'assets/icons/prokaryote.png';
      case TileType.amoeba:
        return 'assets/icons/amoeba.png';
      case TileType.colony:
        return 'assets/icons/colony.png';
      case TileType.jellyfish:
        return 'assets/icons/jellyfish.png';
      case TileType.fish:
        return 'assets/icons/fish.png';
      case TileType.amphibian:
        return 'assets/icons/amphibian.png';
      case TileType.reptile:
        return 'assets/icons/reptile.png';
      case TileType.mammal:
        return 'assets/icons/mammal.png';
      case TileType.primate:
        return 'assets/icons/primate.png';
      case TileType.earlyHuman:
        return 'assets/icons/earlyHuman.png';
      case TileType.modernHuman:
        return 'assets/icons/modernHuman.png';
      default:
        return '';
    }
  }

  Tile copyWith({int? id, int? value, int? row, int? col, bool? merged, bool? isNew}) {
    return Tile(
      id: id ?? this.id,
      value: value ?? this.value,
      row: row ?? this.row,
      col: col ?? this.col,
      merged: merged ?? this.merged,
      isNew: isNew ?? this.isNew,
    );
  }

  @override
  String toString() {
    return 'Tile(value: $value, pos: [$row, $col], merged: $merged, new: $isNew)';
  }
}
