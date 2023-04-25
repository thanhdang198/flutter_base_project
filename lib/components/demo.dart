import 'package:flutter/material.dart';

class DEMOSnackBar extends SnackBar {
  const DEMOSnackBar({
    super.key,
    required this.content,
  }) : super(
            content: content,
            elevation: 0,
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.transparent);
  final Widget content;
}
