import 'package:flutter/material.dart';

import '../../Resources/Constants/global_variables.dart';

class ModalProgress extends StatelessWidget {
  final Widget child;
  Color? progressColor = AppColors.kPrimaryColor;
  final bool isAsync;
  ModalProgress({
    super.key,
    required this.child,
    this.progressColor,
    required this.isAsync,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.kTransparentColor, body: child);
  }
}
