import 'package:flutter/material.dart';

class DEMOTextField extends StatelessWidget {
  const DEMOTextField({super.key, this.controller});
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
    );
  }
}
