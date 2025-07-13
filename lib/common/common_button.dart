import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onSubmit,
    this.isLoading,
    required this.bgColor,
    required this.child,
    this.loadingColor = Colors.white,
    this.width = 265,
    this.height = 44,
    this.disabledBgColor,
    this.border,
  });

  final void Function()? onSubmit;

  final bool? isLoading;

  final Color bgColor;

  final Widget child;

  final Color? loadingColor;

  final double? width;

  final double? height;

  final Color? disabledBgColor;
  final Border? border;

  factory CommonButton.square({
    required Color bgColor,
    required void Function()? onSubmit,
    required Widget child,
    bool? isLoading,
    double? dimension,
  }) {
    return CommonButton(
      width: dimension ?? 39,
      height: dimension ?? 42,
      isLoading: isLoading,
      onSubmit: onSubmit,
      bgColor: bgColor,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSubmit,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
          border: border,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: child),
        ),
      ),
    );
  }
}
