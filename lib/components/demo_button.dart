import 'package:flutter/material.dart';

import '../constants/style.dart';

class DEMOButton extends StatelessWidget {
  const DEMOButton(
      {super.key,
      required this.child,
      required this.onPressed,
      this.isMaxWidth = true,
      this.height = 50});
  final Widget child;
  final VoidCallback onPressed;
  final bool isMaxWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: priBlue,
          shape: const StadiumBorder(side: BorderSide.none)),
      onPressed: onPressed,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisSize:
              isMaxWidth == true ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [child],
        ),
      ),
    );
  }
}
