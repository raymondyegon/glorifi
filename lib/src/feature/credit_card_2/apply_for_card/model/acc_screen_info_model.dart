import 'package:glorifi/src/utils/text_constants.dart';

class ACCScreenInfoModel {
  ACCScreenInfoModel({
    required this.percentage,
    required this.title,
    this.ctaTitle = 'Continue',
    this.subtitle,
    this.showArrowOnCta = true,
  });

  double percentage;
  String title;
  String? subtitle;
  String ctaTitle;
  bool showArrowOnCta;
}

extension ACCScreensInfo on ACCScreenInfoModel {
  static ACCScreenInfoModel ACCPersonalInformation = ACCScreenInfoModel(
    title: 'Let’s start with some basic information.',
    subtitle:
        "Make sure this information matches your driver’s license or government ID. ",
    percentage: 0,
  );
  static ACCScreenInfoModel ACCContactInfoScreen = ACCScreenInfoModel(
    subtitle:
        "We’ll use this to secure your account and provide support if you need it.",
    title: "Where can we reach you?",
    percentage: 0,
  );

  static ACCScreenInfoModel ACCAddressScreen = ACCScreenInfoModel(
    subtitle: "We’re legally required to collect this information.",
    title: "What's your Address?",
    percentage: 0,
  );

  static ACCScreenInfoModel ACCEmployeeStatusScreen = ACCScreenInfoModel(
    title: "What is your current employment status?",
    percentage: 30,
  );
  static ACCScreenInfoModel ACCAnnualIncomeScreen = ACCScreenInfoModel(
    title: "What is your gross annual income?",
    subtitle: "Combined amount of income from all sources in a given year.",
    percentage: 30,
  );

  static ACCScreenInfoModel ACCVerifySSN = ACCScreenInfoModel(
    percentage: 70,
    title: '''What’s your Social\nSecurity number?''',
    subtitle: TextConstants.ccSsn,
  );

  static ACCScreenInfoModel ACCVerifySSNError = ACCScreenInfoModel(
    percentage: 0,
    title: "An SSN Is Needed To Pull Your Credit Report.",
    subtitle: "You may apply again after an SSN is obtained. ",
    ctaTitle: "Cancel Application",
  );

  static ACCScreenInfoModel ACCChooseCreditCardDesign = ACCScreenInfoModel(
    percentage: 100,
    title: "Which card design would you like?",
    ctaTitle: "Get this design",
  );
  static ACCScreenInfoModel ACCAcceptCardHolder = ACCScreenInfoModel(
    percentage: 100,
    title: "Accept the Cardholder Agreement.",
  );

  static ACCScreenInfoModel ACCAccommodationScreen = ACCScreenInfoModel(
    percentage: 85,
    title: TextConstants.whatIsYourCurrentLivingSituation,
  );

  static ACCScreenInfoModel ACCHousingCostScreen = ACCScreenInfoModel(
    percentage: 100,
    title: TextConstants.whatIsMonthlyHousingCost,
    subtitle: TextConstants.informationEvaluateExpense,
  );

  static ACCScreenInfoModel ACCChooseCreditCardDesignType = ACCScreenInfoModel(
    percentage: 100,
    title: 'Congrats! Choose your GloriFi Card.',
  );

  static ACCScreenInfoModel ACCReviewApplication = ACCScreenInfoModel(
    percentage: 80,
    title: 'Let’s review your application.',
    showArrowOnCta: false,
    ctaTitle: 'Submit Application',
  );

  static ACCScreenInfoModel ACCNotApprovedScreen = ACCScreenInfoModel(
    percentage: 0,
    title: "Sorry, We Can’t Approve A Credit Card For You At This Time.",
    subtitle: "Thank you for your interest. Unfortunately, your credit score did not meet our requirements. ",
    ctaTitle: "Close",
  );

  static ACCScreenInfoModel ACCFrozenScreen = ACCScreenInfoModel(
    percentage: 0,
    title:
        "We’re Unable To Check Your Credit Score Because It’s Locked or Frozen.",
    subtitle:
        "Please contact Experian at 888-EXPERIAN or visit their website to lift any restrictions and try again.",
  );

  static ACCScreenInfoModel ACCQualifiedScreen = ACCScreenInfoModel(
    percentage: 0,
    title: r"Congratulations! You’re approved for a $3,000 credit limit with an APR of 20.99%.",
    subtitle: "You’re on your way! Accept the Cardholder Agreement to complete your application and get your card.",
    ctaTitle: "View Cardholder Agreement",
  );

  static ACCScreenInfoModel ACCApprovedScreen = ACCScreenInfoModel(
    percentage: 0,
    title: r"You’re approved for a $2,999 credit limit with an APR of 20.99%.",
    subtitle: "You’re on your way! Choose your card’s design and accept the Card Holder Agreement to lock in your rate and get your card.",
    ctaTitle: "Choose Card Design",
  );

  static ACCScreenInfoModel ACCOfferBlueAndGoldCreditCardScreen = ACCScreenInfoModel(
      percentage: 0,
      title: r"You’re approved for a $3,000 credit limit at an APR of 20.99%.",
      subtitle: "Congratulations! You've also qualified for our premium Cartridge Brass World Elite Mastercard® Card");

  static ACCScreenInfoModel ACCCardCancelation = ACCScreenInfoModel(
      title: "Are you sure you don’t want your card?",
      ctaTitle: "I still want the card",
      subtitle:
          "You must accept the offer to receive your card and avoid going through the application process again.",
      percentage: 0);
  static ACCScreenInfoModel ACCConfirmCardCancelation = ACCScreenInfoModel(
      title: "No problem, your offer is valid for 60 days.",
      ctaTitle: "Leave Application",
      subtitle: "You can return to complete your application within that time.",
      percentage: 0);
  static ACCScreenInfoModel ACCCardNotAvailable = ACCScreenInfoModel(
      title: "",
      ctaTitle: "Cancel Application",
      subtitle:
          "Check back later to see if GloriFi credit cards are available in your state. In the meantime, have you explored our other services? ",
      percentage: 0);
  static ACCScreenInfoModel ACCVerifyIdentityPart1 = ACCScreenInfoModel(
      title: "For security, let’s verify your identity.",
      ctaTitle: "Continue",
      percentage: 0);
  static ACCScreenInfoModel captureIdFrontScreen = ACCScreenInfoModel(
    title: "Capture the front of card. ",
    ctaTitle: "CONTINUE",
    subtitle: "Place your ID in the frame and take a photo.",
    percentage: 30,
  );
  static ACCScreenInfoModel captureIdBackScreen = ACCScreenInfoModel(
    title: "Capture the back of card. ",
    ctaTitle: "CONTINUE",
    subtitle: "Place your ID in the frame and take a photo.",
    percentage: 30,
  );
  static ACCScreenInfoModel captureSelfieScreen = ACCScreenInfoModel(
    title: "Verify your identity with a selfie.",
    ctaTitle: "VERIFY",
    subtitle: "Align your face in the frame and take a photo.",
    percentage: 30,
  );
  static ACCScreenInfoModel verifyIdentityScreen = ACCScreenInfoModel(
    title: "Thank you for verifying your identity.",
    ctaTitle: "REVIEW APPLICATION",
    subtitle: "These documents will be securely kept on file. ",
    percentage: 30,
  );
}
