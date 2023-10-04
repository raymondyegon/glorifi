import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/horizontal_bar/horizontal_series.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/types/pie_chart/slice.dart';

class Insight {
  List<InsightsModel>? insights;
  int? numberOfInsights;
  int? unreadMessages;
  int? numberOfUnreadInsights;
  bool? ok;
  String? protocolVersion;
  String? statusMessage;
  String? status;
  String? requestType;
  String? requestId;
  String? requestChannel;

  Insight(
      {this.insights,
      this.numberOfInsights,
      this.unreadMessages,
      this.numberOfUnreadInsights,
      this.ok,
      this.protocolVersion,
      this.statusMessage,
      this.status,
      this.requestType,
      this.requestId,
      this.requestChannel});

  Insight.fromJson(Map<String, dynamic> json) {
    if (json['insights'] != null) {
      insights = <InsightsModel>[];
      json['insights'].forEach((v) {
        insights!.add(InsightsModel.fromJson(v));
      });
    }
    numberOfInsights = json['numberOfInsights'];
    unreadMessages = json['unreadMessages'];
    numberOfUnreadInsights = json['numberOfUnreadInsights'];
    ok = json['ok'];
    protocolVersion = json['protocolVersion'];
    statusMessage = json['statusMessage'];
    status = json['status'];
    requestType = json['requestType'];
    requestId = json['requestId'];
    requestChannel = json['requestChannel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (insights != null) {
      data['insights'] = insights!.map((v) => v.toJson()).toList();
    }
    data['numberOfInsights'] = numberOfInsights;
    data['unreadMessages'] = unreadMessages;
    data['numberOfUnreadInsights'] = numberOfUnreadInsights;
    data['ok'] = ok;
    data['protocolVersion'] = protocolVersion;
    data['statusMessage'] = statusMessage;
    data['status'] = status;
    data['requestType'] = requestType;
    data['requestId'] = requestId;
    data['requestChannel'] = requestChannel;
    return data;
  }
}

class InsightsModel {
  String? id;
  String? insightId;
  String? useCaseId;
  String? segment;
  String? businessId;
  String? lineOfBusiness;
  String? generatedDate;
  String? presentedDate;
  String? selectedDate;
  double? score;
  String? category1;
  String? category2;
  String? category3;
  String? insightType;
  String? status;
  String? type;
  bool? highlighted;
  String? teaserTemplate;
  String? userTag;
  List<TeaserBlocks>? teaserBlocks;
  List<Actions>? actions;

  InsightsModel(
      {this.id,
      this.insightId,
      this.useCaseId,
      this.segment,
      this.businessId,
      this.lineOfBusiness,
      this.generatedDate,
      this.presentedDate,
      this.selectedDate,
      this.score,
      this.category1,
      this.category2,
      this.category3,
      this.insightType,
      this.status,
      this.type,
      this.highlighted,
      this.teaserTemplate,
      this.userTag,
      this.teaserBlocks,
      this.actions});

  InsightsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    insightId = json['insightId'];
    useCaseId = json['useCaseId'];
    segment = json['segment'];
    businessId = json['businessId'];
    lineOfBusiness = json['lineOfBusiness'];
    generatedDate = json['generatedDate'];
    presentedDate = json['presentedDate'];
    selectedDate = json['selectedDate'];
    score = json['score'];
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    insightType = json['insightType'];
    status = json['status'];
    type = json['type'];
    highlighted = json['highlighted'];
    teaserTemplate = json['teaserTemplate'];
    userTag = json['userTag'];
    if (json['teaserBlocks'] != null) {
      teaserBlocks = <TeaserBlocks>[];
      json['teaserBlocks'].forEach((v) {
        teaserBlocks!.add(TeaserBlocks.fromJson(v));
      });
    }
    if (json['actions'] != null) {
      actions = <Actions>[];
      json['actions'].forEach((v) {
        actions!.add(Actions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['insightId'] = insightId;
    data['useCaseId'] = useCaseId;
    data['segment'] = segment;
    data['businessId'] = businessId;
    data['lineOfBusiness'] = lineOfBusiness;
    data['generatedDate'] = generatedDate;
    data['presentedDate'] = presentedDate;
    data['selectedDate'] = selectedDate;
    data['score'] = score;
    data['category1'] = category1;
    data['category2'] = category2;
    data['category3'] = category3;
    data['insightType'] = insightType;
    data['status'] = status;
    data['type'] = type;
    data['highlighted'] = highlighted;
    data['teaserTemplate'] = teaserTemplate;
    data['userTag'] = userTag;
    if (teaserBlocks != null) {
      data['teaserBlocks'] = teaserBlocks!.map((v) => v.toJson()).toList();
    }
    if (actions != null) {
      data['actions'] = actions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeaserBlocks {
  String? blockId;
  String? type;
  String? url;
  String? alt;
  String? date;
  String? text;
  String? directory;
  String? fileType;
  String? buttonType;
  String? centerText;
  String? direction;
  List<Options>? options;
  List<dynamic>? categories;
  List<Series>? series;
  List<Slice>? slices;
  List<List<HorizontalSeries>>? listOfHorizontalSeries;

  TeaserBlocks(
      {this.blockId,
      this.type,
      this.url,
      this.alt,
      this.date,
      this.text,
      this.directory,
      this.fileType,
      this.buttonType,
      this.centerText,
      this.direction,
      this.options,
      this.categories,
      this.series,
      this.slices,
      this.listOfHorizontalSeries});

  TeaserBlocks.fromJson(Map<String, dynamic> json) {
    blockId = json['blockId'];
    type = json['type'];
    url = json['url'];
    alt = json['alt'];
    date = json['date'];
    text = json['text'];
    directory = json['directory'];
    fileType = json['fileType'];
    buttonType = json['buttonType'];
    centerText = json['centerText'];
    direction = json['direction'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    ;
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(v);
      });
    }
    if (json['series'] != null) {
      series = <Series>[];
      if (direction == "horizontal") {
        listOfHorizontalSeries = <List<HorizontalSeries>>[];
        json['series'].forEach((v) {
          List<HorizontalSeries> innerList = <HorizontalSeries>[];
          v.forEach((item) {
            innerList.add(HorizontalSeries.fromJsonMap(item));
          });
          listOfHorizontalSeries!.add(innerList);
        });
      } else {
        json['series'].forEach((v) {
          series!.add(Series.fromJson(v));
        });
      }
    }
    if (json['slices'] != null) {
      slices = <Slice>[];
      json['slices'].forEach((v) {
        slices!.add(Slice.fromJsonMap(v));
      });
    }
    if (json['listOfHorizontalSeries'] != null) {
      listOfHorizontalSeries = <List<HorizontalSeries>>[];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['blockId'] = blockId;
    data['type'] = type;
    data['url'] = url;
    data['alt'] = alt;
    data['date'] = date;
    data['text'] = text;
    data['directory'] = directory;
    data['fileType'] = fileType;
    data['buttonType'] = buttonType;
    data['centerText'] = centerText;
    data['direction'] = direction;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['categories'] = categories;
    if (series != null) {
      data['series'] = series!.map((v) => v.toJson()).toList();
    }
    if (slices != null) {
      data['slices'] = slices!.map((v) => v.toJson()).toList();
    }
    if (listOfHorizontalSeries != null) {
      data['listOfHorizontalSeries'] = listOfHorizontalSeries;
    }
    return data;
  }
}

class Options {
  String? id;
  bool? selected;
  String? text;
  String? txt;
  bool? active;
  String? action;
  String? type;
  String? navigateTarget;

  Options(
      {this.id,
      this.selected,
      this.text,
      this.txt,
      this.active,
      this.action,
      this.type,
      this.navigateTarget});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selected = json['selected'];
    text = json['text'];
    txt = json['txt'];
    active = json['active'];
    action = json['action'];
    type = json['type'];
    navigateTarget = json['navigateTarget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['selected'] = selected;
    data['text'] = text;
    data['txt'] = txt;
    data['active'] = active;
    data['action'] = action;
    data['type'] = type;
    data['navigateTarget'] = navigateTarget;
    return data;
  }
}

class Actions {
  String? actionId;
  String? actionType;
  Payload? payload;

  Actions({this.actionId, this.actionType, this.payload});

  Actions.fromJson(Map<String, dynamic> json) {
    actionId = json['actionId'];
    actionType = json['actionType'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actionId'] = actionId;
    data['actionType'] = actionType;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? navigateTarget;
  Payload? payload;

  Payload({this.navigateTarget, this.payload});

  Payload.fromJson(Map<String, dynamic> json) {
    navigateTarget = json['navigateTarget'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['navigateTarget'] = navigateTarget;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class PayloadInPayload {
  String? recommendedBudgetKey;
  int? recommendedBudgetAmount;
  int? percentage;
  String? trend;

  PayloadInPayload(
      {recommendedBudgetKey, recommendedBudgetAmount, percentage, trend});

  PayloadInPayload.fromJson(Map<String, dynamic> json) {
    recommendedBudgetKey = json['recommendedBudgetKey'];
    recommendedBudgetAmount = json['recommendedBudgetAmount'];
    percentage = json['percentage'];
    trend = json['trend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recommendedBudgetKey'] = recommendedBudgetKey;
    data['recommendedBudgetAmount'] = recommendedBudgetAmount;
    data['percentage'] = percentage;
    data['trend'] = trend;
    return data;
  }
}

class Series {
  String? label;
  double? value;

  Series({label, value});

  Series.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = double.parse(json['value'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}
