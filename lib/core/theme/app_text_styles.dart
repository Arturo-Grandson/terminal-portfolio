import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle terminalText = TextStyle(
    color: AppColors.textPrimary,
    fontFamily: 'monospace',
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle terminalPrompt = TextStyle(
    color: AppColors.textSecondary,
    fontFamily: 'monospace',
    fontSize: 14,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle terminalTitle = TextStyle(
    color: AppColors.textSecondary,
    fontFamily: 'monospace',
    fontSize: 14,
  );
}
