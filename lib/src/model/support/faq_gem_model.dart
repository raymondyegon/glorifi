class GemModel {
  List<Hits>? hits;

  GemModel({this.hits});

  GemModel.fromJson(Map<String, dynamic> json) {
    if (json['hits'] != null) {
      hits = <Hits>[];
      json['hits'].forEach((v) {
        hits!.add(Hits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    if (hits != null) {
      data['hits'] = hits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hits {
  String? sId;
  String? title, answer;
  List<String>? libraryIds;

  Hits({this.sId});

  Hits.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['_source'] != null) {
      libraryIds = json['_source']['libraryIds'].cast<String>();
    }
    title = json['_source']['title'];
    answer = json['_source']['detailedSection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    return data;
  }
}
