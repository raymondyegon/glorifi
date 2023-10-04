class FAQSearchResult {
  String /*answer = '', */ title = '', gemID = '';
  late final List<String> tags;
  late final List<String> categories;

  FAQSearchResult(this.title, this.gemID);

  FAQSearchResult.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    gemID = json['id'];
    // tags = List.castFrom<dynamic, String>(json['tags']);
    // categories = List.castFrom<dynamic, String>(json['categories']);
    categories = ['???'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['id'] = gemID;
    // data['answer'] = answer;
    // data['tags'] = tags;
    // data['categories'] = categories;
    return data;
  }
}

class FaqHits {
  String? title;
  String? type;
  List<FaqSuggestions>? suggestions;

  FaqHits({this.title, this.type, this.suggestions});

  FaqHits.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    if (json['suggestions'] != null) {
      suggestions = <FaqSuggestions>[];
      json['suggestions'].forEach((v) {
        suggestions!.add(FaqSuggestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['type'] = type;
    if (suggestions != null) {
      data['suggestions'] = suggestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaqSuggestions {
  String? id;
  String? text;

  FaqSuggestions({this.id, this.text});

  FaqSuggestions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['text'] = text;
    return data;
  }
}
