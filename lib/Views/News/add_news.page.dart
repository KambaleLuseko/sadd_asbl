import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sadd_asbl/Resources/Components/button.dart';
import 'package:sadd_asbl/Resources/Components/text_fields.dart';
import 'package:sadd_asbl/Resources/Components/texts.dart';
import 'package:sadd_asbl/Resources/Constants/global_variables.dart';
import 'package:sadd_asbl/Views/News/controller/news.provider.dart';
import 'package:sadd_asbl/Views/News/model/news.model.dart';

class PublicationForm extends StatefulWidget {
  const PublicationForm({super.key});

  @override
  _PublicationFormState createState() => _PublicationFormState();
}

class _PublicationFormState extends State<PublicationForm> {
  // Clé globale pour le formulaire
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs de texte
  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _auteurController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();

  String? _imagePath;
  String? _image2Path;

  // Fonction de soumission du formulaire
  void _submitForm() {
    // Vérifie si la validation est passée
    if (_formKey.currentState!.validate()) {
      // Vérifie si une date a été sélectionnée

      // Les données sont cohérentes, on peut les envoyer au backend
      final Map<String, dynamic> data = {
        'textes': _titreController.text,
        'auteur': _auteurController.text,
        'image': _imagePath,
        'image2': _image2Path,
        'contenu': _contenuController.text,
      };

      // print('Données du formulaire prêtes à être envoyées:');
      context.read<NewsProvider>().save(
          data: NewsModel.fromJson(data),
          callback: () {
            Navigator.pop(context);
          });
      // Ici, vous pouvez appeler votre service API pour envoyer les données
    }
  }

  Future<void> pickImage({required Function(String) callback}) async {
    // Use file_picker or a similar package for production
    // This is a simple HTML input for demonstration on web
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final html.File file = uploadInput.files!.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((e) {
        String base64String = reader.result.toString().split(',').last;
        callback(base64String);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextWidgets.textBold(
                title: "Nouvelle publication",
                fontSize: 22,
                textColor: AppColors.kWhiteColor),
            TextFormFieldWidget(
              hintText: 'Titre',
              textColor: AppColors.kWhiteColor,
              backColor: AppColors.kTextFormWhiteColor,
              editCtrller: _titreController,
            ),

            const SizedBox(height: 20),

            // Champ pour l'auteur
            TextFormFieldWidget(
              editCtrller: _auteurController,
              hintText: 'Auteur',
              backColor: AppColors.kTextFormWhiteColor,
              textColor: AppColors.kWhiteColor,
            ),
            const SizedBox(height: 20),

            // Boutons pour les images (simulés)
            TextWidgets.textBold(
              title: 'Sélectionner des images',
              fontSize: 16,
              textColor: AppColors.kWhiteColor,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Logique de sélection d'image à implémenter ici
                    pickImage(callback: (value) {
                      _imagePath = value;
                      setState(() {});
                    });
                  },
                  child: const Text('Image 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    pickImage(callback: (value) {
                      _image2Path = value;
                      setState(() {});
                    });
                  },
                  child: const Text('Image 2'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Champ pour le contenu
            TextFormFieldWidget(
              maxLines: 5,
              hintText: 'Contenu',
              textColor: AppColors.kWhiteColor,
              backColor: AppColors.kTextFormWhiteColor,
              editCtrller: _contenuController,
            ),
            Center(
              child: CustomButton(
                  canSync: true,
                  text: "Enregistrer",
                  backColor: AppColors.kSecondaryColor,
                  textColor: AppColors.kWhiteColor,
                  callback: () {
                    _submitForm();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
