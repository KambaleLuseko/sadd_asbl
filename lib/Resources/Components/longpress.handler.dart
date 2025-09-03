import 'package:flutter/material.dart';

import '../Constants/global_variables.dart';
import 'texts.dart';

class ContextualMenuHandlerWidget extends StatefulWidget {
  const ContextualMenuHandlerWidget({
    super.key,
    required this.child,
    required this.menus,
  });
  final Widget child;
  final List<ContextMenuModel> menus;
  @override
  State<ContextualMenuHandlerWidget> createState() =>
      _ContextualMenuHandlerWidgetState();
}

class _ContextualMenuHandlerWidgetState
    extends State<ContextualMenuHandlerWidget> {
  // Offset _tapPosition = Offset.zero;
  _showMenu(Offset position) async {
    final RenderObject? overlay = Overlay.of(
      context,
    ).context.findRenderObject();
    await showMenu(
      color: AppColors.kAccentColor,
      surfaceTintColor: AppColors.kAccentColor,
      elevation: 5,
      shadowColor: AppColors.kWhiteColor.withOpacity(1),
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(position.dx, position.dy, 10, 10),
        Rect.fromLTWH(
          0,
          0,
          overlay!.paintBounds.size.width,
          overlay.paintBounds.size.height,
        ),
      ),
      items: [
        ...List.generate(
          widget.menus.length,
          (index) => PopupMenuItem(
            enabled: widget.menus[index].isDisabled == true ? false : true,
            onTap: widget.menus[index].isDisabled == true
                ? null
                : () {
                    widget.menus[index].callback();
                  },
            child: TextWidgets.text300(
              title: widget.menus[index].title,
              fontSize: 14,
              textColor: widget.menus[index].isDangerAction == true
                  ? AppColors.kRedColor
                  : widget.menus[index].isDisabled == true
                  ? widget.menus[index].color?.withOpacity(0.5) ??
                        AppColors.kWhiteColor.withOpacity(0.5)
                  : widget.menus[index].color ?? AppColors.kWhiteColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (det) {
        _showMenu(det.globalPosition);
      },
      onSecondaryTap: null,
      onSecondaryTapDown: (det) {
        // print('longpress');
        _showMenu(det.globalPosition);
      },
      child: widget.child,
    );
  }
}

class ContextMenuModel {
  final String title;
  final Function callback;
  final bool? isDangerAction;
  final Color? color;
  final bool? isDisabled;
  ContextMenuModel({
    required this.title,
    required this.callback,
    this.isDangerAction = false,
    this.color,
    this.isDisabled = false,
  });
}
