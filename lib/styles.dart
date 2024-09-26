import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFFFFFF);
const Color secondaryColor = Color(0xFFEC7513);
const Color textPrimary = Color(0xFF303030);
const Color textSecondary = Color(0xFF2F4F4F);

final TextTheme myTextTheme = TextTheme(
  bodyLarge: TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Dortmund'
  ),
  bodyMedium: TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Dortmund'
  ),
  bodySmall: TextStyle(
    fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Dortmund'
  ),
  labelLarge: TextStyle(
    fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Dortmund'
  ),
  labelMedium: TextStyle(
    fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'NanumSquareNeo'
  ),
  labelSmall: TextStyle(
    fontSize: 12, fontWeight: FontWeight.w300, fontFamily: 'NanumSquareNeo'
  ),
);