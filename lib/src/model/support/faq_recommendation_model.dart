class FaqRecommendationsResponse {
  bool? success;
  FaqRecommendationModel? data;
  String? status;
  String? message;

  FaqRecommendationsResponse(
      {this.success, this.data, this.status, this.message});

  FaqRecommendationsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? FaqRecommendationModel.fromJson(json['data'])
        : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class FaqRecommendationModel {
  int? numberOfAnswers;
  String? question;
  List<FaqQuestionAnswers>? answers;

  FaqRecommendationModel({this.numberOfAnswers, this.question, this.answers});

  FaqRecommendationModel.fromJson(Map<String, dynamic> json) {
    numberOfAnswers = json['number_of_answers'];
    question = json['question'];
    if (json['answers'] != null) {
      answers = <FaqQuestionAnswers>[];
      json['answers'].forEach((v) {
        answers!.add(FaqQuestionAnswers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['number_of_answers'] = numberOfAnswers;
    data['question'] = question;
    if (answers != null) {
      data['answers'] = answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FaqQuestionAnswers {
  String? answer;
  String? title;
  String? gemId;
  int? cosineSimilarityScore;
  int? feedbackScore;
  double? score;

  FaqQuestionAnswers(
      {this.answer,
      this.title,
      this.gemId,
      this.cosineSimilarityScore,
      this.feedbackScore,
      this.score});

  FaqQuestionAnswers.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    title = json['title'];
    gemId = json['gemId'];
    cosineSimilarityScore = json['cosineSimilarityScore'];
    feedbackScore = json['feedbackScore'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['answer'] = answer;
    data['title'] = title;
    data['gemId'] = gemId;
    data['cosineSimilarityScore'] = cosineSimilarityScore;
    data['feedbackScore'] = feedbackScore;
    data['score'] = score;
    return data;
  }
}
