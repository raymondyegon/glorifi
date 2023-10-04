class CreditCardFAQResponse {
  CreditCardFAQResponse({
    required this.data,
  });
  late final FAQData data;

  CreditCardFAQResponse.fromJson(Map<String, dynamic> json) {
    data = FAQData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class FAQData {
  FAQData({
    required this.questions,
    required this.title,
    required this.description,
    required this.cardType
  });
  late final List<Questions> questions;
  late final String cardType;
  late final String description;
  late final String title;

  FAQData.fromJson(Map<String, dynamic> json) {
    questions =
        List.from(json['questions']).map((e) => Questions.fromJson(e)).toList();
    cardType = json['card_type'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['questions'] = questions.map((e) => e.toJson()).toList();
    _data['card_type'] = cardType;
    _data['description'] = description;
    _data['title'] = title;
    return _data;
  }
}

class Questions {
  Questions({
    required this.question,
    required this.answer,
  });
  late final String question;
  late final String answer;

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['question'] = question;
    _data['answer'] = answer;
    return _data;
  }
}
