import 'package:flutter/material.dart';

import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';
import '../../Widgets/footer.widget.dart';

class AboutPageWidget extends StatefulWidget {
  const AboutPageWidget({super.key});

  static String routeName = 'AboutPage';
  static String routePath = '/aboutPage';

  @override
  State<AboutPageWidget> createState() => _AboutPageWidgetState();
}

class _AboutPageWidgetState extends State<AboutPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 100),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flex(
                direction: () {
                  if (Responsive.isMobile(context)) {
                    return false;
                  } else {
                    return true;
                  }
                }()
                    ? Axis.horizontal
                    : Axis.vertical,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    fit: Responsive.isMobile(context)
                        ? FlexFit.loose
                        : FlexFit.tight,
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            0,
                            (() {
                              if (Responsive.isMobile(context)) {
                                return 0.0;
                              } else {
                                return 32.0;
                              }
                            }()),
                            0),
                        child: TextWidgets.textBold(
                          maxLines: 2,
                          title: 'Qui sommes-nous ?',
                          fontSize: 48,
                          textColor: AppColors.kWhiteColor,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    fit: Responsive.isMobile(context)
                        ? FlexFit.loose
                        : FlexFit.tight,
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Opacity(
                        opacity: 0.8,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            (() {
                              if (Responsive.isMobile(context)) {
                                return 0.0;
                              } else {
                                return 32.0;
                              }
                            }()),
                            0,
                            0,
                            0,
                          ),
                          child: TextWidgets.text300(
                            maxLines: 24,
                            align: TextAlign.justify,
                            title:
                                "La sadd ASBL en sigle solidaire Action pour le Droit et le développement a été créée le 19/09/2010 à Goma conformément à la loi n°004/20 juillet 2001, disposition générales applicables aux ASBL.\n\nSIEGE\nLe siège social de la SADD Asbl est établi à Goma en République Démocratique du Congo sur l’avenue Kinshasa n°14, Quartier Kyeshero commune de Goma dans la Province du nord Kivu",
                            fontSize: 16,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 32, 0, 0),
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: Responsive.isMobile(context)
                          ? FlexFit.loose
                          : FlexFit.tight,
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Opacity(
                          opacity: 0.8,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              0,
                              0,
                              (() {
                                if (Responsive.isMobile(context)) {
                                  return 0.0;
                                } else {
                                  return 32.0;
                                }
                              }()),
                              0,
                            ),
                            child: TextWidgets.text300(
                              align: TextAlign.justify,
                              maxLines: 12000,
                              title: """
La question du droit et du développement étant de nos jours incontournable pour l’amélioration des conditions des vies des population vivant dans une très grande promiscuité et subissant une violation excessives des droits humains, pour essayer tant soit peu à rehausser le niveau de vie de ces personnes vulnérables et à plaider leur cause, monsieur Camille PALUKU KAMATHE riche de son expérience à la communauté économique européenne (CEE) pendant qu’il y exerçait ses fonctions et de son expertise de consultant dans des organisations non gouvernementales internationales et Madame Sarah LUSENGE KAMATHE de son expérience de juriste, journaliste, défenseurs des droits humains au sein de L’organisation non gouvernementale femmes juristes pour les droits de la femme où elle assurait la coordination en ville de Béni financé par le haut commissariat des nations unies aux droits de l’homme, la coopération suisse à travers la synergie pour les victimes de violences sexuelles ; en collaboration avec divers partenaires, sur leur initiatives et celui de juristes en collaboration avec les économistes, médecins, sociologues, techniciens de développement rural et tout les autres chercheurs soucieuse de réunir autour d’elle tous les fils du pays afin de réfléchir sur les conditions sociales, environnementales, la situation des droits humains et du développement en général.\n
Conscient que la RDC, notre pays ne peut être prospère, stable et pacifique dans une situation critique ;
\nConvaincu que l’insécurité, la guerre, les violations des droits humains, les conflits interethniques… ne peuvent contribuer au développement durable et à la protection des citoyens ;\n
Animés par l’esprit patriotique de participer à la reconstruction de notre pays et au bien être du congolais et de la congolaise ;\n
Considérant que les violations des droits humains sont à l’origine de la régression du développement,\n
Entendu que la République Démocratique du Congo est un grand pays au cœur de l’Afrique ;\n
Eu égard au fait de la Solidaire Action pour le droit et le Développement asbl est une volonté humaine et sociale, émanant de juristes, des économistes, des agronomes, des médecins, des techniciens de développement rural, des gestionnaires… elle en appelle aux personnes physiques et morales qui veulent s’allier à ses objectifs de s’associer pour constituer une base homogène afin de contribuer au développement et au respect des droits humains, tant au niveau local, provincial, national qu’international,\n
Réuni par cette pertinence et cette opportunité avons créé l’Asbl SADD « Solidaire Action pour le Droit et le développement »
""",
                              fontSize: 16,
                              textColor: AppColors.kWhiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: Responsive.isMobile(context)
                          ? FlexFit.loose
                          : FlexFit.tight,
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                            (() {
                              if (Responsive.isMobile(context)) {
                                return 0.0;
                              } else {
                                return 32.0;
                              }
                            }()),
                            0,
                            (() {
                              if (Responsive.isMobile(context)) {
                                return 0.0;
                              } else {
                                return 32.0;
                              }
                            }()),
                            0,
                          ),
                          child: TextWidgets.textBold(
                            title: 'HISTORIQUE',
                            fontSize: 32,
                            textColor: AppColors.kWhiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Container(
              //   decoration: const BoxDecoration(),
              //   child: Flex(
              //     direction: () {
              //       if (Responsive.isMobile(context)) {
              //         return false;
              //       } else {
              //         return true;
              //       }
              //     }()
              //         ? Axis.horizontal
              //         : Axis.vertical,
              //     mainAxisSize: MainAxisSize.min,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Flexible(
              //         fit: Responsive.isMobile(context)
              //             ? FlexFit.loose
              //             : FlexFit.tight,
              //         child: Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(
              //               0,
              //               0,
              //               (() {
              //                 if (Responsive.isMobile(context)) {
              //                   return 0.0;
              //                 } else {
              //                   return 16.0;
              //                 }
              //               }()),
              //               0),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Padding(
              //                 padding: const EdgeInsetsDirectional.fromSTEB(
              //                   0,
              //                   0,
              //                   0,
              //                   32,
              //                 ),
              //                 child: TextWidgets.textBold(
              //                   maxLines: 3,
              //                   title: 'IMPACT SOCIAL DE NOS ACTIONS',
              //                   fontSize: 32,
              //                   textColor: AppColors.kWhiteColor,
              //                 ),
              //               ),
              //               TextWidgets.text300(
              //                 maxLines: 10,
              //                 title:
              //                     'La CPNCK assure la réinsertion socio-économique des ex-combattants et des femmes vulnérables dans la filière café. \n\nAu niveau des sections de lavage de café, les jeunes et femmes sont impliqués dans les travaux de traitement de café. \n\nAu niveau de l\'usine il ya diverses activités \nrémunératrices occupant un nombre \nconsidérable des femmes et jeunes. \n\nLe triage du café-vert est presque l\'apanage des femmes qui gonflent le revenu de leurs familles moyennant ce qu\'elles gagnent.\n\nQuant aux jeunes, ceux-ci disposent dune force physique, ainsi ils interviennent comme des journaliers attachés aux travaux lourds. \n',
              //                 fontSize: 16,
              //                 textColor: AppColors.kWhiteColor,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Flexible(
              //         fit: Responsive.isMobile(context)
              //             ? FlexFit.loose
              //             : FlexFit.tight,
              //         child: Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(
              //             (() {
              //               if (Responsive.isMobile(context)) {
              //                 return 0.0;
              //               } else {
              //                 return 16.0;
              //               }
              //             }()),
              //             0,
              //             0,
              //             0,
              //           ),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             children: [
              //               ClipRRect(
              //                 borderRadius: BorderRadius.circular(8),
              //                 child: Image.asset(
              //                   'Assets/Images/militaty_forest.jpg',
              //                   width: MediaQuery.sizeOf(context).width,
              //                   height: 350,
              //                   fit: BoxFit.cover,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const ChartWidgetWidget(),
            ],
          ),
        ),
        const FooterComponentWidget(),
      ],
    );
  }
}
