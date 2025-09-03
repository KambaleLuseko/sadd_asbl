import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Resources/Components/texts.dart';

class SocialLinkWidget extends StatelessWidget {
  const SocialLinkWidget(
      {super.key,
      required this.icon,
      this.iconColor = Colors.white,
      this.title = '',
      this.link = 'www.applicatoryx.org',
      this.showTitle = false,
      this.hideIcon = false,
      this.fontSize = 12});

  final IconData icon;
  final Color iconColor;
  final String link;
  final String title;
  final bool? showTitle, hideIcon;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (await canLaunchUrl(Uri.parse(link))) {
            await launchUrl(Uri.parse(link));
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hideIcon == false)
                Icon(
                  icon,
                  color: iconColor,
                  size: fontSize! + 6,
                ),
              if (showTitle == true && hideIcon == false)
                const SizedBox(
                  width: 8,
                ),
              if (showTitle == true)
                Expanded(
                    child: TextWidgets.text300(
                        title: title,
                        fontSize: fontSize!,
                        textColor: iconColor))
            ],
          ),
        ),
      ),
    );
  }
}
