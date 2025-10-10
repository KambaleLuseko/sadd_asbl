import 'package:flutter/material.dart';

import '../../../Resources/Components/texts.dart';
import '../../../Resources/Constants/global_variables.dart';
import '../../../Resources/Constants/responsive.dart';
import '../../../Widgets/footer.widget.dart';

class MembersWidget extends StatelessWidget {
  const MembersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Column Widget...
        Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          TextWidgets.textBold(
              title: "Nos membres",
              fontSize: 32,
              textColor: AppColors.kWhiteColor),
          GridView(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isMobile(context)
                  ? 2
                  : Responsive.isTablet(context)
                      ? 3
                      : 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: Responsive.isWeb(context) ? 1.5 : 1,
            ),
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              ...List.generate(
                  members.length,
                  (index) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.kTextFormWhiteColor),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 80,
                                    height: 80,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.kWhiteColor),
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.kBlackColor,
                                      size: 56,
                                    )
                                    //  Image.network(
                                    //   'https://images.unsplash.com/photo-1659353219808-39d96fb9dc91?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHJhbmRvbXx8fHx8fHx8fDE3NTk4NTY1NjF8&ixlib=rb-4.1.0&q=80&w=1080',
                                    //   fit: BoxFit.cover,
                                    // ),
                                    ),
                                TextWidgets.textBold(
                                    title: members[index].name,
                                    maxLines: 2,
                                    align: TextAlign.center,
                                    fontSize: 18,
                                    textColor: AppColors.kWhiteColor),
                                TextWidgets.text300(
                                    title: members[index].role,
                                    fontSize: 14,
                                    maxLines: 2,
                                    align: TextAlign.center,
                                    textColor: AppColors.kWhiteDarkColor),
                                if (members[index].email != null &&
                                    members[index].email != '')
                                  TextWidgets.textWithIcon(
                                      title: members[index].email ?? '',
                                      fontSize: 14,
                                      textColor: AppColors.kWhiteDarkColor,
                                      icon: Icons.mail),
                                if (members[index].contact != null &&
                                    members[index].contact != '')
                                  TextWidgets.textWithIcon(
                                      title: members[index].contact ?? '',
                                      fontSize: 14,
                                      textColor: AppColors.kWhiteDarkColor,
                                      icon: Icons.call),
                              ]),
                        ),
                      ))
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          TextWidgets.textBold(
              title: "Les membres",
              fontSize: 24,
              textColor: AppColors.kWhiteColor),
          TextWidgets.text300(
              maxLines: 100,
              title: """
L’association est composée des membres fondateurs, effectifs, adhérant et d'honneur.

Est membre fondateur, toute personne physique, signataire des actes constitutifs de l’association;

Est membre effectif tout membre fondateur et adhérant en règle avec ses cotisations et respectant les statuts et Règlement d’Ordre Intérieur de SADD;

Est membre adhérant quiconque justifie de l’intérêt pour les objectifs de l’association et manifeste par lettre de demande d’adhésion, et en conséquence de quoi, elle accepte de se conformer aux présents statuts et le ROI de l’association ;

Est membre d’honneur, toute personne ne faisant pas partie de l’une des catégories des membres sus cités, mais qui lui apporte sa contribution de quelle que nature que ce soit ;

Est membre sympathisant, toute personne ne faisant pas partie de l’une ou l’autre catégorie des membres sus cités, mais qui s’intéresse aux activités de l’association.
""",
              fontSize: 14,
              textColor: AppColors.kWhiteColor),
          const SizedBox(
            height: 24,
          ),
          TextWidgets.textBold(
              title: "Adhesion",
              fontSize: 24,
              textColor: AppColors.kWhiteColor),
          TextWidgets.text300(
              maxLines: 100,
              title: """
Les conditions d’adhésion à la SADD asbl sont :

  1. Etre majeur,
  2. Adhérer aux différents principes directeurs de l’association en adressant une demande d’adhésion (écrite), au conseil d’administration de l’association,
  3. Verser les frais d’adhésion ;
  4. S’engager à verser régulièrement sa cotisation mensuelle ;
  5. Assister régulièrement aux réunions ;
  6. Acheter une carte de membre ;
Remplir et signer une fiche d’adhésion
La qualité de membre se perd par décès, démission volontaire, exclusion définitive faisant suite d’un comportement préjudiciant l’association""",
              fontSize: 14,
              textColor: AppColors.kWhiteColor),
          const SizedBox(
            height: 24,
          ),
          TextWidgets.textBold(
              title: "Ressources de la SADD asbl",
              fontSize: 24,
              textColor: AppColors.kWhiteColor),
          TextWidgets.text300(
              maxLines: 100,
              title: """
Les ressources de l’association proviennent de la cotisation des membres, de dons et legs ainsi que des subventions et financements tant internes qu’externes.

Les fonds de l’association sont placés dans des comptes bancaires ouverts au nom de l’association.""",
              fontSize: 14,
              textColor: AppColors.kWhiteColor),
          const SizedBox(
            height: 24,
          ),
          const FooterComponentWidget()
        ]);
  }
}

List<MemberModel> members = [
  MemberModel(
      name: "PALUKU KAMATHE Camille",
      role: "Président Conseil d’Administration",
      contact: '',
      email: '',
      image: ''),
  MemberModel(
    name: "Me NGONGO Ibrahim",
    role: "Vice-Président",
    contact: '',
    email: '',
    image: null,
  ),
  MemberModel(
    name: "Mme Rose NGOIE",
    role: "Coordinatrice",
    contact: '',
    email: '',
    image: null,
  ),
  MemberModel(
    name: "Mme Sarah LUSENGE KAMATHE",
    role: "Chargé de projets",
    contact: '',
    email: '',
    image: null,
  ),
  MemberModel(
    name: "Mr KALEGAMIRE Jean Marie",
    role: "Chef de départements droits et chargé de plaidoyer",
    contact: '',
    email: '',
    image: null,
  ),
  MemberModel(
    name: "Mme Antoinette KAVUO",
    role: "Secrétaire Coordination",
    contact: '',
    email: '',
    image: null,
  ),
  MemberModel(
    name: "Solange MATOPHALIE",
    role: "Secrétaire Bureau",
    contact: '',
    email: '',
    image: null,
  ),
  MemberModel(
    name: "Mme KATUNGU MWENGE",
    role: "Chargé de sensibilisation",
    contact: '',
    email: '',
    image: null,
  ),
  MemberModel(
    name: "Ir Kevin NGOIE",
    role: "Chargé de l’environnement et assainissement",
    contact: '',
    email: '',
    image: null,
  ),
  MemberModel(
    name: "Mr TUSSI Thierry",
    role: "Chargé des finances",
    contact: '',
    email: '',
    image: null,
  ),
];

class MemberModel {
  final String name, role;
  final String? email, contact;
  final String? image;
  MemberModel(
      {required this.name,
      required this.role,
      this.email,
      this.contact,
      this.image});
}
