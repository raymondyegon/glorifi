// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as Getx;
import 'package:glorifi/src/controllers/global_appstate_notifier.dart';
import 'package:glorifi/src/core/analytics.dart';
import 'package:glorifi/src/core/api/api_endpoints.dart';
import 'package:glorifi/src/core/api/rest_client.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/core/event_broadcaster.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/environment/environment.dart';
import 'package:glorifi/src/feature/banking/model/connected_account_model.dart';
import 'package:glorifi/src/feature/banking/model/glorifi_accounts_model.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/eligible_accounts_model.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_details_response_model.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_response_model.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_type.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/model/explore_data_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/greeting/weather_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/stories_prefab.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/story_model.dart';
import 'package:glorifi/src/feature/cockpit/models/loyalty_response.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_faq_response.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_response.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_dashboard_model.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/models/cc_funding_accounts_model.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/feature/highlights/highlight_model_prefabs.dart';
import 'package:glorifi/src/feature/insurance/model/base_response.dart';
import 'package:glorifi/src/feature/insurance/model/quote_response.dart';
import 'package:glorifi/src/feature/mortgage/model/state_data_model.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/model/enable_credit_score_smfa_response_model.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/model/initial_endable_credit_score_response_model.dart';
import 'package:glorifi/src/feature/policy_detail/model/policy_detail_response.dart';
import 'package:glorifi/src/model/ProfileUpdateResponse.dart';
import 'package:glorifi/src/model/credit_score_model.dart';
import 'package:glorifi/src/model/formatted_address.dart';
import 'package:glorifi/src/model/last_linked_account_info_model.dart';
import 'package:glorifi/src/model/linked_institutions_model.dart';
import 'package:glorifi/src/model/members_model.dart';
import 'package:glorifi/src/model/notification_models.dart';
import 'package:glorifi/src/model/personal_snapshot/net_worth_detail_model.dart';
import 'package:glorifi/src/model/personal_snapshot/savings_retirement_model.dart';
import 'package:glorifi/src/model/personal_snapshot/total_debt_detail_model.dart';
import 'package:glorifi/src/model/plaid_model.dart';
import 'package:glorifi/src/model/profile_model.dart';
import 'package:glorifi/src/model/quotes_model.dart';
import 'package:glorifi/src/model/support/faq_categories_model.dart';
import 'package:glorifi/src/model/unlink_institution_response.dart';
import 'package:glorifi/src/model/update_handler_model.dart';
import 'package:glorifi/src/model/zip_validation_response.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:provider/provider.dart';
import 'package:us_states/us_states.dart';

import '../../feature/insurance/model/insurance_category_model.dart';
import '../../feature/mortgage/model/mortgage_data.dart';
import '../../model/cash_on_hand_model.dart';
import '../../model/comparison_model.dart';
import '../../model/edit_comparison_model.dart';
import '../../model/support/faq_gem_model.dart';
import 'token_static.dart';

abstract class ApiHelper {
  //Login Apis
  Future<Either<CustomException, dynamic>> getPrediction(String inputString);

  Future<Either<CustomException, dynamic>> getAddress(double lat, double lng);

  Future<Either<CustomException, dynamic>> getFormattedAddress(String placeId);

  Future<Either<CustomException, dynamic>> getNewsFeedApi();

  Future<Either<CustomException, dynamic>> getRumbleVideos();

  Future<Either<CustomException, dynamic>> getInformationOfTheDay();

  Future<Either<CustomException, dynamic>> getNewsFeedWordPress();

  // Future<Either<CustomException, dynamic>> executeRecentCommunityUpdates();

  // Authentication
  Future<Either<CustomException, dynamic>> executeRegister(
      Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> getUserEmail();

  Future<Either<CustomException, dynamic>> validateEmail(String email);

  Future<Either<CustomException, dynamic>> sendOtp(String email);

  Future<Either<CustomException, dynamic>> sentOtpPhone();

  Future<Either<CustomException, dynamic>> verifyOtp(String email, String otp);

  Future<Either<CustomException, dynamic>> verifyOtpMobile(String otp);

  Future<Either<CustomException, dynamic>> getMortgagesBanners();

  Future<Either<CustomException, dynamic>> getInsuranceBanners();

  Future<Either<CustomException, dynamic>> getCreditCardBanner();

  Future<Either<CustomException, dynamic>> getCreditCards();

  Future<Either<CustomException, dynamic>> getMyPolicy();

  Future<Either<CustomException, dynamic>> getPendingQuotes();

  Future<Either<CustomException, dynamic>> getCreditCardFAQ();

  Future<Either<CustomException, dynamic>> getMortgages();

  Future<Either<CustomException, dynamic>> getCreditCardDetailData();

  Future<Either<CustomException, dynamic>> getInsuranceCategoryData();

  Future<Either<CustomException, dynamic>> getWeather(String latlong);

  Future<Either<CustomException, ApplicationStatusModel>>
      getApplicationStatus();

  Future<Either<CustomException, HighlightModel>> getCreditScoreHighlight();

  Future<Either<CustomException, HighlightModel>> getBankAccountHighlight();

  Future<Either<CustomException, HighlightModel>> getInsightsHighlight();

  Future<Either<CustomException, HighlightModel>> getProductsHighlight();

  Future<Either<CustomException, dynamic>> uploadImage(FormData imagePath);

  Future<Either<CustomException, dynamic>> getAccessTokenForOkta(
      String refreshToken);

  Future<Either<CustomException, dynamic>> getSupportFaq();

  Future<Either<CustomException, dynamic>> getNetWorthDetails();

  Future<Map> getCashOnHandNetWorthDetails();

  Future<Either<CustomException, dynamic>> getTotalDebt();

  Future<Either<CustomException, dynamic>> getConnectedAccounts();

  Future<Either<CustomException, dynamic>> getConnectedGloriFiAccounts();

  Future<Either<CustomException, dynamic>> getStockQuotes();

  Future<Either<CustomException, dynamic>> getTotalAccountsPersonalSnapshots();

  Future<Either<CustomException, dynamic>> verifyZipCode(String zipCode);

  Future<Either<CustomException, dynamic>> getCreditCardApplication();

  Future<Either<CustomException, dynamic>> savePrimaryAddress(
      Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> fetchAddress();

  Future<Either<CustomException, dynamic>> fetchMobileDepositLimit();

  Future<Either<CustomException, dynamic>> checkAddress();

  Future<Either<CustomException, dynamic>> getCashOnHandDetails();

  Future<Map> getCashOnHandDetailsVersion2();

  Future<Either<CustomException, dynamic>> getBankingBanner();

  Future<Either<CustomException, dynamic>> getNotifications();

  Future<Either<CustomException, dynamic>> markNotificationAsRead(
      Messages notification);

  Future<Either<CustomException, dynamic>> fetchStateList();

  Future<Either<CustomException, dynamic>> getLinkDataFlowData();

  Future<Either<CustomException, dynamic>> getComparison();

  Future<Either<CustomException, dynamic>> editComparison(
      Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> otpMobileVerificationSend();

  Future<Either<CustomException, dynamic>> otpVerificationResend();

  Future<Either<CustomException, dynamic>> otpVerificationVerify(
      {required String passCode});

  Future<Map> getRetirementSavings();

  Future<Either<CustomException, dynamic>> getUserProfile();

  Future<Either<CustomException, dynamic>> getGemsTree();

  Future<Either<CustomException, dynamic>> getGems(Map<String, dynamic> body);

  Future<Either<CustomException, dynamic>> editPreferredName(
      String _preferredName);

  Future<Either<CustomException, dynamic>> editPhoneNumber(String _phoneNumber);

  Future<Either<CustomException, dynamic>> editZipCode(String zipCode);

  Future<Either<CustomException, dynamic>> editPhoneNumberCode(
      String phoneNumber);

  Future<Either<CustomException, dynamic>> getPlaidLinkToken();

  Future<Either<CustomException, dynamic>> getAuthPlaidLinkToken();

  Future<Either<CustomException, dynamic>> getNextStory(
      {required int x, int storiesPerPage});

  Future<Either<CustomException, dynamic>> viewedContent(
      {required String contentId});

  Future<Either<CustomException, dynamic>> getPersoneticsInsights(
      Map<String, dynamic> header, Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> getPersoneticsQAInsights(
      Map<String, dynamic> header, Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> getCreditScore();

  Future<Either<CustomException, dynamic>> getMortgageStates(String product);

  Future<Either<CustomException, dynamic>> getSessionToken();

  Future<Either<CustomException, dynamic>> getMonthlyIncome();

  Future<Either<CustomException, dynamic>> postMonthlyIncome(int value);

  Future<Either<CustomException, dynamic>> getPolicyDetail(
      {required String id});

  Future<Either<CustomException, dynamic>> getExploreData();

  Future<Map> getFeatureFlags();
  Future<Map> legalDataRequest(bool requestToDelete);

  Future<Either<CustomException, dynamic>> getFaqRecommendation(
      {required final params});

  Future<Either<CustomException, dynamic>> updateScheduleInfo(
      Map<String, dynamic> params);

  Future<Either<CustomException, dynamic>> sendEmailToGenesys(
      Map<String, dynamic> params);

  Future<Either<CustomException, dynamic>> savePlaidToken(String token);

  Future<Either<CustomException, dynamic>> depositCheck(FormData data);

  Future<Either<CustomException, dynamic>> getHomeValueAddress(String addr_id);

  Future<Either<CustomException, dynamic>> getBindableReroute();

  Future<Either<CustomException, dynamic>> getMemberDetails();

  Future<Either<CustomException, dynamic>> getLastLinkedAccountInfo();

  Future<Either<CustomException, dynamic>> getLinkedPlaidAccounts();

  Future<Either<CustomException, dynamic>> unlinkPlaidInstitution(String id);

  Future<Either<CustomException, dynamic>> demoUserLogin();

  Future<Either<CustomException, dynamic>> getScheduleInformationResponse(
      String category);

  Future<Either<CustomException, dynamic>> getBundles();

  Future<Either<CustomException, dynamic>> getBundleDetails(String bundleName);

  Future<Either<CustomException, dynamic>> getFaqAnswer(String gemId);

  Future<Either<CustomException, dynamic>> getRewardsBalance();

  Future<Either<CustomException, dynamic>> getRewardsTier();

  Future<Either<CustomException, dynamic>> getRewardsSessionToken();

  Future<Map> awardLoyaltyPoints(String actionCode);

  Future<Either<CustomException, dynamic>> notifyEmail(
      String product, String state);

  Future<Either<CustomException, dynamic>> notifyEmailStatus(
      String product, String state);

  Future<Map> requestEarlyAccess(String product);

  Future<Either<CustomException, UpdateHandlerModel>> getAppVersion(
      Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> saveFundingAccountToken(
      String token, List accounts);

  Future<Map> getFundingAccounts();

  Future<Map> getCCFundingAccounts();

  Future<Map> getCheckingProducts();

  Future<Map> getSavingsProducts();

  Future<Map> getCDProducts();

  Future<Map> getDebitCards();

  Future<Map> orderDebitCard(String cardId, Map<String, dynamic> payload);

  Future<Map> createBankingUser(Map<String, dynamic> payload);

  Future<Map> submitApplication(String productCode);
  Future<Map> submitApplicationAndMakeDeposit(
    String productCode,
    Map<String, dynamic> body,
  );

  Future<dynamic> verifyAddress(PartialAddress address);

  Future<dynamic> makeDepositIncoming(
      {required double amount,
      required String acctId,
      required String linkedAccountId});

  Future<dynamic> makeDepositInternal(
      {required double amount,
      required String acctId,
      required String linkedAccountId});

  Future<Map> getExistingBankingUser();

  Future<Map> getAccountDetails(String id);
  Future<Map> getAccountTransactions(String id, int start, int limit);
  Future<Map> getStatements(String id);

  Future<Map> getProductDisclosures(String productCode);
  Future<Map> cardTransition(String cardId, String transitionString);
  Future<Map> getChangePinCredentials(String id);
  Future<Map?> getCreditCardAccount();
  Future<Map> getCCTransactions(int loadMoreIndex);

  Future<Either<CustomException, dynamic>> getEligibleTransferAccounts();
  Future<Map> makeTransfer(String transferType, Map<String, dynamic> body);
  Future<InitialEnableCreditScoreResponseModel?> initiateEnableCreditScore(
      Map<String, dynamic> body);
  Future<EnableCreditScoreSmfaResponseModel?> enableCreditScoreSMFASendUrl();

  /// Credit Card
  Future<Either<CustomException, dynamic>> createDeserveUser(
      Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> createCCApplication(
      Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> getACCApplicationStatus(
      applicationID);

  Future<Either<CustomException, dynamic>> validateBasicInformation(
      applicationID, Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> validateContactInformation(
      applicationID, Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> validateAddressInformation(
      applicationID, Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> tokenizationSSN(
      Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> validateEmploymentStatus(
      applicationID, Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> validateExpenseInformation(
      applicationId, Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> updateApplicantData(
      applicationId, Map<String, dynamic> data);

  Future<Either<CustomException, dynamic>> accUpdatePullConsent(
      applicationId, Map<String, dynamic> data);

  Future<Map> getSavingsCheckingDetail(String type);
  Future<Map> getThirtyDayDetails(String id);
  Future<Map> ccSchedulePayment(
      DateTime paymentDate, String methodId, double amount, String accountId);

  Future<Map> ccScheduleAutoPayment(String methodId, double? amount,
      String accountId, CCPaymentType paymentType, int autoPayDate);

  Future<Map> ccCreateACHPayment(
      String accountId, CCFundingAccountModel selectedFundingAccount);

  Future<Either<CustomException, dynamic>> acceptCardHolderAgreement(
      applicationID, Map<String, dynamic> data);
}

class ApiHelperImpl extends ApiHelper {
  ApiHelperImpl({
    required this.api,
    required this.googleClient,
  });

  final RestClient api;
  final RestClient googleClient;

  final String ocpApimSubscriptionKey = Environment().config.apiSubscriptionKey;

  @override
  Future<Either<CustomException, dynamic>> executeRegister(
      Map<String, dynamic> data) async {
    try {
      final response =
          await api.post(Api.public, ApiEndPoints.coreMembersApiUrl, data);
      String memberId = response.data['data']['id'] as String;

      return Right(memberId);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> validateEmail(String email) async {
    try {
      final response =
          await api.get(Api.public, ApiEndPoints.validateEmailUri + email);
      return Right(jsonDecode(response.data)["data"]['is-valid'] as String?);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getAddress(
      double lat, double lng) async {
    String path = "geocode/json?latlng=" +
        lat.toString() +
        "," +
        lng.toString() +
        "&key=" +
        ApiEndPoints.googleMapApiKey;

    FormattedAddress formattedAddress = FormattedAddress();
    try {
      final response = await googleClient.get(Api.public, path);
      formattedAddress = FormattedAddress.fromJson(response.data["results"][0]);
      formattedAddress.formattedAddress =
          response.data["results"][0]["formatted_address"];
      return Right(formattedAddress);
    } on CustomException catch (e) {
      Log.error(e.errorMessage);
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getFormattedAddress(
      String placeId) async {
    String path = "place/details/json?fields=address_components&place_id=" +
        placeId +
        "&key=" +
        ApiEndPoints.googleMapApiKey;
    try {
      final resp = await googleClient.get(Api.public, path);
      return Right(FormattedAddress.fromJson(resp.data["result"]));
    } on CustomException catch (e) {
      Log.error(e.errorMessage);
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getPrediction(
      String inputString) async {
    String path = ApiEndPoints.placeAutoComplete +
        inputString +
        ApiEndPoints.googleMapCountry +
        ApiEndPoints.googleMapApiKey;
    List<FormattedAddress> returnResult = [];
    try {
      final response = await googleClient.get(Api.public, path);
      for (var e in response.data["predictions"]) {
        final res = await getFormattedAddress(e["place_id"]);
        res.fold((l) {
          Log.error(l.errorMessage);
        }, (r) {
          FormattedAddress formattedAddress = r;
          formattedAddress.formattedAddress = e["description"];
          returnResult.add(formattedAddress);
        });
      }
      return Right(returnResult);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getMortgages() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getMortgageList);
      final data = MortgageDataResponse.fromJson(response.data);
      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> uploadImage(
      FormData imagePath) async {
    try {
      final response = await api.postFormData(
          Api.protected, ApiEndPoints.profileUrl, imagePath, headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': TokenStatic.token
      });
      return Right(response.data['message'] as String?);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getAccessTokenForOkta(
      String refreshToken) async {
    return _getAccessTokenFromRefreshToken(refreshToken);
  }

  Future<Either<CustomException, dynamic>> _getAccessTokenFromRefreshToken(
      String refreshToken) async {
    final header = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    };
    final bindIDClient = Environment().config.bindIDClient;

    final data = {
      "grant_type": "refresh_token",
      "scope": "offline_access openid",
      "refresh_token": refreshToken,
      "client_id": bindIDClient
    };

    try {
      final response = await api
          .post(Api.public, ApiEndPoints.getTokenUrl, data, headers: header);
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getNewsFeed() {
    // ignore: todo
    // TODO: implement getNewsFeed
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getInformationOfTheDay() {
    // ignore: todo
    // TODO: implement getInformationOfTheDay
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getNewsFeedApi() {
    // ignore: todo
    // TODO: implement getNewsFeedApi
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getNewsFeedWordPress() {
    // ignore: todo
    // TODO: implement getNewsFeedWordPress

    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getMortgagesBanners() {
    // ignore: todo
    // TODO: implement getMortgagesBanners
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> getRumbleVideos() {
    // ignore: todo
    // TODO: implement getRumbleVideos
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> getCreditCardBanner() {
    // ignore: todo
    // TODO: implement getCreditCardBanner
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getCreditCards() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getCreditCardsList);
      final data = CreditCardResponse.fromJson(response.data);
      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getCreditCardDetailData() {
    // ignore: todo
    // TODO: implement getCreditCardDetailData
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getCreditCardFAQ() {
    try {
      final response = CreditCardFAQResponse.fromJson({
        "data": {
          "description":
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut dictum turpis. Maecenas commodo, lacus vel fermentum lobortis, erat sem sagittis tellus, at laoreet metus urna id ante. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut dictum turpis. Maecenas commodo, lacus vel fermentum lobortis, erat sem sagittis tellus, at laoreet metus urna id ante. ",
          "card_type": "Brass Card",
          "title": "This card looks great\nwith your name on it",
          "questions": [
            {
              "question": "Do I qaulified for this card",
              "answer":
                  "You need a credit score of 680 or higher to qaulify for this card. You need a credit score of 680 or higher to qaulify for this card.",
            },
            {
              "question": "Does this card offer cash back?",
              "answer":
                  "You need a credit score of 680 or higher to qaulify for this card. You need a credit score of 680 or higher to qaulify for this card.",
            },
          ]
        }
      });
      return Future.delayed(Duration(milliseconds: 200), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getInsuranceCategoryData() {
    try {
      final response = InsuranceCategoryModel.fromJson({
        "data": [
          {
            "name": "Property",
            "items": [
              {
                "id": 1,
                "categoryName": "Homeowner’s Insurance",
                "icon": "assets/icons/home_icon.svg",
                "vendor": "unqork",
                "params": "ho3",
                "vendorUrl":
                    "${Urls.unqorkAuthUrl}?${Urls.unqorkHomeownerParams}",
                "bindableUrl":
                    "${Urls.bindableQuoteBaseUrl}${Urls.bindableHomePath}"
              },
              {
                "id": 2,
                "categoryName": "Condo Insurance",
                "icon": "assets/icons/ico_condo_insurance.svg",
                "params": "ho6",
                "vendor": "unqork",
                "vendorUrl": "${Urls.unqorkAuthUrl}?${Urls.unqorkCondoParams}",
                "bindableUrl":
                    "${Urls.bindableQuoteBaseUrl}${Urls.bindableHomePath}"
              },
              {
                "id": 3,
                "categoryName": "Renter’s Insurance ",
                "icon": "assets/icons/renters_icon.svg",
                "params": "ho4",
                "vendor": "unqork",
                "vendorUrl": "${Urls.unqorkAuthUrl}?${Urls.unqorkRenterParams}",
                "bindableUrl":
                    "${Urls.bindableQuoteBaseUrl}${Urls.bindableRentersPath}"
              },
              {
                "id": 4,
                "categoryName": "Flood Insurance ",
                "icon": "assets/icons/flood_icon.svg",
                "vendor": "bindable",
                "vendorUrl":
                    "${Urls.bindableInsureBaseUrl}${Urls.bindableFloodPath}"
              }
            ]
          },
          {
            "name": "Vehicle",
            "items": [
              {
                "id": 1,
                "categoryName": "Auto Insurance",
                "icon": "assets/icons/auto_insurance_icon.svg",
                "params": "ao1",
                "vendor": "unqork",
                "vendorUrl": "${Urls.unqorkAuthUrl}?${Urls.unqorkAutoParams}",
                "bindableUrl":
                    "${Urls.bindableQuoteBaseUrl}${Urls.bindableAutoPath}"
              },
              {
                "id": 2,
                "categoryName": "Motorcycle Insurance ",
                "icon": "assets/icons/motorcycle_icon.svg",
                "vendor": "bindable",
                "vendorUrl":
                    "${Urls.bindableQuoteBaseUrl}${Urls.bindableMotorcyclePath}"
              },
              {
                "id": 3,
                "categoryName": "Boat Insurance",
                "icon": "assets/icons/watercraft_icon.svg",
                "vendor": "bindable",
                "vendorUrl":
                    "${Urls.bindableInsureBaseUrl}${Urls.bindableBoatPath}"
              }
            ]
          },
          {
            "name": "Personal",
            "items": [
              {
                "id": 1,
                "categoryName": "Pet Insurance",
                "icon": "assets/icons/pet_insurance_icon.svg",
                "vendor": "bindable",
                "vendorUrl":
                    "${Urls.bindableInsureBaseUrl}${Urls.bindablePetPath}"
              },
              // {
              //   "id": 2,
              //   "categoryName": "Term Life Insurance",
              //   "icon": "assets/icons/life_insurance_icon.svg",
              //   "vendor": "vanepps",
              //   "vendorUrl": Environment().config.vanEppsUrl
              // },
              {
                "id": 3,
                "categoryName": "Umbrella Insurance",
                "icon": "assets/icons/umbrella_icon.svg",
                "vendor": "bindable",
                "vendorUrl":
                    "${Urls.bindableInsureBaseUrl}${Urls.bindableUmbrellaPath}"
              }
            ]
          }
        ]
      });
      return Future.delayed(Duration(seconds: 0), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 0), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getMyPolicy() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getPolicyHeaders);
      return Right(BaseResponse.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getInsuranceBanners() {
    // ignore: todo
    // TODO: implement getInsuranceBanners
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> sendOtp(String email) async {
    final payload = {
      "email": email,
    };

    return _sendOrVerifyOtp(payload);
  }

  @override
  Future<Either<CustomException, dynamic>> verifyOtp(
      String email, String otp) async {
    final payload = {
      'email': email,
      "passCode": otp,
    };

    return _sendOrVerifyOtp(payload);
  }

  Future<Either<CustomException, dynamic>> _sendOrVerifyOtp(
      Map<String, dynamic> payload) async {
    try {
      final response =
          await api.post(Api.public, ApiEndPoints.sendOtpUrl, payload);
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> sentOtpPhone() async {
    try {
      final response =
          await api.post(Api.protected, ApiEndPoints.sentOtpPhoneUrl, {});
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getSupportFaq() {
    // TODO: implement getSupportFaq
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getTotalAccountsPersonalSnapshots() {
    // TODO: implement getTotalAccountsPersonalSnapshots
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getNetWorthDetails() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.getNetWorth);

      final data = NetWorthDetailModel.fromJson(response.data['data']);
      return Future.delayed(Duration(seconds: 0), () => Right(data));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 0), () => Left(e));
    }
  }

  @override
  Future<Map> getCashOnHandNetWorthDetails() async {
    final response =
        await api.get(Api.protected, ApiEndPoints.netWorthVersion2);
    return response.data;
  }

  @override
  Future<Either<CustomException, dynamic>> getTotalDebt() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.getTotalDebt);

      final data = TotalDebtDetailModel.fromJson(response.data['data']);
      return Future.delayed(Duration(seconds: 1), () => Right(data));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getStockQuotes() async {
    String token =
        'eyJraWQiOiJjUkVfbzJkMkFUV2Y1RW1vd3A0c3V3T3U5MXFlUm41czJKeHYwYVZYQXBzIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULkp2OFg1ODNBVjVRRkRNeTlFajEzY1VKZk9WelA0QmR2TjZudG81Tmw0V2sub2FyaHF3Nnp2VnBwT1B3czcxZDYiLCJpc3MiOiJodHRwczovL2dsb3JpZmlzYW5kYm94Lm9rdGFwcmV2aWV3LmNvbS9vYXV0aDIvYXVzMmVoMXUxOWxhT3ZsV00xZDciLCJhdWQiOiJhcGk6Ly9kZWZhdWx0IiwiaWF0IjoxNjQ0ODUzNDAxLCJleHAiOjE2NDQ4NTcwMDEsImNpZCI6IjBvYTJpb3FqZGlvRjlhSGpoMWQ3IiwidWlkIjoiMDB1MmdqOTVvZW5sQXJNMmYxZDciLCJzY3AiOlsib2ZmbGluZV9hY2Nlc3MiLCJvcGVuaWQiXSwic3ViIjoiam9obi5kb2QxMjRAZXhhbXBsZS5jb20iLCJ1dWlkIjoiZmIxZDgwZWUtODNmZi0xMWVjLTg0M2MtOTRlNzBiNzVkYWU2In0.ZyaN8cNWjrHQ9NARKnmIJZ7lZFV5t6wY4I9dJlgJy6Fbhp6vXgfHnn1fzOXP8JM_a3qxbAeYnswM31mlpn45q6zMtVDSUtDM2ZpjCV9PXGiBPG7Wo7FySGQjDYFA5pPpn3e3M0LUeBlLWYVv_QduZEiMMepqPujX2ZwX69MtGMRfmT-pRLT-JPk1dGhdjjpEN5j__1NinKu8Nxp_Hm9-9R4le1CEXHxKil0MHjRWSs3u8x9oVH9dZYh-H_HG38lu2wWX7pBwd7rMlvAJJuVB_MC9EJHAr25vESa59H_5XiUj3L73lEwXoOugtZt_R00mAcjDXxRZ_HldOWjGZTsvrw';
    try {
      final response = await api.get(
        Api.public,
        ApiEndPoints.getStockQuotes,
        headers: {
          'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey,
          'Authorization': 'Bearer $token',
        },
      );
      return Right(QuotesResponseModel.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getConnectedAccounts() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getConnectedAccounts);
      final data = ConnectedAccountModel.fromJson(response.data);
      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getConnectedGloriFiAccounts() async {
    try {
      final response = await api.get(
          Api.protected, ApiEndPoints.getConnectedGloriFiAccounts);
      if (response.statusCode == 204) {
        return Right(GlorifiAccountResponse.noAccountsResponse);
      }
      final data = GlorifiAccountResponse.fromJson(response.data["data"]);
      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getWeather(String latlong) async {
    try {
      Map<String, dynamic> map = {"lat_lon": latlong};
      final response = await api.post(Api.protected, ApiEndPoints.weather, map);
      return Right(WeatherModel.fromJson(response.data["data"]["weather"]));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, ApplicationStatusModel>>
      getApplicationStatus() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.applicationStatus);
      return Right(ApplicationStatusModel.fromJson(response.data["data"]));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, HighlightModel>> getProductsHighlight() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.productHighlight);

      // filter out products we don't want to show
      // then choose a product randomly
      String product_key = ((Map.from(response.data["data"])
            ..removeWhere((k, v) => v == false))
          .keys
          .toList()
        ..shuffle())[0];

      var models = {
        "credit_card": HighlightPrefabs.CreditCard,
        "checking": HighlightPrefabs.ApplyChecking,
        "savings": HighlightPrefabs.ApplySavings,
        "home_insurance": HighlightPrefabs.HouseInsurance,
        "pet_insurance": HighlightPrefabs.PetInsurance,
        "link_account": HighlightPrefabs.LinkBankAccount2,
        "insurance": HighlightPrefabs.QuickQuote
      };

      return Right(models[product_key]!);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, HighlightModel>>
      getCreditScoreHighlight() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.creditScore);

      var data = response.data["data"];
      return Right(data["enabled"] == true
          ? CreditScoreHighlightModel.fromJson(data)
          : HighlightPrefabs.CheckCreditScore);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, HighlightModel>> getInsightsHighlight() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.bankAccountHighlight);
      var data = response.data["data"];
      return Right(data["linked_accounts"] == true
          ? HighlightPrefabs.Insights
          : HighlightPrefabs.LinkInsights);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, HighlightModel>>
      getBankAccountHighlight() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.bankAccountHighlight);
      var data = response.data["data"];
      return Right(data["linked_accounts"] == true
          ? BankAccountHighlightModel.fromJson(data)
          : HighlightPrefabs.LinkBankAccount);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> verifyZipCode(String zipCode) async {
    try {
      final response =
          await api.get(Api.public, ApiEndPoints.validateZipCodeUri + zipCode);

      var zipValidationResponse = ZipValidationResponse.fromJson(response.data);

      return Right(zipValidationResponse.data?.isValid == "true");
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getCashOnHandDetails() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.getCashOnHand);
      return Right(CashOnHandModel.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Map> getCashOnHandDetailsVersion2() async {
    final response =
        await api.get(Api.protected, ApiEndPoints.cashOnHandVersion2);
    return response.data;
  }

  Future<Map> getRetirementSavings() async {
    final response =
        await api.get(Api.protected, ApiEndPoints.retirementSavings);
    return response.data;
  }

  Future<Either<CustomException, dynamic>> getBankingBanner() {
    // TODO: implement getBankingBanner
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> markNotificationAsRead(
      Messages notification) async {
    try {
      final payload = {'message_id': notification.messageId};
      final response =
          await api.put(Api.protected, "/core/read_message", data: payload);
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> savePrimaryAddress(
      Map<String, dynamic> data) async {
    try {
      final response = await api.post(
        Api.protected,
        ApiEndPoints.saveAddress,
        data,
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> fetchAddress() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.fetchAddress,
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getNotifications() async {
    try {
      final response = await api.get(
        Api.protected,
        "/core/messages",
      );
      return Right(NotificationModels.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> checkAddress() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.checkAddress,
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getComparison() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.getComparison);
      return Right(ComparisonModel.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> editComparison(
      Map<String, dynamic> data) async {
    try {
      final response =
          await api.post(Api.protected, ApiEndPoints.postComparisonInfo, data);
      return Right(EditComparisonModel.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getLinkDataFlowData() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.accountsFlag,
      );

      var data = response.data;

      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> fetchStateList() async {
    // TODO: implement fetchStateList
    try {
      final response = await api.get(
        Api.public,
        ApiEndPoints.fetchState,
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getCreditCardApplication() async {
    try {
      final response = await api.get(
          Api.protected, ApiEndPoints.getCreditCardApplicationsList);
      final data = MortgageDataResponse.fromJson(response.data);
      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getFAQCategories() {
    // TODO: implement getFAQCategories
    throw UnimplementedError();
  }

  // Future<Either<CustomException, dynamic>> getSavingsRetirement() async {
  //   try {
  //     final response =
  //         await api.get(Api.protected, ApiEndPoints.getRetirementSavings);

  //     final data = SavingsRetirementModel.fromJson(response.data['data']);

  //     return Future.delayed(Duration(seconds: 1), () => Right(data));
  //   } on CustomException catch (e) {
  //     return Future.delayed(Duration(seconds: 1), () => Left(e));
  //   }
  // }

  @override
  Future<Either<CustomException, dynamic>> getUserProfile() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.profileUrl);
      final profile = ProfileModel.fromJson(response.data["data"][0]);
      return Right(profile);
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getGemsTree() async {
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAxRlpaS1FRMjc3R1NRWThDSlFXTTJROEo0IiwidXNlciI6eyJpZCI6InNlcnZpY2UtNDQwZjk4MGUtZGY1NS00NTk4LWI2MjAtMWFhNTk3MmJmYTk5IiwiYWNjb3VudElkIjoiYzE5MjFhMWYtMDE4Ni00MjZiLWIyMTUtMzdmMGNjODQ0YTVhIiwic3ViZG9tYWluIjoiZ2xvcmlmaSJ9LCJpYXQiOjE2NDkyNTQ1ODcsImV4cCI6NDgwNTAxNDU4N30.GEqA14OrzvGd614zSZCjfoBhzmf1MlHD63EMRgx7i_Y';

    try {
      final response = await api.get(
        Api.public,
        ApiEndPoints.getLibraries,
        headers: {
          'Authorization': token,
        },
      );

      return Right(FAQCategoriesResponseModel.fromJson(response.data));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getGems(
      Map<String, dynamic> body) async {
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAxRlpaS1FRMjc3R1NRWThDSlFXTTJROEo0IiwidXNlciI6eyJpZCI6InNlcnZpY2UtNDQwZjk4MGUtZGY1NS00NTk4LWI2MjAtMWFhNTk3MmJmYTk5IiwiYWNjb3VudElkIjoiYzE5MjFhMWYtMDE4Ni00MjZiLWIyMTUtMzdmMGNjODQ0YTVhIiwic3ViZG9tYWluIjoiZ2xvcmlmaSJ9LCJpYXQiOjE2NDkyNTQ1ODcsImV4cCI6NDgwNTAxNDU4N30.GEqA14OrzvGd614zSZCjfoBhzmf1MlHD63EMRgx7i_Y';
    try {
      final response = await api.post(
        Api.public,
        ApiEndPoints.searchGems,
        body,
        headers: {
          'Authorization': token,
        },
      );

      return Right(GemModel.fromJson(response.data['data']['results']));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getPlaidLinkToken() async {
    try {
      final response = await api.get(
        Api.protected,
        Provider.of<GlobalAppStateNotifier>(Getx.Get.context!, listen: false)
            .plaidLinkToken,
      );
      return Right(PlaidModel.fromJson(response.data));
    } on CustomException catch (e) {
      Log.error(e.errorMessage);
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getAuthPlaidLinkToken() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.plaidAuthLinkToken,
      );
      return Right(PlaidModel.fromJson(response.data));
    } on CustomException catch (e) {
      Log.error(e.errorMessage);
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getUserEmail() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.coreMembersApiUrl);
      return Right(MembersModels.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> editPreferredName(
      String _preferredName) async {
    try {
      final response = await api.patch(
          Api.protected,
          ApiEndPoints.coreMembersApiUrl + "/edit",
          {"preferred_name": _preferredName});
      var preferredNameUpdate = ProfileUpdateResponse.fromJson(response.data);

      return Right(preferredNameUpdate.success);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> editPhoneNumber(
      String _phoneNumber) async {
    try {
      final response = await api.patch(
          Api.protected,
          ApiEndPoints.coreMembersApiUrl + "/edit",
          {"phone_number": _phoneNumber});
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> editZipCode(String zipCode) async {
    try {
      final response = await api.patch(
        Api.protected,
        ApiEndPoints.coreMembersApiUrl + "/edit",
        {"address_postal_code": zipCode},
      );

      var zipUpdate = ProfileUpdateResponse.fromJson(response.data);

      return Right(zipUpdate.success);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> otpMobileVerificationSend() async {
    try {
      final response = await api.post(
          Api.protected, ApiEndPoints.otpMobileVerificationSend, {},
          headers: {'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey});
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> otpVerificationResend() async {
    try {
      final response = await api.post(
          Api.protected, ApiEndPoints.otpVerificationResend, {},
          headers: {'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey});
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> otpVerificationVerify(
      {required String passCode}) async {
    try {
      final response = await api.post(
        Api.protected,
        ApiEndPoints.otpVerificationVerify,
        {'passCode': passCode},
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> viewedContent(
      {required String contentId}) async {
    try {
      final response = await api.post(
        Api.protected,
        ApiEndPoints.viewedContent,
        {},
        queryParams: {'content_id': contentId},
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getNextStory(
      {required int x, int storiesPerPage: 1}) async {
    _getStoryModel(story) {
      _wrap(Function function, json) {
        try {
          return function(json);
        } catch (e) {
          return StoryModel(type: StoryType.ServerError);
        }
      }

      switch (story["type"]) {
        case "video":
          if (story["secondary"] == null) {
            return _wrap(
                (json) => VideoStoryModel.fromJson(json), story["hero"]);
          } else {
            return _wrap((json) => MultiVideoStoryModel.fromJson(json), story);
          }
        case "article":
          if (story["secondary"] == null) {
            return _wrap(
                (json) => ArticleStoryModel.fromJson(json), story["hero"]);
          } else {
            return _wrap(
                (json) => MultiArticleStoryModel.fromJson(json), story);
          }
        case "fact":
          return _wrap((json) => FactStoryModel.fromJson(json), story);
        case "quote":
          return _wrap((json) => QuoteStoryModel.fromJson(json), story);
        case "product":
          return _wrap((json) => ProductStoryModel.fromJson(json), story);
        case "invite":
          return StoryPrefabs.Referral;
      }
    }

    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getNextStory,
        data: {'offset': x, 'storiesPerPage': storiesPerPage},
      );

      if (response.data['data']["stories"].length == 0 ||
          x > response.data['data']["meta"]['totalStories']) {
        return Right([StoryPrefabs.LastStory]);
      }

      List stories = response.data['data']["stories"];
      return Right(stories.map(_getStoryModel).toList());
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  Future<Either<CustomException, dynamic>> getPersoneticsInsights(
      Map<String, dynamic> header, Map<String, dynamic> data) async {
    try {
      final response = await api.post(
        Api.public,
        ApiEndPoints.insights,
        data,
        headers: header,
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getPersoneticsQAInsights(
      Map<String, dynamic> header, Map<String, dynamic> data) async {
    try {
      final response = await api.post(
        Api.public,
        ApiEndPoints.insightsQA,
        data,
        headers: header,
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, CreditScoreModel>> getCreditScore() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.get_credit_score);
      return Right(CreditScoreModel.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> verifyOtpMobile(String otp) async {
    try {
      final payload = {
        "passCode": otp,
      };

      final response = await api.post(
        Api.protected,
        ApiEndPoints.verifyOtpMobile,
        payload,
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> editPhoneNumberCode(
      String phoneNumber) async {
    try {
      final response = await api.patch(
        Api.protected,
        ApiEndPoints.coreMembersApiUrl + "/edit",
        {"phone_number": phoneNumber},
      );

      var phoneUpdate = ProfileUpdateResponse.fromJson(response.data);

      return Right(phoneUpdate.success);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, LoyaltyResponse>> getLoyalty() async {
    final url = ApiEndPoints.coreApiUrl + '/loyalty';
    try {
      final extraHeader = {
        'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey,
      };

      final response = await api.get(
        Api.protected,
        url,
        headers: extraHeader,
      );
      var loyaltyResponse = LoyaltyResponse.fromJson(response.data);
      return Right(loyaltyResponse);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Map> awardLoyaltyPoints(String actionCode) async {
    final res = await api.post(
      Api.protected,
      ApiEndPoints.earnRewards(actionCode),
      {},
    );
    return res.data;
  }

  @override
  Future<Either<CustomException, dynamic>> getMortgageStates(
      String product) async {
    try {
      final response = await api.post(Api.protected,
          ApiEndPoints.getMortgageStateList, {"product_name": product});
      return Right(StateDataResponse.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getSessionToken() async {
    try {
      final response =
          await api.post(Api.protected, ApiEndPoints.getSessionTokenUrl, {});
      Log.debug(response);
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getMonthlyIncome() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getMonthlyIncome);

      var incomeAmount = 0;

      if (response.data['status'] == "Success") {
        incomeAmount = int.parse(response.data['data']['income_amount']);
      }

      return Right(incomeAmount);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> postMonthlyIncome(value) async {
    try {
      final payload = {
        "reported_monthly_income": value,
      };

      final response = await api.post(
          Api.protected, ApiEndPoints.postMonthlyIncome, payload,
          headers: {
            'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey,
          });

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getPolicyDetail(
      {required String id}) async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getPolicyDetail + "/$id",
      );
      final PolicyDetailResponse policyDetailResponse =
          PolicyDetailResponse.fromJson(response.data);
      return Right(policyDetailResponse);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getExploreData() async {
    try {
      final exploreDataJson = {
        "data": [
          {
            "category": "Open an Account",
            "contents": [
              {
                "title": "Checking",
                "asset": GlorifiAssets.banking,
                "showSubtitle": false,
                "route": Routes.myBanking
              },
              {
                "title": "Savings",
                "asset": GlorifiAssets.savings,
                "showSubtitle": false,
                "route": Routes.myBanking
              },
              {
                "title": "Certificate of Deposit",
                "asset": GlorifiAssets.cash,
                "showSubtitle": false,
                "route": Routes.myBanking
              },
              {
                "title": "Insurance",
                "asset": GlorifiAssets.shield,
                "showSubtitle": false,
                "route": Routes.insuranceScreen
              },
              {
                "title": "Mortgage",
                "asset": GlorifiAssets.home,
                "showSubtitle": false,
                "route": Routes.mortgage
              }
            ]
          },
          {
            "category": "GloriFi Bundles",
            "desc": "When you bundle multiple products you get more benefits. ",
            "contents": [
              {
                "title": "Homefront",
                "subtitle": "Most Savings",
                "asset": GlorifiAssets.smart_home,
                "showSubtitle": false,
                "route": Routes.bundlesScreen,
                "args": BundleTypeExtension.toBundleTypeString(
                    BundleType.HomeFront),
              },
              {
                "title": "Protect",
                "subtitle": "Most Secure",
                "asset": GlorifiAssets.shieldLock,
                "showSubtitle": false,
                "route": Routes.bundlesScreen,
                "args":
                    BundleTypeExtension.toBundleTypeString(BundleType.Protect),
              },
              {
                "title": "Heroes",
                "subtitle": "Most popular",
                "asset": GlorifiAssets.bolt,
                "showSubtitle": false,
                "route": Routes.bundlesScreen,
                "args":
                    BundleTypeExtension.toBundleTypeString(BundleType.Heroes),
              }
            ]
          },
        ]
      };
      final exploreDataResponse = ExploreDataModel.fromJson(exploreDataJson);
      return Right(exploreDataResponse.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Map> getFeatureFlags() async {
    final res = await api.get(Api.protected, ApiEndPoints.getFeatureFlags);
    return res.data;
  }

  @override
  Future<Map> legalDataRequest(bool requestToDelete) async {
    final res = await api.post(
        Api.protected, ApiEndPoints.legalDataRequest(requestToDelete), {});
    return res.data;
  }

  @override
  Future<Either<CustomException, dynamic>> getPendingQuotes() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getQuotesHeaders);
      return Right(QuoteResponse.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getFaqRecommendation(
      {required final params}) async {
    try {
      final response = await api.post(
        Api.public,
        ApiEndPoints.faqRecommendations,
        params,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAxRlpaS1FRMjc3R1NRWThDSlFXTTJROEo0IiwidXNlciI6eyJpZCI6InNlcnZpY2UtNDQwZjk4MGUtZGY1NS00NTk4LWI2MjAtMWFhNTk3MmJmYTk5IiwiYWNjb3VudElkIjoiYzE5MjFhMWYtMDE4Ni00MjZiLWIyMTUtMzdmMGNjODQ0YTVhIiwic3ViZG9tYWluIjoiZ2xvcmlmaSJ9LCJpYXQiOjE2NDkyNTQ1ODcsImV4cCI6NDgwNTAxNDU4N30.GEqA14OrzvGd614zSZCjfoBhzmf1MlHD63EMRgx7i_Y'
        },
      );
      return Right(response.data['data']);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> savePlaidToken(String token) async {
    try {
      final response =
          await api.post(Api.protected, ApiEndPoints.savePlaidToken, {
        "public_token": token,
      });

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> saveFundingAccountToken(
      String token, List accounts) async {
    try {
      final response =
          await api.post(Api.protected, ApiEndPoints.saveFundingAccountToken, {
        "public_token": token,
        "accounts": accounts,
      });

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> updateScheduleInfo(
      Map<String, dynamic> params) async {
    try {
      final response = await api.post(
        Api.public,
        ApiEndPoints.sendFaqEmailToGenesys,
        params,
        headers: {'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey},
      );

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> depositCheck(FormData data) async {
    try {
      final response = await api.postFormData(
        Api.public,
        ApiEndPoints.depositCheck,
        data,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      );
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> fetchMobileDepositLimit() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.depositCheckLimit);
      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getHomeValueAddress(
      String addr_id) async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getHomeValueAddress(addr_id),
      );

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getBindableReroute() async {
    try {
      final response = await api.post(
        Api.protected,
        ApiEndPoints.getBindableReroute,
        {},
        headers: {'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey},
      );

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getScheduleInformationResponse(
      String? category) async {
    try {
      final response = await api.get(
        Api.public,
        '${ApiEndPoints.getScheduleInformation}$category?showbrief=false',
        headers: {'Ocp-Apim-Subscription-Key': ocpApimSubscriptionKey},
      );

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getMemberDetails() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getMemberDetails,
      );

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getLastLinkedAccountInfo() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getLastConnectedAccountInfo,
      );

      return Right(LastLinkedAccountInfoModel.fromJson(response.data['data']));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  /// Used solely for aiding the Apple Review team to authenticate into the app without Transmit authentication
  @override
  Future<Either<CustomException, dynamic>> demoUserLogin() async {
    try {
      final queryParam = {
        'username': "demo@applereviewer.com",
        'password': 'H1ghlyC@mplex'
      };

      final response = await api.post(
          Api.public, ApiEndPoints.demoUserLoginUrl, {},
          queryParams: queryParam);

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DefaultException(401, ''));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getLinkedPlaidAccounts() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getLinkedPlaidAccounts,
      );

      print('response.dataresponse.data ${response.data['data']}');

      return Right(LinkedInstitutionsModel.fromJson(response.data['data']));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> unlinkPlaidInstitution(
      String id) async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.unlinkPlaidInstitution(id),
      );

      Map<String, dynamic> dataMap = response.data;
      final isSuccess = dataMap['success'];
      if (isSuccess) {
        EventBroadcaster.instance.addEvent(AccountsChangedEvent());
      }
      return Right(UnlinkInstitutionResponse.fromJson(response.data));
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getBundles() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.getBundles);
      final data = BundleResponseModel.fromJson(response.data);
      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getBundleDetails(
      String bundleName) async {
    try {
      final response = await api.get(
        Api.protected,
        "${ApiEndPoints.getBundleDetails}$bundleName",
      );
      final data = BundleDetailsResponseModels.fromJson(response.data);
      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getFaqAnswer(String gemId) async {
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAxRlpaS1FRMjc3R1NRWThDSlFXTTJROEo0IiwidXNlciI6eyJpZCI6InNlcnZpY2UtNDQwZjk4MGUtZGY1NS00NTk4LWI2MjAtMWFhNTk3MmJmYTk5IiwiYWNjb3VudElkIjoiYzE5MjFhMWYtMDE4Ni00MjZiLWIyMTUtMzdmMGNjODQ0YTVhIiwic3ViZG9tYWluIjoiZ2xvcmlmaSJ9LCJpYXQiOjE2NDkyNTQ1ODcsImV4cCI6NDgwNTAxNDU4N30.GEqA14OrzvGd614zSZCjfoBhzmf1MlHD63EMRgx7i_Y';
    try {
      final response = await api.get(
        Api.public,
        '${ApiEndPoints.getFaqAnswer}$gemId/wiki_content',
        headers: {
          'Authorization': token,
        },
      );

      return Right(response.data['data']);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getRewardsBalance() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getRewardsBalance);
      return Right(response.data['data']['availableBalance']);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getRewardsTier() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getRewardsTier);
      return Right(response.data['data']['tier']);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getRewardsSessionToken() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.getRewardsSessionToken);
      return Right(response.data['data']['sessionId']);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<CustomException, UpdateHandlerModel>> getAppVersion(
      Map<String, dynamic> data) async {
    try {
      final response =
          await api.get(Api.public, ApiEndPoints.getAppVersion, data: data);
      final updateHandler = UpdateHandlerModel.fromJson(response.data);
      return Right(updateHandler);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> sendEmailToGenesys(
      Map<String, dynamic> params) async {
    Map<String, dynamic> mParams = {};
    if (params.containsKey("params")) {
      Map<String, dynamic> value = params["params"];
      mParams = {
        "text": value["text"],
        'line_of_business': value["line_of_business"],
        'from_email': value["from_email"]
      };
    } else {
      mParams.addAll(params);
    }
    try {
      final response =
          await api.post(Api.public, ApiEndPoints.sendFaqEmail, mParams);

      return Right(response.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Map> getCDProducts() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.cdProducts);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map> getCheckingProducts() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.checkingProducts);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map> getSavingsProducts() async {
    try {
      final response =
          await api.get(Api.protected, ApiEndPoints.savingProducts);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map> createBankingUser(Map<String, dynamic> payload) async {
    final response =
        await api.post(Api.protected, ApiEndPoints.createBankingUser, payload);
    return response.data;
  }

  @override
  Future<Map> submitApplication(String productCode) async {
    final response = await api.post(
      Api.protected,
      ApiEndPoints.submitApplication(productCode),
      {},
    );
    return response.data;
  }

  @override
  Future<Map> submitApplicationAndMakeDeposit(
    String productCode,
    Map<String, dynamic> body,
  ) async {
    final response = await api.post(
      Api.protected,
      ApiEndPoints.submitApplication(productCode),
      body,
    );
    return response.data;
  }

  @override
  Future<dynamic> verifyAddress(PartialAddress address) async {
    final response = await api.post(Api.protected, ApiEndPoints.verifyAddress, {
      "addressStreet": address.line1,
      "addressStreet2": address.line2,
      "addressCity": address.city,
      "addressState": USStates.getAbbreviation(address.state.value),
      "addressZip": address.zip
    });
    return response.data;
  }

  @override
  Future<Map> getDebitCards() async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.debitCards);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map> orderDebitCard(
      String cardId, Map<String, dynamic> payload) async {
    try {
      final response = await api.post(
        Api.protected,
        ApiEndPoints.orderDebitCard(cardId),
        payload,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<CustomException, dynamic>> notifyEmail(
      String product, String state) async {
    try {
      final response = await api.post(
        Api.protected,
        ApiEndPoints.notifyEmail,
        state != ""
            ? {"product": product, "state": state}
            : {
                "product": product,
              },
      );
      return Right(response.data);
    } on CustomException catch (e) {
      if (e.errorCode == 431) {
        return Right(
          json.decode(e.errorMessage),
        );
      } else {
        return Left(e);
      }
    }
  }

  @override
  Future<Map> getExistingBankingUser() async {
    final response =
        await api.get(Api.protected, ApiEndPoints.getExistingBankingUser);
    return response.data;
  }

  @override
  Future<Map> getFundingAccounts({bool isOAO = true}) async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getFundingAccounts,
        data: isOAO ? {'type': 'oao'} : null,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map> getCCFundingAccounts() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getCCFundingAccounts,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map> getAccountDetails(String id) async {
    final response =
        await api.get(Api.protected, ApiEndPoints.getAccountDetails(id));
    return response.data;
  }

  @override
  Future<Map> getProductDisclosures(String productCode) async {
    final response = await api.get(
        Api.protected, ApiEndPoints.getProductDisclosures(productCode));
    return response.data;
  }

  @override
  Future<Map> getAccountTransactions(String id, int start, int limit) async {
    final response = await api.get(
      Api.protected,
      ApiEndPoints.getAccountTransactions(id),
      data: {
        'start': start,
        'limit': limit,
      },
    );
    return response.data;
  }

  @override
  Future makeDepositIncoming(
      {required double amount,
      required String acctId,
      required String linkedAccountId}) async {
    final payload = {
      'originator': {'acctId': acctId},
      'counterParty': {'linkedAccountId': linkedAccountId},
      'amount': amount
    };

    try {
      final response = await api.post(
          Api.protected, ApiEndPoints.singleTransferUrlIncoming, payload);
      return response.data;
    } on CustomException catch (e) {
      return e;
    }
  }

  @override
  Future makeDepositInternal(
      {required double amount,
      required String acctId,
      required String linkedAccountId}) async {
    final payload = {
      'originator': {'acctId': linkedAccountId},
      'counterParty': {'acctId': acctId},
      'amount': amount
    };

    try {
      final response = await api.post(
          Api.protected, ApiEndPoints.singleTransferUrlInternal, payload);
      return response.data;
    } on CustomException catch (e) {
      return e;
    }
  }

  @override
  Future<Either<CustomException, dynamic>> notifyEmailStatus(
      String product, String state) async {
    try {
      final response = await api.get(Api.protected, ApiEndPoints.notifyEmail,
          data: state != ""
              ? {'product': product, 'state': state}
              : {'product': product});
      return Right(response.data);
    } on CustomException catch (e) {
      {
        return Left(e);
      }
    }
  }

  Future<Either<CustomException, EligibleAccountsModel>>
      getEligibleTransferAccounts() async {
    try {
      final response = await api.get(
        Api.protected,
        ApiEndPoints.getEligibleTransferAccounts,
      );

      final data = EligibleAccountsModel.fromJson(response.data);
      print("Jake's Data: $data");
      return Right(data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Map> cardTransition(String cardId, String transitionString) async {
    final res = await api.put(
        Api.protected, ApiEndPoints.cardTransition(cardId, transitionString));
    return res.data;
  }

  @override
  Future<Map> getChangePinCredentials(String id) async {
    final res = await api.get(Api.protected, ApiEndPoints.pinManagement);
    return res.data;
  }

  @override
  Future<Map?> getCreditCardAccount() async {
    // we get the accountId first and then the account details
    var accountId;
    try {
      final response1 =
          await api.get(Api.protected, ApiEndPoints.getCreditCardList);
      accountId = response1.data['data']['cards']['account_id'];
    } catch (e) {
      return null;
    }

    // THIS IS THE HACK TO GET CREDIT CARD
    // var accountId = "81310da5-a049-4be1-ad51-42d90d77e75a";
    final response2 = await api.get(
        Api.protected, ApiEndPoints.getCreditCardAccount(accountId));

    try {
      // add the card schedule to response if available
      final response3 =
          await api.get(Api.protected, ApiEndPoints.getCreditCardSchedule);

      return response2.data['data'].addAll(response3.data['data']);
    } catch (e) {
      return response2.data['data'];
    }

  }

  @override
  Future<Map> getCCTransactions(int loadMoreIndex) async {
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now();

    startDate.subtract(Duration(days: 90 * loadMoreIndex));
    endDate.subtract(Duration(days: 90 * (loadMoreIndex + 1)));

    final response =
        await api.get(Api.protected, ApiEndPoints.getCCTransactions, data: {
      "transacted_before": endDate,
      "transacted_after": startDate,
    });
    return response.data;
  }

  @override
  Future<Map> makeTransfer(
      String transferType, Map<String, dynamic> body) async {
    final res = await api.post(
        Api.protected, ApiEndPoints.makeTransfer(transferType), body);
    return res.data;
  }

  @override
  Future<InitialEnableCreditScoreResponseModel?> initiateEnableCreditScore(
      Map<String, dynamic> body) async {
    final res = await api.post(
        Api.protected, ApiEndPoints.initiateEnableCreditScore, body);
    return InitialEnableCreditScoreResponseModel.fromJson(res.data);
  }

  @override
  Future<EnableCreditScoreSmfaResponseModel?>
      enableCreditScoreSMFASendUrl() async {
    final res = await api
        .post(Api.protected, ApiEndPoints.enableCreditScoreSMFASendUrl, {});
    return EnableCreditScoreSmfaResponseModel.fromJson(res.data);
  }

  Future<Either<CustomException, dynamic>> createDeserveUser(
      Map<String, dynamic> data) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.createDeserveUser,
        data,
      );
      return Right(res.data["data"].first);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> createCCApplication(
      Map<String, dynamic> data) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.createCCApplication,
        data,
      );
      return Right(res.data["data"]);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> getACCApplicationStatus(
      applicationID) async {
    try {
      final res = await api.get(
        Api.protected,
        ApiEndPoints.accApplicationStatus,
        data: {"application_id": applicationID},
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> validateBasicInformation(
    applicationID,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.validateBasicInformation(applicationID),
        data,
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> validateContactInformation(
    applicationID,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.validateContactInformation,
        data,
        queryParams: {"application_id": applicationID},
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> validateAddressInformation(
    applicationID,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.validateAddressInformation(applicationID),
        data,
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> tokenizationSSN(
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.tokenizationSSN,
        data,
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> validateEmploymentStatus(
    applicationID,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.validateEmploymentStatus(applicationID),
        data,
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> validateExpenseInformation(
    applicationID,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.validateExpenseInformation,
        data,
        queryParams: {"application_id": applicationID},
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> updateApplicantData(
    applicationID,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await api.post(
        Api.protected,
        ApiEndPoints.updateApplicantData,
        data,
        queryParams: {"application_id": applicationID},
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  Future<Either<CustomException, dynamic>> accUpdatePullConsent(
    applicationID,
    Map<String, dynamic> data,
  ) async {
    try {
      final res = await api.patch(
        Api.protected,
        ApiEndPoints.accUpdatePullConsent,
        data,
        queryParams: {"application_id": applicationID},
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Map> getStatements(String id) async {
    final res = await api.get(Api.protected, ApiEndPoints.statements(id));
    if (res.statusCode == 204) {
      return {
        'data': {'statements': []}
      };
    }
    return res.data;
  }

  @override
  Future<Map> getSavingsCheckingDetail(String type) async {
    final res =
        await api.get(Api.protected, ApiEndPoints.savingsCheckingDetails(type));
    return res.data;
  }

  @override
  Future<Map> getThirtyDayDetails(String id) async {
    final res = await api.get(Api.protected, ApiEndPoints.thirtyDay(id));
    return res.data;
  }

  @override
  Future<Map> ccCreateACHPayment(
      String accountId, CCFundingAccountModel selectedFundingAccount) async {
    final res = await api
        .post(Api.protected, ApiEndPoints.ccCreatePaymentMethod(accountId), {
      "account_number": selectedFundingAccount.accountNumber,
      "routing_number": selectedFundingAccount.routingNumber,
      "bank_name": selectedFundingAccount.bankName,
      "account_type": selectedFundingAccount.accountType,
      "name": selectedFundingAccount.name
    });
    return res.data;
  }

  @override
  Future<Map> ccScheduleAutoPayment(String methodId, double? amount,
      String accountId, CCPaymentType paymentType, int autoPayDate) async {
    final res = await api
        .post(Api.protected, ApiEndPoints.ccSchedulePayment(accountId), {
      "frequency": "MONTHLY",
      "day_of_month": autoPayDate,
      "method_id": methodId,
      "amount": amount.toString(),
      "type": ccPaymentTypeDataValue(
        paymentType,
      )
    });
    return res.data;
  }

  @override
  Future<Map> ccSchedulePayment(
    DateTime paymentDate,
    String methodId,
    double amount,
    String accountId,
  ) async {
    // TODO: frequency "ONE-TIME" "DUE-DATE" "MONTHLY" "INSTANT"
    final res = await api
        .post(Api.protected, ApiEndPoints.ccSchedulePayment(accountId), {
      "frequency": "ONE-TIME",
      "payment_date": paymentDate,
      "method_id": methodId,
      "amount": amount.toString(),
      "type": "FIXED-AMOUNT"
    });
    return res.data;
  }

  @override
  Future<Either<CustomException, dynamic>> acceptCardHolderAgreement(
      applicationID, Map<String, dynamic> data) async {
    try {
      final res = await api.put(
        Api.protected,
        ApiEndPoints.productAgreementAccept(applicationID),
        data: data,
      );
      return Right(res.data);
    } on CustomException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Map> requestEarlyAccess(String product) async {
    final res = await api
        .post(Api.protected, ApiEndPoints.requestEarlyAccess(product), {});
    return res.data;
  }
}
