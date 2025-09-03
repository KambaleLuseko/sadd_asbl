import 'package:flutter/material.dart';

import '../Constants/global_variables.dart';

class TrackingItemWidget extends StatelessWidget {
  const TrackingItemWidget({
    super.key,
    required this.child,
    this.isLast = true,
    this.backColor = Colors.black,
    this.stateColor = Colors.red,
  });
  final Widget child;
  final bool? isLast;
  final Color? backColor, stateColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: child,
            ),
          ),
          Positioned(
            left: 6,
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              height: double.maxFinite,
              color: AppColors.kWhiteColor,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: stateColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
