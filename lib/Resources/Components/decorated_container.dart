import 'package:flutter/material.dart';

class DecoratedContainer extends StatelessWidget {
  final Color? backColor;
  final Widget child;

  const DecoratedContainer({
    super.key,
    this.backColor = Colors.grey,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(kDefaultPadding / 2),
        color: backColor!,
      ),
      child: child,
    );
  }
}
