class BrassCardDetailsModel {
  final String? image;
  final String? title;
  final String? subTitle;
  final String? description;
  final BrassCardRewardModel? rewards;
  final List<String>? brassCardServices;
  final List<String>? partners;
  final BrassCardElitePartnerPerksModel? brassCardElitePartnerPerks;
  final BrassCardBenefitsModel? brassCardBenefitsModel;
  final BrassCardDetailsFooterModel? brassCardFooter;

  BrassCardDetailsModel({
    this.image,
    this.title,
    this.subTitle,
    this.description,
    this.rewards,
    this.brassCardServices,
    this.partners,
    this.brassCardElitePartnerPerks,
    this.brassCardBenefitsModel,
    this.brassCardFooter,
  });
}

class BrassCardElitePartnerPerksModel {
  final String? title;
  final List<String>? perks;

  BrassCardElitePartnerPerksModel({
    this.title,
    this.perks,
  });
}

class BrassCardBenefitsModel {
  final String? title;
  final List<String>? benefits;

  BrassCardBenefitsModel({
    this.title,
    this.benefits,
  });
}

class BrassCardRewardModel {
  final String? title;
  final String? description;
  final BrassCardRewardDataModel? data;

  BrassCardRewardModel({
    this.title,
    this.description,
    this.data,
  });
}

class BrassCardRewardDataModel {
  final String? reward;
  final String? apr;
  final int? annualFee;

  BrassCardRewardDataModel({
    this.reward,
    this.apr,
    this.annualFee,
  });
}

class BrassCardDetailsFooterModel {
  final String? image;
  final String? title;
  final String? description;
  final String? disclosure;

  BrassCardDetailsFooterModel({
    this.image,
    this.title,
    this.description,
    this.disclosure,
  });
}
