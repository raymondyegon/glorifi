class FAQQuestions {

  String? title;
  String? gemId;
  String? detailedSection;
  String?  question;
  String? questionID;
  String? answer;

  FAQQuestions(this.title, this.gemId, this.detailedSection, this.question,
      this.questionID);

  FAQQuestions.fromJson(Map<String, dynamic> json) {

    title = json['_source'] != null ? json['_source']['title'] : '';
    gemId =  json['_source'] != null ? json['_source']['_id'] : '';
    question =  json['_source'] != null ? json['_source']['title'] : '';
    answer = json['_source'] != null ? json['_source']['detailedSection'] : '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['gemId'] = gemId;
    data['answer'] = answer;
    return data;
  }

  @override
  String toString() {
    return 'FAQQuestions{title: $title, question: $question, answer: $answer}';
  }
}