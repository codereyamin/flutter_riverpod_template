class FAQScreenDataModel {
  final bool isSelected;
  final String id;
  final String title;
  final String body;
  const FAQScreenDataModel({this.body = "", this.isSelected = false, this.title = "", this.id = ""});

  FAQScreenDataModel copyWith({String? title, String? body, bool? isSelected}) {
    return FAQScreenDataModel(body: body ?? this.body, title: title ?? this.title, isSelected: isSelected ?? this.isSelected);
  }

  factory FAQScreenDataModel.fromJson(dynamic json) {
    return FAQScreenDataModel(body: "${json["answer"] ?? ""}", isSelected: false, title: "${json["question"] ?? ""}", id: "${json["_id"]}");
  }
}
