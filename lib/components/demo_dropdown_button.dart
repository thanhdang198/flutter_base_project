import 'package:flutter/material.dart';

import '../constants/style.dart';

class DEMODropDownButton extends StatelessWidget {
  const DEMODropDownButton(
      {super.key,
      this.value,
      this.items,
      this.onChanged,
      this.hint,
      required this.title,
      this.padding});
  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final Function(Object?)? onChanged;
  final Widget? hint;
  final String? title;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getTitle(false),
          const SizedBox(height: 5),
          SizedBox(
            height: 50,
            child: DropdownButtonFormField(
              value: value,
              items: items,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: black50, width: 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              hint: hint ?? getTitle(true),
              isDense: true,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: priBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getTitle(bool isHint) {
    return title == null
        ? const SizedBox.shrink()
        : Text(
            (isHint ? 'Chọn ' : '') + title!,
            style: TextStyle(fontSize: 16, color: black50),
          );
  }
}
