import 'package:flutter/material.dart';
import 'package:metatube/utils/app_styles.dart';

class SnackbarUtils {
  static void showSnackbar(
    BuildContext context,
    IconData icon,
    String message,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.accent,
          ),
          SizedBox(
            width: 8,
          ),
          Text(message)
        ],
      ),
    ));
  }
}
