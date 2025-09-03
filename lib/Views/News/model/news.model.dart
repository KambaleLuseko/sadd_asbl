class NewsModel {
  String? id;
  String? textes;
  String? auteur;
  String? image;
  String? image2;
  String? datePub;
  String? contenu;

  NewsModel(
      {this.id,
      this.textes,
      this.auteur,
      this.image,
      this.image2,
      this.datePub,
      this.contenu});

  NewsModel.fromJson(Map json) {
    id = json['id'];
    textes = json['textes'];
    auteur = json['auteur'];
    image = json['image'];
    image2 = json['image2'];
    datePub = json['date_pub'];
    contenu = json['contenu'];
  }

  Map toJson() {
    final Map data = {};
    data['id'] = id;
    data['textes'] = textes;
    data['auteur'] = auteur;
    data['image'] = image;
    data['image2'] = image2;
    data['date_pub'] = datePub;
    data['contenu'] = contenu;
    data.removeWhere((key, value) => value == null || value.isEmpty);
    return data;
  }
}
