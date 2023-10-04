import 'package:glorifi/src/utils/text_constants.dart';

class OAOScreenInfo {
  double percentage;
  String title;
  String? subtitle;
  String ctaTitle;
  bool showArrowOnCta;
  


  OAOScreenInfo({
    required this.percentage,
    required this.title,
    this.subtitle,
    this.ctaTitle = "Continue",
    this.showArrowOnCta = true,
  });
}

extension OAOScreensInfo on OAOScreenInfo {

  static OAOScreenInfo OAOVerifyCitizenshipScreen1 = OAOScreenInfo(
      title: "What’s your current residency status?",
      subtitle: "We are legally required to collect this information.",
      percentage: 60);

  static OAOScreenInfo OAOVerifyCitizenshipScreen2 =
      OAOScreenInfo(title: "In which country are you a citizen?", percentage: 60);

  static OAOScreenInfo OAOVerifyITINScreen = OAOScreenInfo(
      title: "What’s your Tax Identification Number?",
      subtitle:
          "An ITIN is a tax processing number only available for certain nonresident and resident aliens, their spouses, and dependents who cannot get a Social Security Number (SSN).",
      percentage: 60);    
      
  
  static OAOScreenInfo OAOWorkStateScreen =
      OAOScreenInfo(title: "What is your current work situation?", percentage: 60);

  static OAOScreenInfo OAOAnnualIncomeScreen = OAOScreenInfo(
      title: "What is your annual income?",
      subtitle: "Combined amount of income from all sources in a given year.",
      percentage: 60);

  static OAOScreenInfo OAODebitCardScreen = OAOScreenInfo(
    percentage: 70,
    ctaTitle: 'Order',
    title: 'Select which debit card you would like.',
    showArrowOnCta: false,
  );
  
  static OAOScreenInfo OAOVerifySSNScreen = OAOScreenInfo(
    percentage: 70,
    title: 'What’s your social security number?',
    subtitle: " We need this to verify your identity.",
  );

  static OAOScreenInfo OAOShippingScreen = OAOScreenInfo(
    percentage: 100,
    ctaTitle: 'Order',
    title: "Shipping Information",
    showArrowOnCta: false,
  );

  static OAOScreenInfo OAOProductSelection = OAOScreenInfo(
    percentage: 11.5,
    title: 'Select your term',
    subtitle: 'Which certificate of deposit term works best for you? ',
  );

  static OAOScreenInfo OAOReviewApplicationScreen = OAOScreenInfo(
    percentage: 100,
    ctaTitle: 'Confirm',
    title: 'Let’s review your application.',
    showArrowOnCta: false,
  );

  static OAOScreenInfo OAOPersonalInformationScreen = OAOScreenInfo(
    title: 'Let’s start with some basic information.',
    subtitle: "Make sure this information matches your Government Identification.",
    percentage: 14,
  );

  static OAOScreenInfo OAOContactInfoScreen = OAOScreenInfo(
    subtitle: "We’ll use this information to safeguard your account and provide support if you need it.",
    title: "Where can we reach you?",
    percentage: 25,
  );
  static OAOScreenInfo OAOCompleteAccountScreen = OAOScreenInfo(
    title: 'Complete Account',
    percentage: 100,
  );

  static OAOScreenInfo OAOCD = OAOScreenInfo(
    title: 'Your Certificate of Deposit ',
    subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit ut.",
    percentage: 100,
    ctaTitle: "Confirm",
    showArrowOnCta: false,
  );

  static OAOScreenInfo OAOAddressScreen = OAOScreenInfo(
    subtitle: "We’re legally required to collect this information.",
    title: "What’s your physical address?",
    percentage: 40,
  );

  static OAOScreenInfo OAOFundingAccountsScreen = OAOScreenInfo(
    title: 'What account would you like to transfer from?',
    percentage: 100,
  );

  static OAOScreenInfo OAOFundYourAccountPlaidScreen = OAOScreenInfo(
    title: "What account would you like to transfer from?",
    percentage: 100,
    subtitle: '',
  );

  static OAOScreenInfo OAODepositScreen = OAOScreenInfo(
    title: "How much would you like to transfer?",
    percentage: 100,
    ctaTitle: 'Transfer',
    showArrowOnCta: false,
  );
  
  static OAOScreenInfo OAOFurtherReview = OAOScreenInfo(
    percentage: 0,
    title: "Your application requires further review",
    subtitle:
        "To guarantee your security, we have decided to  review your application.\n\nYou’ll receive an email notification about the status within 7-10 business days. ",
    ctaTitle: "Return to account",
  );

  static OAOScreenInfo OAOBackScreen = OAOScreenInfo(
    percentage: 0,
    title: "Sorry, you are not eligible to open an account at this time.",
    subtitle: "We are unable to provide banking services for any persons that cannot provide a valid SSN or ITIN.\n\nYou may contact us at (844) 456-7434 (GLORIFI) for additional information regarding this decision.",
    ctaTitle: "Return to account",
  );
}
