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

  String get displayName {
    switch (type) {
      case TileType.prokaryote:
        return "Prokariota";
      case TileType.amoeba:
        return "Ameba";
      case TileType.colony:
        return "Kolonia komórek";
      case TileType.jellyfish:
        return "Bezkręgowiec";
      case TileType.fish:
        return "Ryba";
      case TileType.amphibian:
        return "Płaz";
      case TileType.reptile:
        return "Gad";
      case TileType.mammal:
        return "Ssak";
      case TileType.primate:
        return "Małpa";
      case TileType.earlyHuman:
        return "Homo habilis";
      case TileType.modernHuman:
        return "Homo sapiens";
      default:
        return "";
    }
  }

  String get englishName {
    switch (type) {
      case TileType.prokaryote:
        return "Prokaryote";
      case TileType.amoeba:
        return "Amoeba";
      case TileType.colony:
        return "Multicellular Colony";
      case TileType.jellyfish:
        return "Jellyfish";
      case TileType.fish:
        return "Fish";
      case TileType.amphibian:
        return "Amphibian";
      case TileType.reptile:
        return "Reptile";
      case TileType.mammal:
        return "Mammal";
      case TileType.primate:
        return "Primate";
      case TileType.earlyHuman:
        return "Early Human";
      case TileType.modernHuman:
        return "Modern Human";
      default:
        return "";
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

  IconData get tileIcon {
    switch (type) {
      case TileType.prokaryote:
        return Icons.coronavirus_outlined;
      case TileType.amoeba:
        return Icons.blur_circular;
      case TileType.colony:
        return Icons.bubble_chart;
      case TileType.jellyfish:
        return Icons.waves;
      case TileType.fish:
        return Icons.water;
      case TileType.amphibian:
        return Icons.pets;
      case TileType.reptile:
        return Icons.architecture;
      case TileType.mammal:
        return Icons.mouse;
      case TileType.primate:
        return Icons.emoji_nature;
      case TileType.earlyHuman:
        return Icons.accessibility_new;
      case TileType.modernHuman:
        return Icons.person;
      default:
        return Icons.device_unknown;
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
