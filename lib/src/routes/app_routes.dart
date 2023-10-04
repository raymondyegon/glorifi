part of './app_pages.dart';

abstract class Routes {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String devZone = '/dev_zone';
  static const String settings = '/settings';
  static const String sampleItem = '/sample_item';
  static const String appUnlock = '/app-unlock';
  static const String appLockScreen = '/appLockScreen';
  static const String updateHandlerScreen = '/updateHandlerScreen';

  static const String news = '/news';
  static const String onboard = '/onboard';
  static const String navBarScreen = '/navbarScreen';
  static const String insurance = '/insurance';
  static const String snapshot = '/snapshot';
  static const String accountDetails = '/accountDetails';
  static const String createAccount = '/createAccount';
  static const String secondpage = '/secondpage';
  static const String valueScreens = '/value-screens';
  static const String login = '/login';
  static const String forgotPassword = '/forgot_password';
  static const String createProfile = '/create-profile';
  static const String createProfilePlus = '/create-profilePlus';
  static const String demoNumberApi = '/demo-number';
  static const String notificationList = '/notification-list';

  static const String myBanking = '/my-banking';
  static const String investmentUserName = '/investment-username';
  static const String investmentDOB = '/investment-dob';
  static const String investmentGender = '/investment-gender';
  static const String stockSelection = '/investment-stock';
  static const String getStarted = '/investment-get-start';
  static const String signUp = '/investment-signup';
  static const String localAuthDemo = '/demo-localAuth';
  static const String enableCreditScoreStep1Name = '/credit_score_name';
  static const String creditScoreDetailScreen = '/credit_score_full_state';
  static const String creditScoreResult = '/credit_score_result';
  static const String enableCreditScoreStep2Address = '/credit_score_enable';
  static const String enableCreditScoreStep3SSN = '/credit_score_ssn';
  static const String enableCreditScoreStep4Phone = '/credit_score_phone';
  static const String enableCreditScoreSuccessScreen =
      '/credit_score_success_screen';
  static const String creditScoreRetrieveSuccess =
      '/credit_score_retrive_success';

  static const String mobileDeposit = '/mobile-deposit';
  static const String mobileDepositVerifyingCheck =
      '/mobile-deposit-verifying-check';
  static const String mobileDepositTo = '/mobile-deposit-to';
  static const String mobileDepositAccepted = '/mobile-deposit-accepted';
  static const String mobileDepositInReview = '/mobile-deposit-in-review';
  static const String viewCheck = '/view_check';
  static const String checkReviewActions = '/check_review_actions';
  static const String depositedChecks = '/deposited_checks';
  static const String checkPrint = '/print';

  static const String creditUsage = '/credit_usage';
  static const String creditUsageDetails = '/credit_usage_details';
  static const String unqorkPage = '/unqork';
  static const String backbasePage = '/backbase';
  static const String editProfileLanding = '/editProfileLanding';

  static const String contactInfo = '/contactInfo';
  static const String glorifiAccount = '/glorifiAccount';
  static const String loginCredentials = '/loginCredentials';
  static const String imagePickerDemo = '/demo-imagePicker';
  static const String video = '/video';

  //Cockpit Screens
  static const String cockpit = '/cockpit';
  static const String sample_sliver = '/sample_sliver';
  static const String insightsLandingPage = '/insights-landing';
  static const String brokerageMainPage = '/brokerage_main';
  static const String insights = '/insights';
  static const String reward = '/reward';

  static const String money = '/money';
  static const String accounts = '/accounts';
  static const String referral = '/referral';
  static const String featuredArticle = '/featured_article';

  //Profile Screens
  static const COMMUNICATIONS = '/communications';
  static const String alerts = '/alerts';
  static const String profile = '/profile';
  static const DOCUMENTS = '/documents';
  static const String cashOnHand = '/cash-on-hand';

  //static const String settings = '/settings';

  //Personal snapshot screens
  static const String personalSnapshotScreen = '/personal-snapshot';
  static const String totalDebtDetailScreen =
      '$personalSnapshotScreen/total-debt';

  static const String netWorthDetailScreen =
      '$personalSnapshotScreen/net-worth';
  static const String savingsRetirementScreen =
      '$personalSnapshotScreen/savings-retirement';
  static const String managePersonalSnapshotScreen =
      '$personalSnapshotScreen/manage';
  static const String manageAccountSnapshotScreen =
      '$personalSnapshotScreen/manage-account';
  static const String unlinkAccountDetailScreen =
      '$personalSnapshotScreen/manage/unlink-account';
  static const String unlinkAccountSuccessScreen =
      '$personalSnapshotScreen/manage/unlink-account-success';

  //home value
  static const String homeValueScreen = '/homeValueScreen';
  static const String homeValueDetailsScreen = '/homeValueDetailsScreen';
  static const String selectAddressScreen = '/selectAddressScreen';
  static const String successAddressScreen = '/successAddressScreen';

  static const String compareUser = '/compare_user';
  static const String compareOptionView = '/compare_option_view';
  static const String compareOptionDetailsView = '/compare_option_details_view';
  static const String compareResultView = '/compare_result_view';

  //Credit Card Screens
  static const String creditCardDetailScreen = '/credit-card-detail';
  static const String applyForCreditCardScreen = '/apply-for-credit-card';
  static const String creditCardComingSoonScreen =
      '/creditCardComingSoonScreen';

  /// Products
  static const String products = '/products';
  static const String mortgage = '/mortgage';
  static const String mortgageDetail = '/mortgageDetail';
  static const String mortgageDetailSubmitted = '/mortgageDetailSubmitted';
  static const String mortgagePreApply = '/mortgage-pre-apply';
  static const String connectBlendSso = '/connect-blend-sso';
  static const String creditCardUnavailable = '/credit_card_unavailable';

  static const String mortgageUnavailable = '/mortgage_unavailable';
  static const String oktalogin = '/oktalogin';

  /// Credit Card (New Flow Routes should be added here)
  static const String creditCardScreen = '/credit-card-screen';
  static const String creditCardFAQ = '/credit_card_faq';
  static const String creditCardBenefits = '/credit_card_benefits';

  /// ACC
  static const String accPersonalInfo = '/acc_personal_info';
  static const String accAcceptCardAgreement = '/acc_accept_card_agreement';
  static const String accContactInfo = '/acc_contact_info';
  static const String accAddress = '/acc_address';
  static const String accVerifySSN = '/acc_verify_ssn';
  static const String accAccommodation = '/acc_accommodation';
  static const String accHousingCost = '/acc_housing_cost';
  static const String accChooseCreditCardType = '/acc_choose_credit_card_type';
  static const String accChooseCreditCardDesign =
      '/acc_choose_credit_card_design';
  static const String accProcessing = '/acc_processing';
  static const String accFrozenScreen = '/acc_frozen_screen';
  static const String accOfferGoldCreditCardScreen =
      '/acc_offer_gold_credit_card_screen';
  static const String accNotApprovedScreen = '/acc_not_approved_screen';
  static const String accOfferBlueCreditCardScreen =
      '/acc_offer_blue_credit_card_screen';
  static const String accOfferBlueAndGoldCreditCardScreen =
      '/acc_offer_blue_and_gold_credit_card_screen';
  static const String accCardCancelation = '/acc_card_cancelation';
  static const String accConfirmCardCancelation =
      '/acc_confirm_card_cancelation';
  static const String accEmploymentStatus = '/acc_employment_status';
  static const String accSSNErrorFeedback = '/acc_ssn_error_feedback';
  static const String accReviewApplicationScreen =
      '/acc_review_application_screen';
  static const String brassCardDetails = '/brass_card_details';
  static const String basicCardDetails =
      '/basic_card_details';

  static const String insuranceCategoryList = '/insuranceCategoryList';
  static const String insuranceScreen = '/insuranceScreen';
  static const String policyDetailsScreen = '/policyDetailsScreen';
  static const String roadsideAssistanceScreen = '/roadsideAssistanceScreen';
  static const String submitClaimScreen = '/submitClaimScreen';
  static const String bundlesScreen = '/bundles';
  static const String policyDocuments = '/policyDocuments';

  static const String exploreProducts = '/explore';
  static const String continueCreateQuote = '/continueCreateQuote';
  static const String accNotAvailableScreen = '/acc_not_available_screen';
  static const String accVerifyIdentity = '/acc_verify_identity_screen';
  static const String captureIdFrontScreen = '/capture_id_front_screen';
  static const String captureIdBackScreen = '/capture_id_back_screen';
  static const String captureSelfieScreen = '/capture_selfie_screen';
  static const String idVerificationScreen = '/id_verification_screen';
  static const String accApplicationInProgress = '/application_in_progress';
  static const String accApplicationInReview = '/application_in_review';
  static const String accResumeApplication = '/resume_application';

  // Brokerage
  static const String brokerage = '/brokerage';

  // my bank account screen
  static String myBank = '/my-bank';
  static String reusableTextWidget = '/reusableTextWidget';
  static String signUpInMinutes = '/signUpInMinutes';
  static String welcomeToGlorifi = '/welcomeToGlorifi';
  static const String checkDepositConsent = '/check_deposit_consent';
  static const String checkDepositTerms = '/check_deposit_terms';
  static const String checkDepositCamera = '/check_deposit_camera';
  static const String checkDepositCameraBackConfirmation =
      '/check_deposit_camera_back_confirmation';
  static const String manageAccount = '/manage_account';

  static const String ccPayments = '/cc_payments';

  static const String ccDashboard = '/cc_dashboard';
  static const String openBankAccount = '/open-bank-account';
  static const String ebsAccountDetails = '/servicing/account-details';
  static const String ebsTransactionDetail = '/servicing/transaction-detail';
  static const String ebsTransfer = '/money_transfer';
  static const String ebsWireInstructions =
      '/servicing/account-details/wire-instructions';
  static const String allTransactions = '/servicing/all-transactions';

  //Support
  /** Note: All FAQ related screens should have 'faq' string in their routes. This is to facilitate the Cancel button functionality on the toolbar,
   * which is to pop all pages related to faq and go back to parent screen.**/
  static const String faqCategoriesListingScreen =
      '/faqCategoriesListingScreen';
  static const String faqQuestionsListingScreen = '/faqQuestionsListingScreen';
  static const String faqAnswerScreen = '/faqAnswerScreen';
  static const String contactSupportScreen = '/support_faqContactSupportScreen';
  static const String contactSupportScreenAsModal =
      '/faqContactSupportScreenAsModal'; //this route has a bottomup transition animation
  static const String searchFaqScreen = '/faqSearchScreen';
  static const String messageUsScreen = '/support_faqMessageUsScreen';
  static const String emailSentSuccessScreen =
      '/support_emailSentSuccessScreen';
  static const String contactSupportCategoryScreen =
      '/support_contactSupportCategoryScreen';
  static const String guestUserFormScreen = '/support_guestUserScreen';
  static const String requestCallBack = '/support_requestCallBack';
  static const String callbackSuccess = '/support_callbackSuccess';
  static const String emailSentError = '/support_emailSentError';
  static const String contactSupportErrorScreen = '/contactSupportErrorScreen';

  static String totalAccountsOpened = '/totalAccountsOpened';
  static String enableToSeeData = '/enableToSeeData';
  static String personalSnapShotFullState = '/personalSnapShotFullState';

  // Insights Screens
  static String insightsStory = '/insights-story';
  static const ALL_PRODUCTS = '/onboard/all-products';

  static const String createPassword = '/create-password';
  static String legalScreen = '/legal_screen';

  //plaid screen
  static const String plaidDemo = '/PlaidDemo';
  static const String plaidSuccessScreen = '/PlaidSuccessScreen';
  static const String inputDetailsScreen = '/InputDetailsScreen';
  static const EDIT_ZIP_CODE =
      '/src/feature/onboard/edit-profile/edit-zip-code';
  static const editPhoneNumber =
      '/src/feature/onboard/edit-profile/edit-phone-number';
  static const EDIT_PROFILE_SUCCESS =
      '/src/feature/onboard/edit-profile/edit-profile-success';
  static const EDIT_PREFERRED_NAME =
      '/src/feature/onboard/edit-profile/edit-preferred-name';
  static const findAtms = '/findAtms';
  static const UNSAFE_DEVICE_DETECTED =
      '/src/feature/onboard/unsafe-device-detected';

  static const myCreditCard = '/myCreditCard';

  static const bundleComplete = '/complete-screen';
  static const PROFILE_ERROR_HANDLE =
      '/src/feature/cockpit/profile/profile-error-handle';

  static const outsideUSAError = '/errors/outside_us';

  static const webAuthCallBack = '/users/callback';

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$login?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  static const String ccTransactionDetailsScreen =
      '/cc_transaction_details_screen';

  //statements hub
  static String creditCardStatementsScreen = '/credit-card-statements';

  static String ccActivatePhysicalCard = '/cc_activate_physical_card';
  static String ccActivatePhysicalCardSuccess =
      '/cc_activate_physical_card_success';
  static String ccActivatePhysicalCardFailure =
      '/cc_activate_physical_card_failure';

  static String accOfferBrassCardDetailsScreen =
      '/acc_offer_brass_card_details_screen';

  static String ccManage = '/cc_manage';
  static String ccManageReportCardScreen = '/cc_manage_report_card_screen';
  static String ccAutoPaymentInfoScreen = '/cc_auto_payment_info_screen';
  static String viewCreditLimitAndApr = '/view_credit_limit_and_apr';
}
