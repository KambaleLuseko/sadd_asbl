import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'texts.dart';

class EmptyModel extends StatelessWidget {
  final Color color;
  final String? text;

  const EmptyModel({
    super.key,
    required this.color,
    this.text = "Aucune donnée trouvée",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete_outline_rounded, size: 40, color: color),
          const SizedBox(height: 20),
          TextWidgets.text300(
            title: "status.no-data".tr(),
            fontSize: 14,
            maxLines: 2,
            textColor: color,
          ),
        ],
      ),
    );
  }
}
