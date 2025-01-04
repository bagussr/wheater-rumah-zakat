import 'package:flutter/material.dart';

AppBarTheme customAppBarTheme() {
  return AppBarTheme(
    backgroundColor: const Color(0xFF2196F3),
    titleTextStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    centerTitle: true,
  );
}
