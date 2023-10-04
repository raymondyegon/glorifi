class BasicCardDetailsModel {
  final String? image;
  final String? title;
  final String? subTitle;
  final String? description;
  final BasicCardRewardModel? basicCardRewardModel;
  final BasicCardBenefitModel? basicCardBenefitModel;

  final BasicCardDesignModel? basicCardDesignModel;
  final String? basicCardFooterModel;

  BasicCardDetailsModel({
    this.image,
    this.title,
    this.subTitle,
    this.description,
    this.basicCardRewardModel,
    this.basicCardBenefitModel,
    this.basicCardDesignModel,
    this.basicCardFooterModel,
  });
}

class BasicCardDesignModel {
  final String title;

  final List<BasicCardDesignPreviewModel>? previewModel;

  BasicCardDesignModel({
    required this.title,
    required this.previewModel,
  });
}

class BasicCardRewardModel {
  final String? title;
  final String? description;
  final BasicCardRewardDataModel? data;

  BasicCardRewardModel({
    this.title,
    this.description,
    this.data,
  });
}

class BasicCardRewardDataModel {
  final String? reward;
  final String? apr;
  final int? annualFee;

  BasicCardRewardDataModel({
    this.reward,
    this.apr,
    this.annualFee,
  });
}

class BasicCardBenefitModel {
  final String? title;
  final List<String>? benefits;

  BasicCardBenefitModel({
    this.title,
    this.benefits,
  });
}

class BasicCardDesignPreviewModel {
  final String? image;
  final String? description;

  BasicCardDesignPreviewModel({
    this.description,
    this.image,
  });
}
