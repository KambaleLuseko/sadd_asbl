import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Resources/Components/texts.dart';
import '../Resources/Constants/global_variables.dart';
import '../Resources/Constants/responsive.dart';
import '../main.dart';
import 'social_link.widget.dart';

class FooterComponentWidget extends StatefulWidget {
  const FooterComponentWidget({super.key});

  @override
  State<FooterComponentWidget> createState() => _FooterComponentWidgetState();
}

class _FooterComponentWidgetState extends State<FooterComponentWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.kTransparentColor),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 32),
      child: Column(
        children: [
          const Row(),
          LayoutBuilder(
            builder: (context, constraints) {
              double width = Responsive.isMobile(context)
                  ? constraints.maxWidth - 24
                  : Responsive.isTablet(context)
                      ? constraints.maxWidth / 3 - 16
                      : constraints.maxWidth / 3 - 16;
              return Wrap(
                direction: Axis.horizontal,
                runSpacing: 24,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  FooterItemWidget(
                    width: width,
                    title: appName,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidgets.text300(
                          title:
                              "La SADD asbl fait partie des grandes organisations de droit et de développement en faveur de la population congolaise en général.\nSoutenir nos actions avec des dons réguliers ou ponctuels, c'est aider les vulnérables et démunis à retrouver leurs droits.",
                          maxLines: 10,
                          fontSize: 14,
                          textColor: AppColors.kWhiteColor,
                        ),
                      ],
                    ),
                  ),
                  FooterItemWidget(
                    width: width,
                    title: "Liens utiles",
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SocialLinkWidget(
                          icon: FontAwesomeIcons.facebook,
                          // iconColor: Colors.blue,
                          link: 'https://www.facebook.com/',
                          showTitle: true,
                          title: "Facebook",
                        ),
                        SizedBox(height: 8),
                        SocialLinkWidget(
                          icon: FontAwesomeIcons.youtube,
                          // iconColor: Colors.red,
                          link: 'https://www.youtube.com/@saddasbl1190',
                          showTitle: true,
                          title: "Youtube",
                        ),
                        SizedBox(height: 8),
                        SocialLinkWidget(
                          // iconColor: Colors.blueAccent,
                          icon: FontAwesomeIcons.instagram,
                          link: 'https://www.instagram.com/',
                          showTitle: true,
                          title: "Instagram",
                        ),
                      ],
                    ),
                  ),
                  FooterItemWidget(
                    title: "Nous contacter",
                    width: width,
                    content: const Column(
                      children: [
                        SocialLinkWidget(
                          icon: Icons.location_on_rounded,

                          // iconColor: Colors.red,
                          showTitle: true,
                          title: "Goma, Nord-Kivu, RDC",
                        ),
                        SizedBox(height: 8),
                        SocialLinkWidget(
                          // iconColor: Colors.blueAccent,
                          icon: Icons.call,
                          link: 'tel:+243 995 413 819',
                          showTitle: true,
                          title: "+243 995 413 819",
                        ),
                        SizedBox(height: 8),
                        SocialLinkWidget(
                          // iconColor: Colors.blueAccent,
                          icon: Icons.call,
                          link: 'tel:+243 853 580 738',
                          showTitle: true,
                          title: "+243 853 580 738",
                        ),
                        SizedBox(height: 8),
                        SocialLinkWidget(
                          // iconColor: Colors.blueAccent,
                          icon: Icons.mail_outline_rounded,
                          link: 'mail:info@saddasbl.org',
                          showTitle: true,
                          title: "info@saddasbl.org",
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class FooterItemWidget extends StatelessWidget {
  const FooterItemWidget({
    super.key,
    required this.title,
    required this.content,
    this.titleColor = Colors.white,
    this.width = 200,
  });
  final String title;
  final Widget content;
  final Color? titleColor;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidgets.textBold(
            title: title,
            fontSize: 24,
            textColor: titleColor!,
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}
