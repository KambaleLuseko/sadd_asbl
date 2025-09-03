class BlockModel {
  final String title;
  final List<String> fields;
  final Map data;
  String? type, blockFooter, subtitle;

  BlockModel(
      {required this.title,
      required this.fields,
      required this.data,
      this.type = 'row',
      this.blockFooter});
}

class ListBlockModel {
  final String title;
  final List<String> fields;
  final List<Map> data;
  String? blockFooter, subtitle;

  ListBlockModel(
      {required this.title,
      required this.fields,
      required this.data,
      this.blockFooter});

  static buildListHelper(
      {required List data, required List fields, required String title}) {
    try {
      return ListBlockModel(data: [
        if (data.isEmpty)
          ...List.generate(5, (index) {
            Map object = {};
            for (var i = 0; i < fields.length; i++) {
              object.addAll({fields[i].toString(): ''});
            }
            return object;
          }),
        if (data.isNotEmpty) ...data,
      ], fields: List<String>.from(fields), title: title);
    } catch (e) {
      return {};
    }
  }
}
