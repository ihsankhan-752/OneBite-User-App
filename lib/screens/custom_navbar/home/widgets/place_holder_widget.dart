import 'package:flutter/material.dart';

Widget placeHolderWidget() {
  return Container(
    width: 75,
    height: 75,
    decoration: BoxDecoration(
      color: const Color(0xFF2A2A2A),
      borderRadius: BorderRadius.circular(10),
    ),
    child: const Icon(Icons.fastfood, color: Colors.white24, size: 30),
  );
}
