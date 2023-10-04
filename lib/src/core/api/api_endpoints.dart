import 'package:glorifi/src/environment/environment.dart';

class ApiEndPoints {
  // API Base URLs
  static final String apiBaseUrl = Environment().config.apiBaseUrl;
  static final String coreApiUrl = '${apiBaseUrl}/core';
  static final String coreMembersApiUrl = '${coreApiUrl}/members';

  static final String googleMapsEndpoint =
      'https://maps.googleapis.com/maps/api/';

  // static final String memberUrl = 'members/10024/preferences';
  static final String getAppVersion = '/core/get_app_version';
  static final String memberPreferences = 'cockpit-member-preferences';
  static final String getMemberDetails = '/core/members';
  static final String memberDetails = 'members';
  static final String googleMapApiKey =
      'AIzaSyBuNSIl4RWsWjkw88Evfmj7SOZ3Amy98oo';
  static final String googleMapCountry =
      '"&components=country:us&language=en&key="';

  static final String placeAutoComplete = 'place/autocomplete/json?input=';
  static final String getTokenUrl =
      '${Environment().config.oktaTenant}${Environment().config.oktaIssuerPath}/v1/token';
  static final String getFeatureFlags = '/core/featureFlags';
  static String legalDataRequest(delete) =>
      '/core/privacy/${delete ? 'delete' : 'request'}';

  // Shelf
  // We need to be using this instead
  // static final String shelfApiEndpoint = '${ApiEndPoints.apiBaseUrl}/shelf-api';

  // API Paths
  static final String weather = '/core/members/content/weather';
  static final String profileUrl = '/core/profile';
  static final String validateEmailUri = '/core/validate_email/';
  static final String validateZipCodeUri = '/core/zipcodeValidation/';
  static final String accountsFlag = '/core/members/get-all-flag';
  static final String getRetirementSavings = '/core/members/retirement-savings';

  static final String getMonthlyIncome = '/core/members/income';
  static final String postMonthlyIncome = '/core/members/income/post';

  static final String getFinancialInsights =
      '/core/members/financial_insights/';

  static final String getNetWorth = '/core/members/net-worth';
  static final String netWorthVersion2 = '/core/members/cash-on-hand/net-worth';

  static final String getStockQuotes = '/core/members/content/stock-quotes';
  static final String getMortgageList = '/core/members/applications/mortgage';

  static final String saveAddress = '/core/members/address';
  static final String fetchAddress = '/core/members/address?addr_type=99';
  static final String checkAddress = '/core/members/address';

  static String getHomeValueAddress(addr_id) =>
      '/core/members/home-value/${addr_id}';
  static final String getCashOnHand = '/core/get-cash-on-hand';
  static final String cashOnHandVersion2 = '/core/members/cash-on-hand';

  static final String retirementSavings = '/core/members/retirement-savings';

  static final String getComparison = '/core/members/comparison';
  static final String postComparisonInfo = '/core/members/comparison/post-info';

  static final String getConnectedAccounts = '/core/members/plaid/accounts';
  static final String getConnectedGloriFiAccounts = '/core/banking/accounts';
  static final String getCreditCardPreview = '/change_me';

  static final String getTotalDebt = '/core/members/total-debt';

  static final String fetchState = '/core/get-states';

  static final String getCreditCardApplicationsList =
      '/core/members/applications/credit_card';

  static final String getPolicyHeaders = '/core/policy-header';
  static final String getQuotesHeaders = '/core/members/content/quote-headers';

  static final String applicationStatus = '/core/highlights/applications';
  static final String bankAccountHighlight = '/core/highlights/money';
  static final String creditScore = '/core/highlights/credit_score';
  static final String initiateEnableCreditScore = '/core/members/dit-initiate';
  static final String enableCreditScoreSMFASendUrl =
      '/core/members/authentications/initiate';
  static final String get_credit_score = '/core/members/creditScore/latest';

  static final String productHighlight = '/core/highlights/products';
  static final String getCreditCardsList = '/core/members/plaid/credit_cards';

  static final String otpMobileVerificationSend = '/core/mobile_verification';
  static final String otpVerificationResend = '/core/resend_otp';
  static final String otpVerificationVerify = '/core/verify_otp';

  // static final String faqRecommendations = '/faq-recommendations';
  static final String faqRecommendations = '/core/search/v1/autosuggest';

// static final String gemsTree = '/gems-tree';
  static final String getLibraries = '/core/search/dashboard/libraries';
  static final String getGems = '/core/search/v1/gems';
  static final String searchGems = '/core/search-gems';
  static final String getFaqAnswer = '/core/gems/';

  static final String insights =
      '/insights/glorifi-test/execute?channel=GLORIFI_LIVE';
  static final String insightsQA =
      '/insights/glorifi-test/execute?channel=GLORIFI_QA';
  static final String getMortgageStateList =
      '/datahub-service-apis/product_availability';

  static final String getNextStory = '/core/members/feed';

  static final String getSessionTokenUrl = '/core/fetch_session_token';
  static final String getPolicyDetail = '/core/insurance';

  static final String plaidLinkToken = '/core/members/plaid/link-token';

  static final String savePlaidToken = '/core/members/plaid/access/token';

  static final String plaidWebhookUrl =
      '${apiBaseUrl}/plaid-link-handling-app/plaid_broker';

  static final String sendFaqEmailToGenesys =
      '/core/genesys/conversations_email';
  static final String sendFaqEmail = '/core/support/email';

  static final String depositCheck = '/core/deposit_to_alogent_post';
  static final String depositCheckLimit = '/core/finxact_depositor_limit';

  static final String getBindableReroute = "/core/bindable_reroute";

  static final String getLastConnectedAccountInfo =
      '/core/members/plaid/last-linked/institution/info';

  static String getLinkedPlaidAccounts = '/core/members/linked-plaid-accts';

  static String unlinkPlaidInstitution(id) =>
      '/core/members/plaid/item/unlink?item_id=$id';
  static final String getScheduleInformation =
      '/core/genesys/flows/datatables/27ab5df9-97d2-412c-aaaf-b1ea8c8c109d/rows/';

  static const String getBundles = "/core/loyalty/bundles";
  static const String getBundleDetails = "/core/loyalty/bundles/details/";
  static final String viewedContent = "/core/content/score";

  static String getRewardsTier = "/core/loyalty/tier";
  static String getRewardsBalance = "/core/loyalty/balance";
  static String getRewardsSessionToken = '/core/loyalty/session';
  static String earnRewards(code) => '/core/loyalty/points/$code';

  //static String getStoriesPath(offset, perPage) => '';
  static String demoUserLoginUrl = '/api/v1/member-login';
  static String requestEarlyAccess(id) => '/core/leads/$id';

  static String savingsCheckingDetails(type) =>
      '/core/members/cash-on-hand/accounts/overview/$type';
  static String thirtyDay(id) =>
      '/core/members/cash-on-hand/accounts/thirty-day/$id';

  // Probably deprecated, but now is not the time to be nuking code - WC
  static const String sendOtpUrl = '/core/send_otp_email';
  static const String sentOtpPhoneUrl = '/core/mobile_verification';
  static const String verifyOtpMobile = '/core/verify_otp';

  // OAO!
  static const String checkingProducts = '/core/banking/products/checking';
  static const String savingProducts = '/core/banking/products/savings';
  static const String cdProducts = '/core/banking/products/cd';
  static const String createBankingUser = '/core/banking/user/create';

  static String submitApplication(id) => '/core/banking/products/${id}';

  static String orderDebitCard(id) => '/core/banking/cards/${id}';
  static const String getExistingBankingUser = '/core/banking/user';
  static const String getFundingAccounts = '/core/banking/transfers/accounts';
  static const String getCCFundingAccounts = '/core/cc/payments/accounts';

  static String getAccountDetails(id) => '/core/banking/accounts/$id';

  static String getCreditCardList = '/core/card/applicant/credit-cards';
  static String getCreditCardSchedule = '/core/card/payment/schedule';
  static String getCreditCardAccount(id) =>
      '/core/card/credit-card/account-details/$id';
  static String getCCTransactions = '/core/banking/accounts/changeme';
  static String ccSchedulePayment(id) => '/changeme/$id';
  static String ccCreatePaymentMethod(id) => '/changeme/${id}';

  static const verifyAddress = '/core/banking/address/verify';

  static String getProductDisclosures(id) =>
      '/core/banking/products/$id/agreements';
  //plaidAuthLinkToken - this one is for accounts which can be used for funding
  static final String plaidAuthLinkToken = '/core/banking/transfers/link';
  static final String saveFundingAccountToken =
      '/core/banking/transfers/accounts';
  static final String singleTransferUrlIncoming =
      '/core/banking/transfers/single/incoming';
  static final String singleTransferUrlInternal =
      '/core/banking/transfers/single/internal';
  static String getAccountTransactions(id) =>
      '/core/banking/accounts/$id/transactions';
  static String cardTransition(id, action) => '/core/banking/cards/$action/$id';
  static final String pinManagement = '/core/banking/cards/one-time-token';
  static String statements(id) => '/core/banking/statements/$id';

  static String makeTransfer(type) => '/core/banking/transfers/single/$type';

  //coming soon
  static const String notifyEmail = '/core/members/notify-email-flag';
  static const String debitCards = '/core/banking/cards/options';
  static const String getEligibleTransferAccounts =
      '/core/banking/transfers/accounts';

  /// Credit Card
  static const String createDeserveUser =
      '/core/card/credit-card/create/user';
  static const String createCCApplication = '/core/card/apply/credit-card';
  static String validateBasicInformation(applicationID) =>
      '/core/card/applications/$applicationID/applicant/basic-info';
  static const String validateContactInformation =
      '/core/card/credit-card/applicant/contact-info';
  static String validateAddressInformation(applicationID) =>
      '/core/card/applications/$applicationID/applicant/address-info';
  static const String tokenizationSSN = '/core/card/deserve/tokenization';
  static String validateEmploymentStatus(applicationID) =>
      '/core/card/credit-card/applicant/$applicationID/employment-info';
  static const String validateExpenseInformation =
      '/core/card/credit-card/applicant/expense-info';
  static const String updateApplicantData =
      '/core/card/update/credit-card/applicant';
  static const String accApplicationStatus =
      '/core/card/credit-card/application/status';
  static const String accUpdatePullConsent =
      '/core/card/update/credit/pull/consent';

  // accept agreement
  static String productAgreementAccept(applicationID) =>
      '/core/members/applications/$applicationID/product-acceptance';

}
