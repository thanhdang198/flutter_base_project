import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/style.dart';

class DEMOAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final List<Widget>? actions;
  final Widget? leading;
  final Function()? onBackPressed;
  const DEMOAppBar({
    super.key,
    this.actions,
    required this.title,
    this.height = kToolbarHeight,
    this.leading,
    this.onBackPressed,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: priBlue,
      shadowColor: Colors.transparent,
      // systemOverlayStyle:
      //     SystemUiOverlayStyle(statusBarColor: priBlue),
      actions: actions,
      title: Text(title),
      leading: leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: onBackPressed ??
                () => Navigator.of(context, rootNavigator: true).pop(),
          ),
    );
  }
}
