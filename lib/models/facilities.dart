import 'package:flutter/material.dart';

class Facilities {
  final String id;
  final String name;
  final String iconPath;  // ✅ SVG path
  final List<String> facilities;
  bool isExpanded;

  Facilities({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.facilities,
    this.isExpanded = false,
  });
}