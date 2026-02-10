import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SnackType { success, error, neutral }

class AppSnackbar {
  static void show(
    String title,
    String message, {
    SnackType type = SnackType.neutral,
    SnackPosition position = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colors = _resolveColors(type);

    Get.snackbar(
      title,
      message,
      snackPosition: position,
      duration: duration,
      backgroundColor: colors.background,
      colorText: colors.text,
      margin: const EdgeInsets.all(12),
      borderRadius: 12,
    );
  }

  static _SnackColors _resolveColors(SnackType type) {
    switch (type) {
      case SnackType.error:
        return const _SnackColors(background: Colors.red, text: Colors.white);
      case SnackType.success:
        return const _SnackColors(background: Colors.green, text: Colors.white);
      case SnackType.neutral:
      default:
        return const _SnackColors(background: Colors.white, text: Colors.black);
    }
  }
}

class _SnackColors {
  const _SnackColors({required this.background, required this.text});

  final Color background;
  final Color text;
}
