import 'package:flutter/cupertino.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

const RadialGradient RED_GRADIENT =
    RadialGradient(colors: [GlorifiColors.bloodOrange, GlorifiColors.red]);
const RadialGradient BLUE_GRADIENT =
    RadialGradient(colors: [GlorifiColors.bondiBlue, GlorifiColors.biscayBlue]);

extension HighlightPrefabs on HighlightModel {
  static HighlightModel MortgageStatus = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Mortgage Loan Approved",
      secondary: "",
      callToAction: "View Details",
      route: Routes.mortgage);

  static HighlightModel InsuranceStatus = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Status Check",
      secondary: "Review your insurance status.",
      callToAction: "Insurance",
      // backgroundColor: RED_GRADIENT,
      route: Routes.insuranceScreen);

  static HighlightModel BankingStatus = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Status Check",
      secondary: "Review your banking status.",
      callToAction: "Banking",
      // backgroundColor: BLUE_GRADIENT,
      route: Routes.myBanking);

  static HighlightModel LinkInsights = StandardHighlightModel(
      cardType: CardType.standard,
      title: "GloriFi Insights",
      secondary: "",
      callToAction: "Link Account",
      // imageUri: 'assets/images/ride.png',
      isPlaid: true);

  static HighlightModel Insights = StandardHighlightModel(
      cardType: CardType.standard,
      title: "GloriFi Insights",
      secondary: "",
      callToAction: "Get your Insights",
      // imageUri: 'assets/images/fam.png',
      route: Routes.insights);

  static HighlightModel ApplyChecking = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Open a GloriFi Checking",
      secondary: "",
      callToAction: "GloriFi Checking",
      // imageUri: 'assets/images/party.png',
      route: Routes.myBanking);

  static HighlightModel ApplySavings = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Receive all the convenience & benefits.",
      secondary: "",
      callToAction: "GloriFi Savings",
      // imageUri: 'assets/images/swim.png',
      route: Routes.myBanking);

  static HighlightModel QuickQuote = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Insurance Quick Quote",
      secondary: "",
      callToAction: "Continue",
      // imageUri: 'assets/images/bike.png',
      route: Routes.insuranceScreen);

  static HighlightModel HouseInsurance = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Insure your Home",
      secondary: "",
      callToAction: "Home Insurance",
      // imageUri: 'assets/images/house.png',
      route: Routes.insuranceScreen);

  static HighlightModel PetInsurance = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Insure your pet",
      secondary: "",
      callToAction: "Pet Insurance",
      // imageUri: 'assets/images/dog.png',
      route: Routes.insuranceScreen);

  static HighlightModel CreditCard = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Your Brass Card is waiting",
      secondary: "",
      callToAction: "Brass Card",
      // imageUri: 'assets/images/goldflag.png',
      route: Routes.creditCardScreen);

  static HighlightModel CheckCreditScore = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Check your credit score",
      secondary: "",
      // imageUri: 'assets/images/man.png',
      callToAction: "Free Report",
      route: Routes.enableCreditScoreStep1Name);

  static HighlightModel UpdateProfile = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Complete your profile",
      secondary: "",
      callToAction: "Update Profile",
      // backgroundColor: RED_GRADIENT,
      route: Routes.editProfileLanding);

  static HighlightModel LinkBankAccount = StandardHighlightModel(
      cardType: CardType.standard,
      title: "View your Bank Accounts",
      secondary: "",
      callToAction: "Link Account",
      // imageUri: 'assets/images/horse2.png',
      isPlaid: true);

  static HighlightModel LinkBankAccount2 = StandardHighlightModel(
      cardType: CardType.standard,
      title: "View GloriFi Insights",
      secondary: "",
      callToAction: "Link Account",
      // imageUri: 'assets/images/twoflag.png',
      isPlaid: true);

  static HighlightModel InviteFriend = StandardHighlightModel(
      cardType: CardType.standard,
      title: "Invite A Friend",
      secondary: "",
      // imageUri: 'assets/images/horse.png',
      // overLayColor: GlorifiColors.red,
      callToAction: "Invite A Friend",
      route: Routes.referral);

  // static HighlightModel GlorifiStory = VideoHighlightModel(
  //     // imageUri: 'assets/images/flag.png',
  //     title: "assets/images/story_video.png",
  //     videoUri: '', // Hardcoded for MVP
  //     route: Routes.videoPlayerWithNav);

  // static HighlightModel SeeAllArticles = StandardHighlightModel(
  //     cardType: CardType.standard,
  //     title: "News",
  //     secondary: "",
  //     callToAction: "Read Now",
  //     // imageUri: 'assets/images/crowd.png',
  //     route: Routes.seeAllArticles);

  // static HighlightModel SeeAllVideos = StandardHighlightModel(
  //     cardType: CardType.standard,
  //     title: "Videos",
  //     secondary: "",
  //     callToAction: "Watch Now",
  //     // imageUri: 'assets/images/boy.png',
  //     route: Routes.seeAllVideos);
}
