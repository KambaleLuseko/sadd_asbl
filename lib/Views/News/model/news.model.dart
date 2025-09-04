class NewsModel {
  int? id;
  String? textes;
  String? auteur;
  String? image;
  String? image2;
  String? datePub;
  String? contenu;
  int? viewCount;

  NewsModel(
      {this.id,
      this.textes,
      this.auteur,
      this.image,
      this.image2,
      this.datePub,
      this.contenu,
      this.viewCount});

  NewsModel.fromJson(Map json) {
    id = int.tryParse(json['id'].toString());
    textes = json['textes'];
    auteur = json['auteur'];
    image = json['image'];
    image2 = json['image2'];
    datePub = json['date_pub'];
    contenu = json['contenu'];
    viewCount = int.tryParse(json['viewCount'].toString());
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
    data['viewCount'] = viewCount;
    data.removeWhere((key, value) => value == null || value.isEmpty);
    return data;
  }
}
