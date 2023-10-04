class UpdateHandlerModel {
  UpdateHandlerModel({
    required this.success,
    required this.data,
    required this.status,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String status;
  late final String message;

  UpdateHandlerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['status'] = status;
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.mandatory,
    required this.optional,
  });
  Mandatory? mandatory;
  Optional? optional;

  Data.fromJson(Map<String, dynamic> json) {
    mandatory = json['mandatory'] != null
        ? Mandatory.fromJson(json['mandatory'])
        : null;
    optional =
        json['optional'] != null ? Optional.fromJson(json['optional']) : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mandatory'] = mandatory?.toJson();
    _data['optional'] = optional?.toJson();
    return _data;
  }
}

class Mandatory {
  Mandatory({
    required this.version,
    required this.releaseDate,
  });
  late final String version;
  late final String releaseDate;

  Mandatory.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    releaseDate = json['releaseDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['version'] = version;
    _data['releaseDate'] = releaseDate;
    return _data;
  }
}

class Optional {
  Optional({
    required this.version,
    required this.releaseDate,
  });
  late final String version;
  late final String releaseDate;

  Optional.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    releaseDate = json['releaseDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['version'] = version;
    _data['releaseDate'] = releaseDate;
    return _data;
  }
}
