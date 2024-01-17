import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final Color? color;
  final TextStyle? titleStyle;
  final bool? isLoading;
  final double? buttonRadius;
  const AppButton({
    super.key,
    required this.onTap,
    required this.title,
    this.color,
    this.titleStyle,
    this.isLoading,
    this.buttonRadius,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      focusElevation: 0,
      onPressed: onTap,
      disabledColor: Colors.grey,
      color: color ?? AppColor.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonRadius ?? 8),
      ),
      child: isLoading ?? false
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                title,
                style: titleStyle ?? const TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
