import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';
import '../../Widgets/footer.widget.dart';
import '../../Widgets/whyus.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 0, top: 32, right: 0, bottom: 32),
          child: WhyUsComponentWidget(),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 0, top: 32, right: 0, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    TextWidgets.textBold(
                      maxLines: 3,
                      align: TextAlign.center,
                      title: 'Témoignages de nos clients et partenaires',
                      fontSize: () {
                        if (Responsive.isMobile(context)) {
                          return 28.0;
                        } else if (Responsive.isTablet(context)) {
                          return 48.0;
                        } else {
                          return 48.0;
                        }
                      }(),
                      textColor: AppColors.kWhiteColor,
                    ),
                    const SizedBox(height: 32),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 16),
                              width: Responsive.isWeb(context) ? 600 : 500,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(
                                  color: const Color(0x56B0B0C0),
                                  width: 0.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  'https://cdn.prod.website-files.com/67010f4a68459a5989b19f0a/67010f4a68459a5989b19f5a_issues-p-800.webp',
                                  width: MediaQuery.sizeOf(context).width,
                                  height: 200,
                                  fit: BoxFit.cover,
                                  alignment: const Alignment(0, -1),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 0.5,
                decoration: const BoxDecoration(),
                child: TextWidgets.text300(
                  maxLines: 3,
                  align: TextAlign.center,
                  title:
                      'Chez nous, la collaboration est une vertue, l\'honnêteté un principe',
                  fontSize: () {
                    if (Responsive.isMobile(context)) {
                      return 24.0;
                    } else if (Responsive.isTablet(context)) {
                      return 24.0;
                    } else {
                      return 32.0;
                    }
                  }(),
                  textColor: AppColors.kWhiteColor,
                ),
              ),
              Container(
                width: double.infinity,
                height: 700,
                decoration: const BoxDecoration(),
                child: Flex(
                  direction: () {
                    if (Responsive.isMobile(context)) {
                      return false;
                    } else {
                      return true;
                    }
                  }()
                      ? Axis.horizontal
                      : Axis.vertical,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        height: 600,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.kPrimaryColor,
                              const Color(0x6704322C),
                            ],
                            stops: const [0, 1],
                            begin: const AlignmentDirectional(0, -1),
                            end: const AlignmentDirectional(0, 1),
                          ),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: const Color(0x59B0B0C0),
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidgets.textBold(
                                title: 'Nos clients',
                                fontSize: 24,
                                textColor: AppColors.kWhiteColor,
                              ),
                              TextWidgets.text300(
                                maxLines: 3,
                                align: TextAlign.left,
                                title:
                                    'Les clients ayant bénéficiés de nos services sont largement satisfaits et nous fournissent des pistes d\'amélioration',
                                fontSize: 16,
                                textColor: AppColors.kWhiteColor,
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://cdn.prod.website-files.com/67010f4a68459a5989b19f0a/67010f4a68459a5989b19f60_card-updates-p-1080.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 600,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.kPrimaryColor,
                              const Color(0x6704322C),
                            ],
                            stops: const [0, 1],
                            begin: const AlignmentDirectional(0, -1),
                            end: const AlignmentDirectional(0, 1),
                          ),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: const Color(0x59B0B0C0),
                            width: 0.5,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidgets.textBold(
                                title: 'Nos partenaires',
                                fontSize: 24,
                                textColor: AppColors.kWhiteColor,
                              ),
                              TextWidgets.text300(
                                maxLines: 3,
                                align: TextAlign.left,
                                title:
                                    'Nos partenaires locaux et internationaux s\'impliquent pour la grande mission de changement visant l\'autonomie des producteurs du café',
                                fontSize: 16,
                                textColor: AppColors.kWhiteColor,
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://cdn.prod.website-files.com/67010f4a68459a5989b19f0a/67010f4a68459a5989b19f5c_card-views-p-1080.webp',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const FooterComponentWidget(),
      ],
    );
  }
}
