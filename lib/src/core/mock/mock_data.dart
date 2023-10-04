import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/src/form_data.dart';
import 'package:flutter/services.dart';
import 'package:glorifi/src/core/api/api_helper.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';
import 'package:glorifi/src/feature/banking/model/banking_banner_model.dart';
import 'package:glorifi/src/feature/banking/model/connected_account_model.dart';
import 'package:glorifi/src/feature/banking/model/glorifi_accounts_model.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_data.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_faq_response.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_response.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_dashboard_model.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/models/cc_funding_accounts_model.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/feature/insurance/model/base_response.dart';
import 'package:glorifi/src/feature/insurance/model/insurance_category_model.dart';
import 'package:glorifi/src/feature/insurance/model/quote_response.dart';
import 'package:glorifi/src/feature/mortgage/model/banner_data_model.dart';
import 'package:glorifi/src/feature/mortgage/model/mortgage_data.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/model/enable_credit_score_smfa_response_model.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/model/initial_endable_credit_score_response_model.dart';
import 'package:glorifi/src/feature/policy_detail/model/policy_detail_response.dart';
import 'package:glorifi/src/model/credit_score_model.dart';
import 'package:glorifi/src/model/glorifi_video_feed/glorifi_video_feed.dart';
import 'package:glorifi/src/model/news_model.dart';
import 'package:glorifi/src/model/notification_models.dart';
import 'package:glorifi/src/model/personal_snapshot/net_worth_detail_model.dart';
import 'package:glorifi/src/model/total_accounts_opened_model.dart';
import 'package:glorifi/src/model/update_handler_model.dart';

import '../../feature/credit_card/model/credit_card_applications_data.dart';
import '../../feature/mortgage/model/state_data_model.dart';

class MockData extends ApiHelper {
  @override
  Future<Either<CustomException, dynamic>> executeRegister(
      Map<String, dynamic> data) {
    // TODO: implement executeRegister
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getAddress(double lat, double lng) {
    // TODO: implement getAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getFormattedAddress(String placeId) {
    // TODO: implement getFormattedAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getPrediction(String inputString) {
    // TODO: implement getPrediction
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> validateEmail(String email) {
    // TODO: implement validateEmail
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> uploadImage(FormData imagePath) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getPlaidLinkToken() {
    // ignore: todo
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> getInformationOfTheDay() {
    try {
      return Future.delayed(
        Duration(seconds: 1),
        () => Right(NewsModel(
          id: 'rgwergwertherthertherht',
          source: 'http://google.com',
          headline: 'This is a headline',
          imageUrl: '',
          url: '',
          updatedAt: DateTime.now(),
        )),
      );
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getNewsFeedApi() {
    try {
      return Future.delayed(Duration(seconds: 1), () async {
        final testData =
            await rootBundle.loadString('assets/json/video_feed.json');

        List response = json.decode(testData);

        var mapping =
            response.map((item) => GlorifiVideoFeed.fromJson(item)).toList();
        return Right(mapping);
      });
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getNewsFeedWordPress() {
    try {
      return Future.delayed(
        Duration(seconds: 1),
        () => Right(NewsModel(
          id: 'rgwergwertherthertherht',
          source: 'http://google.com',
          headline: 'This is a headline',
          imageUrl: '',
          url: '',
          updatedAt: DateTime.now(),
        )),
      );
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getMortgagesBanners() {
    try {
      final response = BannerDataModel.fromJson({
        "data": [
          {
            "title": "Mortgage Title",
            "subtitle": "Cta Label",
            "imageUrl": "assets/images/sample_house.png"
          },
          {
            "title": "Mortgage Title",
            "subtitle": "Cta Label",
            "imageUrl": "assets/images/sample_house.png"
          },
        ]
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getRumbleVideos() {
    try {
      return Future.delayed(
        Duration(seconds: 1),
        () => Right(NewsModel(
          id: 'rgwergwertherthertherht',
          source: 'http://google.com',
          headline: 'This is a headline',
          imageUrl: '',
          url: '',
          updatedAt: DateTime.now(),
        )),
      );
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  Future<Either<CustomException, dynamic>> getMortgages() {
    try {
      final response = MortgageDataResponse.fromJson({
        "success": true,
        "data": [
          {
            "id": "7c082f23-7114-4fa0-8ba5-b79091a81b1f",
            "referenceNumber": "120432",
            "solutionSubType": "MORTGAGE",
            "loanPurposeType": "PURCHASE",
            "status": "Application in Progress",
            "createdDate": "2022-02-22T17:00:25.529Z"
          },
          {
            "id": "7c082f23-7114-4fa0-8ba5-b79091a81b1f",
            "referenceNumber": "120432",
            "solutionSubType": "MORTGAGE",
            "loanPurposeType": "PURCHASE",
            "status": "Submitted",
            "createdDate": "2022-02-22T17:00:25.529Z"
          }
        ],
        "status": "Success",
        "message": "Successfully Fetched"
      });
      return Future.delayed(Duration(seconds: 4), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 4), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getCreditCardBanner() {
    try {
      final response = BannerDataModel.fromJson({
        "data": [
          {
            "title": "Credit Card Title",
            "subtitle": "Cta Label",
            "imageUrl": "assets/images/sample_house.png"
          },
          {
            "title": "Reward Card Title",
            "subtitle": "Cta Label",
            "imageUrl": "assets/images/sample_house.png"
          },
        ]
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getCreditCards() {
    try {
      final response = CreditCardResponse.fromJson({
        "success": true,
        "data": [
          {
            "name": "Plaid Credit Card",
            "masked_numbers": "3333",
            "full_name": "Plaid Credit Card 12.5% APR",
            "current_balance": "410.0"
          },
          {
            "name": "Plaid Credit Card",
            "masked_numbers": "7777",
            "full_name": "Plaid Credit Card 12.5% APR",
            "current_balance": "430.0"
          }
        ],
        "status": "Success",
        "message": "Successfully Fetched"
      });
      return Future.delayed(Duration(milliseconds: 500), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getTotalAccountsPersonalSnapshots() {
    try {
      return Future.delayed(
        Duration.zero,
        () => Right(
          TotalAccountsOpenedModel(
            count: 4,
            accountStatus: 'Good',
            description: AppString.generalContent,
            duration: 'As of now',
            location: 'Dallas, TX',
            openAccountCount: 1,
            closedAccountCount: 3,
            fullState: true,
            openAccounts: ['1', '2', '3', '4'],
            closedAccounts: ['1', '2', '3', '4'],
          ),
        ),
      );
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
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
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getCreditCardDetailData() {
    try {
      final response = CreditCardData.fromJson({
        "data": {
          "progress": 0.2,
          "cardType": "Brass Card++",
          "lastFourCardNumber": 2313,
          "amount": "4,003.12",
          "availableAmount": "11,000.00",
          "paymentDueDate": "Feb 14",
          "minimumAmountDue": "56.66"
        },
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
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
                "vendorUrl":
                    "${Urls.unqorkAuthUrl}?${Urls.unqorkHomeownerParams}",
                "bindableUrl":
                    "${Urls.bindableQuoteBaseUrl}${Urls.bindableHomePath}"
              },
              {
                "id": 2,
                "categoryName": "Condo Insurance",
                "icon": "assets/icons/ico_condo_insurance.svg",
                "vendor": "unqork",
                "vendorUrl": "${Urls.unqorkAuthUrl}?${Urls.unqorkCondoParams}",
                "bindableUrl":
                    "${Urls.bindableQuoteBaseUrl}${Urls.bindableHomePath}"
              },
              {
                "id": 3,
                "categoryName": "Renter’s Insurance ",
                "icon": "assets/icons/renters_icon.svg",
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
                "bindableUrl":
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
  Future<Either<CustomException, dynamic>> getMyPolicy() {
    try {
      final response = BaseResponse.fromJson({
        "success": 200,
        "data": {
          "policies": [
            {
              "party_id": 147,
              "policy_name": "Pet Insurance",
              "vendor": "Van Epps",
              "policy_id": 321987,
              "display_identifier": {"name": "Ivy"}
            },
            {
              "party_id": 147,
              "policy_name": "Auto Insurance",
              "vendor": "Bindable",
              "policy_id": 654321,
              "display_identifier": {
                "vehicle_year": "2018",
                "vehicle_type": "Ford",
                "vehicle_model": "Mustang"
              }
            },
            {
              "party_id": 147,
              "policy_name": "Homeowners Insurance",
              "vendor": "Unqork",
              "policy_id": 987321,
              "display_identifier": {
                "addr_address_line1": "1122 Market St",
                "addr_city": "New York",
                "addr_state": "NY",
                "addr_post_code": "10018"
              }
            }
          ]
        },
        "status": "Success",
        "message": "Successfully Fetched"
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getInsuranceBanners() {
    try {
      final response = BannerDataModel.fromJson({
        "data": [
          {
            "title": "Homeowner Insurance Title",
            "subtitle": "Cta Label",
            "imageUrl": "assets/images/sample_house.png"
          },
          {
            "title": "Renter Insurance Title",
            "subtitle": "Cta Label",
            "imageUrl": "assets/images/sample_house.png"
          },
        ]
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getWeather(String latlong) {
    // TODO: implement getWeather
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> sendOtp(String email) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> verifyOtp(
      String verifyOtpUrl, String otp) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getSupportFaq() {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getNetWorthDetails() async {
    try {
      final String json =
          await rootBundle.loadString('assets/json/net_worth_detail_data.json');
      final response = NetWorthDetailModel.fromJson(jsonDecode(json));
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getBankingBanner() {
    try {
      final response = BankingBannerModel.fromJson({
        "data": [
          {
            "title": "Get your checking account",
            "subtitle": "Apply",
            "type": "checking"
          },
          {
            "title": "Get your savings account",
            "subtitle": "Apply",
            "type": "saving"
          },
          {"title": "Get your CD", "subtitle": "Apply", "type": "cd"}
        ]
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getConnectedAccounts() {
    try {
      final response = ConnectedAccountModel.fromJson({
        "success": true,
        "data": {
          "accounts": [
            {
              "plaid_account_id": "a56doV6vnaSv1BzMW486Cz7rjrrEJbt7lJMVp",
              "name": "Plaid 401k",
              "mask": "6666",
              "official_name": "None",
              "current_balance": "23631.9805000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "investment",
              "subtype": "401k",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "4onvM8nNEQtE4BNzZ9aDCeQxdxx3WnSdNVP4g",
              "name": "Plaid Student Loan",
              "mask": "7777",
              "official_name": "None",
              "current_balance": "65262.0000000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "loan",
              "subtype": "student",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "x7DBEVD1N3CPN9LKJyR8twLzgzzjWQUnpPbLZ",
              "name": "Plaid Money Market",
              "mask": "4444",
              "official_name":
                  "Plaid Platinum Standard 1.85% Interest Money Market",
              "current_balance": "43200.0000000000",
              "available_balance": "43200.0000000000",
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "money market",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "9DMjJP8xqEiawk84ankGSPkZx6rwzyfRJQrK4",
              "name": "Plaid 401k",
              "mask": "6666",
              "official_name": "None",
              "current_balance": "23631.9805000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "investment",
              "subtype": "401k",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "GAx6JWQpeDT5VX6v5xX8Iyr4odEV6aU1jPaZL",
              "name": "Plaid Saving",
              "mask": "1111",
              "official_name": "Plaid Silver Standard 0.1% Interest Saving",
              "current_balance": "210.0000000000",
              "available_balance": "200.0000000000",
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "savings",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "N58wA18v4QS5XvPjx6ryc3ezPzzx56sWBpwkW",
              "name": "Plaid Mortgage",
              "mask": "8888",
              "official_name": "None",
              "current_balance": "56302.0600000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "loan",
              "subtype": "mortgage",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "neQ9vy5KZntKAP1eK6PQs7p1lw5BvjS6mWoJ7",
              "name": "Plaid CD",
              "mask": "2222",
              "official_name": "Plaid Bronze Standard 0.2% Interest CD",
              "current_balance": "1000.0000000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "cd",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "vyWJvxq4Enh4kmlx4XmrU4WoEmgD5MFW7kpwv",
              "name": "Plaid Student Loan",
              "mask": "7777",
              "official_name": "None",
              "current_balance": "65262.0000000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "loan",
              "subtype": "student",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "R6yAqz8rWDt5aBV956BeIk7wdDKWZjhR1b9ZX",
              "name": "Plaid Mortgage",
              "mask": "8888",
              "official_name": "None",
              "current_balance": "56302.0600000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "loan",
              "subtype": "mortgage",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "yyWRw4VjGnhjqG64jXGDfpKMG14QaztyvXGgy",
              "name": "Plaid IRA",
              "mask": "5555",
              "official_name": "None",
              "current_balance": "320.7600000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "investment",
              "subtype": "ira",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "d5MdGVMvyPSW1mxQneJZtLWm5mmewacZ5zprd",
              "name": "Plaid IRA",
              "mask": "5555",
              "official_name": "None",
              "current_balance": "320.7600000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "investment",
              "subtype": "ira",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "m7Xwvm5qQnIqXNLpqDN4UKWLker5RDsL3dEr7",
              "name": "Plaid Money Market",
              "mask": "4444",
              "official_name":
                  "Plaid Platinum Standard 1.85% Interest Money Market",
              "current_balance": "43200.0000000000",
              "available_balance": "43200.0000000000",
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "money market",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "A6kWJLneaEtZ4ywDZnymSayDemo4Pwh1eA8Bm",
              "name": "Plaid Checking",
              "mask": "0000",
              "official_name": "Plaid Gold Standard 0% Interest Checking",
              "current_balance": "110.0000000000",
              "available_balance": "100.0000000000",
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "checking",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "brzoZLx1BWu4bloX43lrU9zRXpaD6ZHVvZlBg",
              "name": "Plaid Credit Card",
              "mask": "3333",
              "official_name": "Plaid Diamond 12.5% APR Interest Credit Card",
              "current_balance": "410.0000000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "credit",
              "subtype": "credit card",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "d5R1yBGRkRSp74rAMkN8hgAqKnxDngTZBrVje",
              "name": "Plaid Money Market",
              "mask": "4444",
              "official_name":
                  "Plaid Platinum Standard 1.85% Interest Money Market",
              "current_balance": "43200.0000000000",
              "available_balance": "43200.0000000000",
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "money market",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "N5LJ46ALBLSg89pQ3wGKSyNnrK9EKyiWXkR4Q",
              "name": "Plaid Student Loan",
              "mask": "7777",
              "official_name": "None",
              "current_balance": "65262.0000000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "loan",
              "subtype": "student",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "P5LJP6mLxLSrL6g4Ab1JcNmKzqeRqNF7XVqPy",
              "name": "Plaid Mortgage",
              "mask": "8888",
              "official_name": "None",
              "current_balance": "56302.0600000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "loan",
              "subtype": "mortgage",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "x76vNyE6G6IQBbergXnjIXBylVxJVXfnyLr3R",
              "name": "Plaid Credit Card",
              "mask": "3333",
              "official_name": "Plaid Diamond 12.5% APR Interest Credit Card",
              "current_balance": "410.0000000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "credit",
              "subtype": "credit card",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "4oA1EDMAzAiJy1PVg5exFMrKj1aB1Midl4GQM",
              "name": "Plaid 401k",
              "mask": "6666",
              "official_name": "None",
              "current_balance": "23631.9805000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "investment",
              "subtype": "401k",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "a5RQnKoR8RSaRxLXkKPeINGZKdXEabC7kVyJZ",
              "name": "Plaid Saving",
              "mask": "1111",
              "official_name": "Plaid Silver Standard 0.1% Interest Saving",
              "current_balance": "210.0000000000",
              "available_balance": "200.0000000000",
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "savings",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "4oA1EDMAzAiJy1PVg5exFMrDpEN3ynFdl4GVl",
              "name": "Plaid CD",
              "mask": "2222",
              "official_name": "Plaid Bronze Standard 0.2% Interest CD",
              "current_balance": "1000.0000000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "cd",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "d5R1yBGRkRSp74rAMkN8hgAEdGVepaSZBrVzZ",
              "name": "Plaid Checking",
              "mask": "0000",
              "official_name": "Plaid Gold Standard 0% Interest Checking",
              "current_balance": "110.0000000000",
              "available_balance": "100.0000000000",
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "depository",
              "subtype": "checking",
              "plaid_institution_id": null
            },
            {
              "plaid_account_id": "a5RQnKoR8RSaRxLXkKPeINGPLny1nNF7kVyBQ",
              "name": "Plaid IRA",
              "mask": "5555",
              "official_name": "None",
              "current_balance": "320.7600000000",
              "available_balance": null,
              "iso_currency_code": "USD",
              "limit": null,
              "unofficial_currency_code": null,
              "type": "investment",
              "subtype": "ira",
              "plaid_institution_id": null
            }
          ]
        },
        "status": "Success",
        "message": "Successfully Fetched"
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getStockQuotes() {
    // TODO: implement getStockQuotes
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> verifyZipCode(String zipCode) {
    // TODO: implement verifyZipCode
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> getCashOnHandDetails() {
    // TODO: implement getCashOnHandDetails
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> getNotifications() {
    // TODO: implement getNotifications
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> markNotificationAsRead(
      Messages notification) {
    // TODO: implement markNotificationAsRead
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> savePrimaryAddress(
      Map<String, dynamic> data) {
    // TODO: implement getPrimaryAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> fetchAddress() {
    // TODO: implement fetchAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> checkAddress() {
    // TODO: implement checkAddress
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getTotalDebt() {
    // TODO: implement getTotalDebt
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> getLinkDataFlowData() async {
    // TODO: implement getLinkDataFlowData
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> fetchStateList() {
    // TODO: implement fetchStateList
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> getCreditCardApplication() {
    try {
      final response = CreditCardApplicationsData.fromJson({
        "success": "true",
        "data": [
          {
            "id": "4d79c990-aa43-4b8d-8af9-7460cf1c8377",
            "solutionSubType": "CREDIT_CARD",
            "loanPurposeType": "OTHER",
            "status": "Application in Progress",
            "createdDate": "2022-01-31"
          },
          {
            "id": "3c1fac7d-3fbb-4bc7-a4b6-4a09e082a728",
            "solutionSubType": "CREDIT_CARD",
            "loanPurposeType": "OTHER",
            "status": "Application in Progress",
            "createdDate": "2022-01-27"
          }
        ],
        "status": "Success",
        "message": "Successfully Fetched"
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getComparison() {
    // TODO: implement getComparison
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> editComparison(
      Map<String, dynamic> data) {
    // TODO: implement editComparison
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, ApplicationStatusModel>>
      getApplicationStatus() {
    // TODO: implement getApplicationStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, HighlightModel>> getBankAccountHighlight() {
    // TODO: implement getCheckingSavings
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, CreditScoreHighlightModel>>
      getCreditScoreHighlight() {
    // TODO: implement getCreditScore
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, HighlightModel>> getInsightsHighlight() {
    // TODO: implement getInsightsHighlight
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, HighlightModel>> getProductsHighlight() {
    // ignore: todo
    // TODO: implement getRumbleVideos
    throw UnimplementedError();
  }

  // TODO: implement getProductsHighlight
  Future<Either<CustomException, dynamic>> getSavingsRetirement() {
    // ignore: todo
    // TODO: implement getRumbleVideos
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getUserProfile() {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getGemsTree() {
    // TODO: implement getGemsTree
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getGems(Map<String, dynamic> body) {
    // TODO: implement searchGems
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getUserEmail() {
    // TODO: implement getUserEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> otpMobileVerificationSend() {
    // TODO: implement otpMobileVerificationSend
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> otpVerificationResend() {
    // TODO: implement otpVerificationResend
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> otpVerificationVerify({
    required String passCode,
  }) {
    // TODO: implement otpVerificationVerify
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> editPreferredName(
      String _preferredName) {
    // TODO: implement editPreferredName
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getAccessTokenForOkta(
      String refreshToken) {
    // TODO: implement getAccessTokenForOkta
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> editZipCode(String zipCode) {
    // TODO: implement editZipCode
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> fetchMobileDepositLimit() {
    // TODO: implement fetchMobileDepositLimit
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> sentOtpPhone() {
    // TODO: implement sentOtpPhone
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> editPhoneNumber(
      String _phoneNumber) {
    // TODO: implement editPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> verifyOtpMobile(String otp) {
    // TODO: implement verifyOtpMobile
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getCreditScore() async {
    final json = r"""
                 {
                    "success": true,
                    "data": {
                      "credit_score": 710,
                      "credit_delta": "+2",
                      "credit_bucket": "Good",
                      "as_of_date": "2022-06-02",
                      "credit_history": {
                          "value": "100%",
                          "bucket": "Excellent"
                      },
                      "credit_utilization": {
                          "value": "15%",
                          "bucket": "Good"
                      },
                      "credit_total": {
                          "value": "$6500",
                          "bucket": "Good"
                      },
                      "credit_accounts": {
                          "open_accounts": [
                              {
                                  "name": "Credit Card",
                                  "institution": "GloriFi",
                                  "mask": "*5647",
                                  "balance": 240.00,
                                  "total_credit": 4000.00,
                                  "credit_history": "100%",
                                  "credit_utilization": "18%"
                              },
                              {
                                  "name": "Credit Card",
                                  "institution": "Wells Fargo",
                                  "mask": "*5647",
                                  "balance": 60.00,
                                  "total_credit": 2500.00,
                                  "credit_history": "100%",
                                  "credit_utilization": "13%"
                              }
                          ],
                          "closed_accounts": [
                              {
                                  "name": "Loan Credit",
                                  "institution": "Chase",
                                  "mask": "*7564"
                              }
                          ]
                  
                      }
                    },
                    "status": "Success",
                    "message": "Successfully Fetched"
                  }""";
    await Future.delayed(Duration(milliseconds: 200));
    return Right(CreditScoreModel.fromJson(jsonDecode(json)));
  }

  @override
  Future<Either<CustomException, dynamic>> editPhoneNumberCode(
      String phoneNumber) {
    // TODO: implement editPhoneNumberCode
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getPersoneticsInsights(
      Map<String, dynamic> header, Map<String, dynamic> data) {
    // TODO: implement getTopInsights
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getPersoneticsQAInsights(
      Map<String, dynamic> header, Map<String, dynamic> data) {
    // TODO: implement getTopInsights
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getMortgageStates(String product) {
    try {
      final response = StateDataResponse.fromJson({
        "products-available": [
          {
            "product_id_number": 1,
            "product_name": "MORTGAGE",
            "state": "MO",
            "state_name": "Alabama",
            "product_available": true,
            "product_availability_date": "2022-04-01"
          },
          {
            "product_id_number": 1,
            "product_name": "MORTGAGE",
            "state": "MO",
            "state_name": "Alaska",
            "product_available": true,
            "product_availability_date": "2022-04-01"
          },
          {
            "product_id_number": 1,
            "product_name": "MORTGAGE",
            "state": "MO",
            "state_name": "Missouri",
            "product_available": true,
            "product_availability_date": "2022-04-01"
          },
          {
            "product_id_number": 2,
            "product_name": "MORTGAGE",
            "state": "CA",
            "state_name": "California",
            "product_available": false,
            "product_availability_date": "2100-01-01"
          },
          {
            "product_id_number": 3,
            "product_name": "AUTO INSURANCE",
            "state": "TX",
            "state_name": "Texas",
            "product_available": true,
            "product_availability_date": "2022-04-01"
          }
        ]
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  Future<Either<CustomException, dynamic>> getNextStory(
      {required int x, int storiesPerPage: 1}) {
    // TODO: implement getNextStory
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getSessionToken() {
    // TODO: implement getSessionToken
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getMonthlyIncome() async {
    // TODO: implement getMonthlyIncome
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> postMonthlyIncome(value) async {
    // TODO: implement postMonthlyIncome
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getPolicyDetail(
      {required String id}) {
    try {
      final response = PolicyDetailResponse.fromJson({
        "success": true,
        "data": {
          "policynumber": 1234,
          "effectivedate": "2020-01-01",
          "expirationdate": "2020-01-01",
          "vendor": "Unqork",
          "underwriter": "underwriter",
          "status": "status",
          "display_identifier": {"name": "Ivy"},
        },
        "status": "Success",
        "message": ""
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  Future<Either<CustomException, dynamic>> getExploreData() {
    // TODO: implement getExploreData

    throw UnimplementedError();
  }

  @override
  Future<Map> getFeatureFlags() async {
    final jsonString = """
   {
     "success": true,
     "data": {
        "emailAddress": "email@email.com",
        "enableBanking": true,
        "enableCreditCard": false,
        "enableBrokerage": false,
        "enableMortgage": false,
        "enableInsurance": false
    },
     "status": "Success",
     "message": "Successfully Fetched"
    }
    """;
    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> legalDataRequest(bool requestToDelete) {
    // TODO: implement legalDataRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getConnectedGloriFiAccounts() {
    try {
      final response = GlorifiAccountResponse.fromJson({
        "success": true,
        "data": {
          "glorifi_accounts": [
            {
              "account_number": "**********1234",
              "account_name": "My Savings",
              "type": "checking|savings|cd",
              "current_balance": "23631.9805000000",
              "iso_currency_code": "USD",
              "apy": "0.5%",
              "interest_rate": "0.3%",
              "term": "24 months"
            }
          ]
        },
        "status": "Success",
        "message": "Successfully Fetched"
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> updateScheduleInfo(
      Map<String, dynamic> params) {
    // TODO: implement sendFaqEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getPendingQuotes() {
    try {
      final response = QuoteResponse.fromJson({
        "success": true,
        "data": {
          "quotes": [
            {
              "party_id": 123456,
              "quote_name": "Homeowners Insurance",
              "quote_number": "238923",
              "vendor": "Unqork",
              "started_date": "2022-01-04",
              "display_indentifier": {
                "addr_address_line1": "1122 Market St",
                "addr_city": "New York",
                "addr_state": "NY",
                "addr_post_code": "10018"
              }
            },
            {
              "party_id": 123456,
              "quote_name": "Auto Insurance",
              "quote_number": "51785",
              "vendor": "Bindable",
              "started_date": "2022-02-17",
              "display_indentifier": {
                "vehicle_year": "2018",
                "vehicle_type": "Ford",
                "vehicle_model": "Mustang"
              }
            },
            {
              "party_id": 123456,
              "quote_name": "Term Life Insurance",
              "quote_number": "320938",
              "vendor": "Van Epps",
              "started_date": "2022-02-01",
              "display_indentifier": {"name": "Tai Kerzner"}
            },
            {
              "party_id": 123456,
              "quote_name": "Term Life Insurance",
              "quote_number": "320938",
              "vendor": "Van Epps",
              "started_date": "2022-02-01",
              "display_indentifier": {"name": "Tai Kerzner"}
            }
          ]
        },
        "status": "Success",
        "message": "Successfully Fetched"
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getFaqRecommendation(
      {required params}) {
    // TODO: implement getFaqRecommendation
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> savePlaidToken(String token) {
    // TODO: implement savePlaidToken

    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> depositCheck(FormData data) {
    try {
      final response = GloriFiAccountData.fromJson({
        "success": true,
        "data": {
          "s:Envelope": {
            "@xmlns:s": "http://schemas.xmlsoap.org/soap/envelope/",
            "s:Body": {
              "Deposit_SubmitResponse": {
                "@xmlns": "urn:alogent-schema:MobilePaymentServer",
                "Deposit_SubmitResult": {
                  "@xmlns:a":
                      "http://schemas.datacontract.org/2004/07/AlogentMobilePaymentWebServerInterfaces",
                  "@xmlns:i": "http://www.w3.org/2001/XMLSchema-instance",
                  "a:Result": "Complete",
                  "a:Transaction": {
                    "a:BusinessDate": "2022-04-05T06:03:45.89",
                    "a:ItemSequenceNumber": "004570000005",
                    "a:Timestamp": "2022-04-05T10:03:46.11Z",
                    "a:TransactionId": "ba447fdd-a2e6-43a4-b068-e77019071c61"
                  }
                }
              }
            }
          }
        },
        "status": "Success",
        "message": "Successfully Fetched"
      });
      return Future.delayed(Duration(seconds: 1), () => Right(response));
    } on CustomException catch (e) {
      return Future.delayed(Duration(seconds: 1), () => Left(e));
    }
  }

  @override
  Future<Either<CustomException, dynamic>> getHomeValueAddress(
      String addr_id) async {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getBindableReroute() {
    // TODO: implement getBindableReroute
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getMemberDetails() {
    // TODO: implement getMemberDetails
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> viewedContent(
      {required String contentId}) {
    // TODO: implement viewedContent
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getLastLinkedAccountInfo() {
    // TODO: implement getConnectedAccountInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> demoUserLogin() {
    // TODO: implement demoUserLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getScheduleInformationResponse(
      String category) {
    // TODO: implement getScheduleInformationResponse
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getLinkedPlaidAccounts() {
    // TODO: implement getLinkedPlaidAccounts
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> unlinkPlaidInstitution(String id) {
    // TODO: implement unlinkPlaidInstitution
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getBundles() {
    // TODO: implement getBundles
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getFaqAnswer(String gemId) {
    // TODO: implement getFaqAnswer
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getRewardsBalance() {
    // TODO: implement getRewardsBalance
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getRewardsTier() {
    // TODO: implement getRewardsTier
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getRewardsSessionToken() {
    // TODO: implement getRewardsSessionToken
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, UpdateHandlerModel>> getAppVersion(
      Map<String, dynamic> data) {
    // TODO: implement getAppVersion
    throw UnimplementedError();
  }

  Future<Either<CustomException, dynamic>> sendEmailToGenesys(
      Map<String, dynamic> params) {
    // TODO: implement sentFaqEmail
    throw UnimplementedError();
  }

  @override
  Future<Map> getCDProducts() async {
    final jsonString = """
      {

    "success": true,
    "data": [
        {
            "productName": "P3003",
            "productDesc": "3 Month Compounding-Personal",
            "productType": "Deposit",
            "productGroup": "CD",
            "term": "3M",
            "apy": ".15",
            "interestRate": ".15"
        },
        {
            "productName": "P3006",
            "productDesc": "6 Month Compounding-Personal",
            "productType": "Deposit",
            "productGroup": "CD",
            "term": "6M",
            "apy": ".20",
            "interestRate": ".20"
        },
        {
            "productName": "P3009",
            "productDesc": "9 Month Compounding-Personal",
            "productType": "Deposit",
            "productGroup": "CD",
            "term": "9M",
            "apy": ".30",
            "interestRate": ".30"
        },
        {
            "productName": "P3012",
            "productDesc": "12 Month Compounding-Personal",
            "productType": "Deposit",
            "productGroup": "CD",
            "term": "12M",
            "apy": ".55",
            "interestRate": ".55"
        },
        {
            "productName": "P3018",
            "productDesc": "18 Month Compounding-Personal",
            "productType": "Deposit",
            "productGroup": "CD",
            "term": "18M",
            "apy": ".60",
            "interestRate": ".60"
        },
        {
            "productName": "P3036",
            "productDesc": "36 Month Compounding-Personal",
            "productType": "Deposit",
            "productGroup": "CD",
            "term": "36M",
            "apy": ".75",
            "interestRate": ".75"
        },
        {
            "productName": "P3060",
            "productDesc": "60 Month Compounding-Personal",
            "productType": "Deposit",
            "productGroup": "CD",
            "term": "60M",
            "apy": ".85",
            "interestRate": ".85"
        }
    ],
    "status": "Success",
    "message": "Successfully Fetched"
}
    """;
    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getCheckingProducts() async {
    final jsonString = """
      {
        "success": true,
        "data": [{
          "productName": "DDA1001 ",
          "productDesc": "Consumer Checking ",
          "productType": "Deposit",
          "productGroup": "DDA",
          "term": "",
          "apy": "1.00",
          "interestRate": "1.00 "
        }],
        "status": "Success",
        "message": "Successfully Fetched"
      }
    """;
    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getSavingsProducts() async {
    final jsonString = """
      {
    "success": true,
    "data": [
        {
            "productName": "P2001",
            "productDesc": "Personal Savings",
            "productType": "Deposit",
            "productGroup": "SAV",
            "term": "",
            "apy": ".25",
            "interestRate": ".25"
        }
    ],
    "status": "Success",
    "message": "Successfully Fetched"
}
    """;
    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Either<CustomException, dynamic>> getBundleDetails(String bundleName) {
    // TODO: implement getBundleDetails
    throw UnimplementedError();
  }

  @override
  Future<Map> orderDebitCard(
      String cardId, Map<String, dynamic> payload) async {
    final jsonString = """
      {
        "success": true,
        "data": [],
        "status": "Success",
        "message": "Successfully Fetched"
      }
    """;
    await Future.delayed(Duration(seconds: 3));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getDebitCards() async {
    final jsonString = """
      {
    "success": true,
    "data": [
        {
            "cardProductToken": "TBL_DEBIT_01",
            "cardTitle": "Thin Blue Line Debit",
            "cardSubtitle": "STANDING WITH THOSE WHO SERVE AND PROTECT",
            "cardDescription": "Every day, brave men and women across this great country put on bullet proof vests and risk it all in order to defend our families and protect our communities. Those who stand on the thin blue line deserve our full support. By putting our money where our values are, we're helping preserve this great nation for our kids and grandkids. Thank you for choosing GloriFi 's Thin Blue Line card, where you send a message with every purchase.",
            "cardArt": "https://core-assets.azureedge.net/assets/images/cards/debit/TBL_DEBIT_01.png"
        },
        {
            "cardProductToken": "CONST_DEBIT_01",
            "cardTitle": "Constitution Debit",
            "cardSubtitle": "A CARD FOR WE THE PEOPLE - PAY WITH PURPOSE",
            "cardDescription": "From the Founding Fathers who drafted those perfect words on parchment almost 235 years ago, we the people have always defended the Constitution of the United States. Today, our taking a stand may look a little different, when we come together as one economy, putting our money where our values are, we do our part to preserve this great nation for our kids and grandkids. Thank you for choosing GloriFi 's Constitution card, where you can send a message with every purchase.",
            "cardArt": "https://core-assets.azureedge.net/assets/images/cards/debit/CONST_DEBIT_01.png"
        },
        {
            "cardProductToken": "1776_DEBIT_01",
            "cardTitle": "1776 Debit",
            "cardSubtitle": "PRESERVING THE LAND OF THE FREE",
            "cardDescription": "On July 4th, 1776, a nation that held to liberty and freedom for all was born. Two centuries later, the GloriFi community still believes this country's best days are ahead. Though our taking a stand may look a little different these days, we proudly join each other in celebrating our inalienable rights to life, liberty, and the pursuit of happiness. Thank you for choosing GloriFi 's 1776 card, where you can send a message with every purchase.",
            "cardArt": "https://core-assets.azureedge.net/assets/images/cards/debit/1776_DEBIT_01.png"
        }
    ],
    "status": "Success",
    "message": "Successfully Fetched"
}
   
    """;
    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Either<CustomException, dynamic>> notifyEmail(
      String product, String state) {
    // TODO: implement notifyEmail
    throw UnimplementedError();
  }

  @override
  Future<Map> createBankingUser(Map<String, dynamic> payload) async {
    await Future.delayed(Duration(seconds: 3));
    return {
      'success': true,
      "data": {
        "accountCreation": {"statusCode": 200},
        "applicationValidation": {"statusCode": 200},
        "submitApplication": {"statusCode": 200}
      }
    };
  }

  @override
  Future<Map> submitApplication(String productCode) async {
    final jsonString = """
      {
          "success": true,
          "data": {
              "acctGroup": 1,
              "acctNbr": "xxxxxxxx4636",
              "acctTitle": "david williams",
              "acctType": "Single",
              "acctId": "f5v7lgS9e36ZdVoED7yhpqrAUytCAhFdQTXYBDKfACoNEfnq9Av2TEo80VbFD",
              "depPosn": [
                  {
                      "_Id": "4isimmzeTBxB0F---VTF-Co-",
                      "acctGroup": 1,
                      "acctNbr": "xxxxxxxx4636",
                      "posnAcctNbr": "xxxxxxxx4636",
                      "posnName": "Consumer Checking",
                      "posnNbr": 1,
                      "prodName": "DDA1001"
                  }
              ],
              "finInstAba": "091918457"
          },
          "status": "Success",
          "message": "Successfully Fetched"
      }
    """;
    await Future.delayed(Duration(seconds: 2));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getExistingBankingUser() async {
    final jsonString = """
      {
          "success": true,
          "data": {
              "user": true,
              "firstName": "David",
              "lastName": "Williams",
              "birthDate": "1992-10-11",
              "email": "dvdkwms1@protonmail.com",
              "phoneNumber": "7034590574",
              "addressStreet": "15110 Leafy Lane",
              "addressStreet2": "",
              "addressCity": "Dallas",
              "addressState": "TX",
              "addressZip": "75248"
          },
          "status": "Success",
          "message": "Successfully Fetched"
      }
    """;
    await Future.delayed(Duration(seconds: 2));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getCCFundingAccounts() async {
    await Future.delayed(Duration(seconds: 1));

    return {
      "data": [
        {
          "account_number": "1111222233333333",
          "routing_number": "021000322",
          "bank_name": "Chase",
          "account_type": "SAVINGS",
          "name": "Chase",
          "balance": 100.0,
          "lastFourDigits": "1234"
        }
      ]
    };
  }

  @override
  Future<Map> ccSchedulePayment(DateTime paymentDate, String methodId,
      double amount, String accountId) async {
    await Future.delayed(Duration(seconds: 1));

    return {"id": "9a001ed5-8f39-4f84-a87b-8b3ccf838f4d"};
  }

  @override
  Future<Map> getFundingAccounts() async {
    await Future.delayed(Duration(seconds: 1));

    return {
      "success": true,
      "data": {
        "glorifiAccounts": [
          {
            "account_number": "300000012755",
            "routing_number": "091918457",
            "account_name": "Consumer Checking",
            "type": "checking",
            "current_balance": "5.00",
            "iso_currency_code": "USD",
            "apy": "0.25%",
            "interest_rate": "0.25%",
            "term": "",
            "bankAccountId": "4ipFSsl0tuGTJF---VaF-Co-",
            "coreAccountId":
                "f5v7lgS9e36ZdVoED7yhoenJaf8j2Iyz9MCLhU5xNcWK0hZwOcn1RJebDNNds"
          },
          {
            "account_number": "300000013487",
            "routing_number": "091918457",
            "account_name": "Consumer Checking",
            "type": "checking",
            "current_balance": "0.50",
            "iso_currency_code": "USD",
            "apy": "1.01%",
            "interest_rate": "1.01%",
            "term": "",
            "bankAccountId": "4iqDO_7A3AZrdV---VmF-Co-",
            "coreAccountId":
                "f5v7lgS9e36ZdVoED7yhgHT5b4PkeEccUR6LQVZAgek8V8PoE6CZ7dkQskmvu"
          },
          {
            "account_number": "300000005934",
            "routing_number": "091918457",
            "account_name": "Consumer Checking",
            "type": "checking",
            "current_balance": "50010.00",
            "iso_currency_code": "USD",
            "apy": "0.25%",
            "interest_rate": "0.25%",
            "term": "",
            "bankAccountId": "4iam1FiLfQV0Ok---VqF-Co-",
            "coreAccountId":
                "cRnUN3gDTKgsx0mfsiLAyWkMNOdC851BeSNvP9s5NcCggDtoC6iFsoFaLqxI"
          },
          {
            "account_number": "300000000818",
            "routing_number": "091918457",
            "account_name": "Consumer Checking",
            "type": "checking",
            "current_balance": "2495131.05",
            "iso_currency_code": "USD",
            "apy": "0.25%",
            "interest_rate": "0.25%",
            "term": "",
            "bankAccountId": "4iMO9JXb5aI4-----VHF-Co-",
            "coreAccountId":
                "cRnUN3gDTKgsx0mfsiLAyePiKUyufXbxtTU5nXmWT8sLFJwtU9m41tLFWJeVbqB"
          },
          {
            "account_number": "300000007533",
            "routing_number": "091918457",
            "account_name": "Consumer Checking",
            "type": "checking",
            "current_balance": "34446.50",
            "iso_currency_code": "USD",
            "apy": "0.25%",
            "interest_rate": "0.25%",
            "term": "",
            "bankAccountId": "4ie47211kzru8k---V9F-Co-",
            "coreAccountId":
                "cRnUN3gDTKgsx0mfsiLAydMS4oJ6pURRITU827xPoSeC9IirSsLzVLrZHUpbp"
          },
          {
            "account_number": "300000009536",
            "routing_number": "091918457",
            "account_name": "Consumer Checking",
            "type": "checking",
            "current_balance": "127.00",
            "iso_currency_code": "USD",
            "apy": "1.01%",
            "interest_rate": "1.01%",
            "term": "",
            "bankAccountId": "4ihsTZU5danwFF---ViF-Co-",
            "coreAccountId":
                "cRnUN3gDTKgsx0mfsiLAydcoLKpyHPtebudShDPOq8hgKyAOTwRwHpPOGpsodRwZ"
          },
          {
            "account_number": "200000000939",
            "routing_number": "091918457",
            "account_name": "Personal Savings",
            "type": "savings",
            "current_balance": "1964828.95",
            "iso_currency_code": "USD",
            "apy": "0.25%",
            "interest_rate": "0.25%",
            "term": "",
            "bankAccountId": "4iMds_kpupe1g----VPF-Co-",
            "coreAccountId":
                "ZbrEJdHwFxS6U89qNkHkj8TZDsHVFrxGMIVZwbBpK6vo2DL838qyuK8bndGOWLJ"
          }
        ],
        "linkedAccounts": [
          {
            "_Id": "4iwpsGoQ5CVrYF----PF-77-",
            "name": "SoFi Money",
            "mask": "5129",
            "balance": 7.06,
            "institution": "SoFi",
            "status": "1"
          },
          {
            "_Id": "4iwB5u18_OjcIk----yF-77-",
            "name": "TOTAL CHECKING",
            "mask": "4201",
            "balance": 1214.93,
            "institution": "Chase",
            "status": "0"
          }
        ]
      },
      "status": "Success",
      "message": "Successfully Fetched"
    };
  }

  @override
  Future<Either<CustomException, dynamic>> saveFundingAccountToken(
      String token, List accounts) {
    // TODO: implement saveFundingAccountToken
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getAuthPlaidLinkToken() {
    // TODO: implement getAuthPlaidLinkToken
    throw UnimplementedError();
  }

  @override
  Future<Map> getAccountDetails(String id) async {
    final jsonString = """
   {
     "success": true,
     "data": {
         "acctType": "Consumer Checking",
         "acctNumber": "300000015977",
         "routingNumber": "091918457",
         "availableBalance": "0",
         "acctStatus": "1",
         "cardToken": "1776_DEBIT_01",
         "cardArt": ["https://core-assets.azureedge.net/assets/images/cards/debit/1776_DEBIT_01.png"],
         "cardMarqetaRef": "4ebbb4b0-7623-4478-bed9-436e2bd2ddaa",
         "cardStatus": "UNACTIVATED",
         "cardLastFour": "3215",
         "cardId": "4ixo-8eJBgnni----VXF-1V-",
         "interestRate": "1.0%",
         "apy": "1.01%",
         "accruedInterest": "0",
         "posnId": "4ixnXkaLACTaYk---VTF-Co-",
         "acctId": "f5v7lgS9e36ZdVoED7yhnsjyiBBS05zAQ7YGEbTNcVBvZgDc7mjraxGOAwnfGGx"
    },
     "status": "Success",
     "message": "Successfully Fetched"
}
    """;
    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future verifyAddress(PartialAddress address) async {
    final jsonString = """
      {
    "success": true,
    "data": {
        "deliverable": "deliverable",
        "address": {
            "city": "Parker",
            "postCode": "80134-8969",
            "region": "CO",
            "street": "8424 Wheatgrass Cir "
        },
        "deliverable_analysis": [
            {
                "id": "AA",
                "value": "Some parts of the address (such as the street and ZIP code) are valid."
            },
            {
                "id": "BB",
                "value": "The address is deliverable."
            }
        ]
    },
    "status": "Success",
    "message": "Successfully Fetched"
}
    """;

    await Future.delayed(Duration(seconds: 2));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getProductDisclosures(String productCode) async {
    final jsonString = """
{
    "success": true,
    "data": [
        {
            "_entityId": "1010539",
            "desc": "Deposit Standard Overdraft Practices",
            "version": "3",
            "docLink": "https://animo-testapimgmt.azure-api.net/core/banking/products/agreements/content/1010539"
        },
        {
            "_entityId": "1013909",
            "desc": "Deposit Debit Card Terms and Conditions",
            "version": "2",
            "docLink": "https://animo-testapimgmt.azure-api.net/core/banking/products/agreements/content/1013909"
        },
        {
            "_entityId": "1015166",
            "desc": "Deposit Deposit Agreement and Disclosures",
            "version": "1",
            "docLink": "https://animo-testapimgmt.azure-api.net/core/banking/products/agreements/content/1015166"
        },
        {
            "_entityId": "1015167",
            "desc": "Deposit Communications and Notification Agreement",
            "version": "1",
            "docLink": "https://animo-testapimgmt.azure-api.net/core/banking/products/agreements/content/1015167"
        }
    ],
    "status": "Success",
    "message": "Successfully Fetched"
}
""";
    await Future.delayed(Duration(seconds: 2));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getAccountTransactions(String id, int start, int limit) async {
    final jsonString = """
   {
    "success": true,
    "data": {
        "transactions": [
            {
                "trnId": "4iam87SfBvH9JF--0-1F-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-04-27T08:03:28.368514Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 10.0,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06NYLzMrb-N----FLF-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:50.3790734Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06Nc2ZGNxgkF---F9F-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:51.6397828Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06NfPIS-INGF---F9F-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:52.5404559Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06Nhpp4D3cA----FLF-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:53.1927769Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 239.3,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06NkLG2wo1Z----F9F-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:53.8656993Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 451.56,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06Nmg596puq----FuF-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:54.4941303Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 624.39,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06NpzBeKoZ2k---FeF-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:55.3795547Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 119.36,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06NtUwO0BD0F---FHF-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:56.3222067Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 529.26,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4j06NwVKs207GV---FPF-6s-",
                "trnStatus": "pending",
                "trnDate": "2022-05-18T18:45:57.1291833Z",
                "trnType": "",
                "trnPosn": "debit",
                "trnAmt": 624.71,
                "trnEndingBalance": "",
                "trnDesc": "",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "",
                "trnMerchant": "",
                "trnVn": ""
            },
            {
                "trnId": "4ixiy48ks0Ej9---0-eF-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:40:01.0823353Z",
                "trnType": "CORE",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": 50006.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            },
            {
                "trnId": "4ixivjkecNWA7V--0-yF-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:39:20.9801855Z",
                "trnType": "CORE",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": 50007.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            },
            {
                "trnId": "4ixitXZwgJVrxV--0-TF-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:38:43.0816382Z",
                "trnType": "CORE",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": 50008.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            },
            {
                "trnId": "4ixipr8XS3ZSjk--0-1F-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:37:39.8843403Z",
                "trnType": "CORE",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": 50009.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            },
            {
                "trnId": "4ixil0eweER-XF--0-9F-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:36:16.8094784Z",
                "trnType": "CORE",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": 50010.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            },
            {
                "trnId": "4ixidmY8Y4k-Xk--0-XF-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:34:12.4911525Z",
                "trnType": "CORE",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": 50011.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            },
            {
                "trnId": "4ixiSnQfgGEcUF--0-eF-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:30:46.5698409Z",
                "trnType": "CORE",
                "trnPosn": "debit",
                "trnAmt": 1.0,
                "trnEndingBalance": 50012.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            },
            {
                "trnId": "4ixhn_PCcg-08k--0-XF-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:18:41.2510748Z",
                "trnType": "CORE",
                "trnPosn": "credit",
                "trnAmt": 1.0,
                "trnEndingBalance": 50013.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            },
            {
                "trnId": "4ixhf_1_YxV-EF--0-qF-Go-",
                "trnStatus": "posted",
                "trnDate": "2022-05-16T00:16:23.713026Z",
                "trnType": "CORE",
                "trnPosn": "debit",
                "trnAmt": 2.5,
                "trnEndingBalance": 50012.5,
                "trnDesc": "Funds Transfer",
                "isDisputable": false,
                "trnGeo": "",
                "trnCode": "015",
                "trnMerchant": "",
                "trnVn": 3
            }
        ]
    },
    "status": "Success",
    "message": "Successfully Fetched"
}
    """;
    await Future.delayed(Duration(seconds: 3));
    return jsonDecode(jsonString);
  }

  @override
  Future makeDepositIncoming(
      {required double amount,
      required String acctId,
      required String linkedAccountId}) async {
    await Future.delayed(Duration(seconds: 1));
    return {"status": "Success"};
  }

  @override
  Future makeDepositInternal(
      {required double amount,
      required String acctId,
      required String linkedAccountId}) async {
    await Future.delayed(Duration(seconds: 1));
    return {"status": "Success"};
  }

  @override
  Future<Map> submitApplicationAndMakeDeposit(
      String productCode, Map<String, dynamic> body) async {
    final jsonString = """
      {
          "success": true,
          "data": {
              "acctGroup": 1,
              "acctNbr": "xxxxxxxx4636",
              "acctTitle": "david williams",
              "acctType": "Single",
              "acctId": "f5v7lgS9e36ZdVoED7yhpqrAUytCAhFdQTXYBDKfACoNEfnq9Av2TEo80VbFD",
              "depPosn": [
                  {
                      "_Id": "4isimmzeTBxB0F---VTF-Co-",
                      "acctGroup": 1,
                      "acctNbr": "xxxxxxxx4636",
                      "posnAcctNbr": "xxxxxxxx4636",
                      "posnName": "Consumer Checking",
                      "posnNbr": 1,
                      "prodName": "DDA1001"
                  }
              ],
              "finInstAba": "091918457"
          },
          "status": "Success",
          "message": "Successfully Fetched"
      }
    """;
    await Future.delayed(Duration(seconds: 2));
    return jsonDecode(jsonString);
  }

  @override
  Future<Either<CustomException, dynamic>> notifyEmailStatus(
      String product, String state) {
    // TODO: implement notifyEmailStatus
    throw UnimplementedError();
  }

  @override
  Future<Map> cardTransition(String cardId, String transitionString) async {
    final jsonString = """
      {
    "success": true,
    "data": {
        "cardTransitionStatusCode": 200,
        "cardTransitionMessage": "Good job"
    },
    "status": "Success",
    "message": "Successfully Fetched"
}
""";
    await Future.delayed(Duration(seconds: 2));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getChangePinCredentials(String id) async {
    final jsonString = """
      {
          "success": true,
          "data": {
              "one_time_token": "4640a698-0e18-4bfb-a350-55a49d991f58",
              "user_token": "4iMO8xmFaDSsm-----PF-Bg-",
              "application_id": "animo_sandbox",
              "success_url": "https://glorifi.com"
          },
          "status": "Success",
          "message": "Successfully Fetched"
      }
  """;
    await Future.delayed(Duration(seconds: 2));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getCreditCardAccount() async {
    String jsonString = """
    {"current_balance": 100.0, "cp_account_number": "234324234", "type": "Brass Card", "remaining_statement_balance": 20.0, "available_credit": 9000.0, 
    "remaining_minimum_payment_due": 10.0, "due_date": "2022-08-02T17:00:25.529Z", 
    "card_design_type": "brass", 
    "status": "ACTIVE", "number_active_disputes": 1, "schedules": [{"payment_date":"2022-08-01T17:00:25.529Z" }]}
      """;
    //   jsonString = """
    //  {"current_balance": 700.0, "account_number": "456457653", "type": "Gold Card", "remaining_statement_balance": 5.0, "available_credit": 1000.0,
    //  "remaining_minimum_payment_due": 10.0, "due_date": "2022-08-22T17:00:25.529Z", "auto_pay": "2022-08-01T17:00:25.529Z",
    //   "card_design_type": "thin_blue_line",
    //   "number_active_disputes": 3, "status": "SUSPENDED"}
    //   """;

    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> makeTransfer(String transferType, Map body) {
    // TODO: implement makeTransfer
    throw UnimplementedError();
  }

  @override
  Future<InitialEnableCreditScoreResponseModel?> initiateEnableCreditScore(
      Map<String, dynamic> body) async {
    final json = """
                 {
                    "success": true,
                    "data": {
                      "decision": "Allow"
                    },
                    "status": "Success",
                    "message": "Successfully Fetched"
                  }""";
    await Future.delayed(Duration(seconds: 2));
    return InitialEnableCreditScoreResponseModel.fromJson(jsonDecode(json));
  }

  @override
  Future<EnableCreditScoreSmfaResponseModel?>
      enableCreditScoreSMFASendUrl() async {
    final json = """
                 {
                    "success": true,
                    "data": {
                      "instaTouch": "https://api.uat.equifax.com/business/instatouch-secure-otp/v2/device-authentications/status"
                    },
                    "status": "Success",
                    "message": "Successfully Fetched"
                  }""";
    await Future.delayed(Duration(seconds: 2));
    return EnableCreditScoreSmfaResponseModel.fromJson(jsonDecode(json));
  }

  /// Credit Card
  @override
  Future<Either<CustomException, dynamic>> createDeserveUser(
      Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> createCCApplication(
      Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getACCApplicationStatus(id) {
    throw UnimplementedError();
  }

  @override
  Future<Map> getCreditCardsPreview() async {
    final jsonString = """
    {
      "cards" : [{"current_balance": 100.0, "account_number": "234324234", "type": "Brass Card"}, 
      {"current_balance": 700.0, "account_number": "456457653", "type": "Gold Card"}]
    }
    """;
    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Either<CustomException, dynamic>> validateBasicInformation(
      applicationID, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> validateContactInformation(
      applicationID, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> validateAddressInformation(
      applicationID, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> tokenizationSSN(
      Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> validateEmploymentStatus(
      applicationID, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> validateExpenseInformation(
      applicationId, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> updateApplicantData(
      applicationId, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> accUpdatePullConsent(
      applicationId, Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  Future<Map> getCCTransactions(int loadMoreIndex) async {
    String jsonString;
    if (loadMoreIndex == 0) {
      jsonString = """
    {
      "transactions" : [{
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "1857.27",
"transacted_at": "2020-06-26T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "5.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "pending",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "food",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Target",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "57.99",
"transacted_at": "2020-06-26T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "0.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "other",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "McDonald's",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "20.00",
"transacted_at": "2020-06-26T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "2.50",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "entertainment",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Wall",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "99.99",
"transacted_at": "2020-06-26T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "1.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "pending",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "education",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "WalMart",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
     {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "1857.27",
"transacted_at": "2020-06-26T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "0.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "shopping",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Bill Payment",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}]
    }
    """;
    } else if (loadMoreIndex == 1) {
      jsonString = """
    {
      "transactions" : [{
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "2054.97",
"transacted_at": "2020-06-25T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "20.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "vacation",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Illegal Pete's",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "857.27",
"transacted_at": "2020-06-25T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "0.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "self_love",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Burger King",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "7.27",
"transacted_at": "2020-06-25T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "0.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "health",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Lowes",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "4.58",
"transacted_at": "2020-06-23T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "1.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "pending",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "commuting",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "RadioShack",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
     {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "508.46",
"transacted_at": "2020-06-23T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "15.45",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "rewards",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Home Depot",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}]
    }
    """;
    } else {
      jsonString = """
    {
      "transactions" : [{
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "1857.27",
"transacted_at": "2020-06-23T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "0.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "dining",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Plant's R Us",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "87.88",
"transacted_at": "2020-06-23T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "0.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "payment",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "H&R Block",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "99.99",
"transacted_at": "2020-06-20T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "5.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "bank_account",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Senior Accounting",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
      {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "1857.27",
"transacted_at": "2020-06-20T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "0.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "settled",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "interest",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Target",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}, 
     {
"id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
"cp_root_transaction_id": 19647135,
"card_last_4_digits": "8353",
"amount": "15.50",
"transacted_at": "2020-06-20T07:09:50Z",
"transaction_number": "30712045",
"merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
"card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
"category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"tip_amount": "3.00",
"credit_indicator": "credit",
"settled_at": null,
"status": "pending",
"type": "regular",
"type_category": "regular",
"pos_type": "online",
"labels": [
"disputed"
],
"dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
"expiry_at": null,
"transaction_locality": "regular",
"digital_wallet": "apple_pay",
"root_id": 19647136,
"sequence": 2,
"network_data": {
"merchant_category_code": "late_fee",
"merchant_category_code_description": "string",
"merchant_city": "string",
"card_acceptor_id_code": "string",
"card_acceptor_terminal_id": "string",
"card_acceptor_name_location": "string",
"mcc_category_code": "string",
"merchant_id": "string",
"merchant_state": "string",
"merchant_zipcode": "string",
"merchant_name": "Arby's",
"merchant_street_address": "string",
"merchant_country": "string"
},
"type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
"txn_code": "CR001",
"description": "string"
}]
    }
    """;
    }

    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getStatements(String id) async {
    final jsonString = """
      {
          "success": true,
          "data": {
              "statements": [
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },{
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },{
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },{
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },{
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  },
                  {
                      "docId": "1004971",
                      "statementStartDate": "2022-04-15T00:00:00Z",
                      "statementEndDate": "2022-05-15T00:00:00Z",
                      "accountNumber": "xxxxxxxx0244"
                  }
              ]
          },
          "status": "Success",
          "message": "Successfully Fetched"
      }
    """;

    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getCashOnHandDetailsVersion2() {
    // TODO: implement getCashOnHandDetailsVersion2
    throw UnimplementedError();
  }

  @override
  Future<Map> getCashOnHandNetWorthDetails() {
    // TODO: implement getNetWorthDetailsVersion2
    throw UnimplementedError();
  }

  @override
  Future<Map> getSavingsCheckingDetail(String type) {
    // TODO: implement getSavingsCheckingDetail
    throw UnimplementedError();
  }

  @override
  Future<Map> getThirtyDayDetails(String id) {
    // TODO: implement getThirtyDayDetails
    throw UnimplementedError();
  }

  Future<Map> getCCMerchantDetails(String merchantId) async {
    String jsonString = """
    {
        
          "id": "mlfkalsk",
          "name": "Metallica Store",
          "secondary_merchant_name": "Ironman",
          "display_name": "string",
          "merchant_brand": {
            "id": "1c2a7391-e2bc-4e85-a1fb-74091e25fdda",
            "name": "Deserve",
            "logo_image": "https://example.com/logos/deserve.png"
          },
          "secondary_merchant_brand": {
            "id": "string",
            "name": "string",
            "logo_image": "http://example.com"
          },
          "merchant_type": "string",
          "category": {
            "id": "1c2a7391-e2bc-4e85-a1fb-74091e25fdda",
            "name": "Eating Out",
            "icon_image": "https://example.com/icons/Dining.png",
            "merchant_image": "https://example.com/merchants/deserve.png",
            "cover_image": "https://example.com/covers/Dinner.jpg"
          },
          "phone_number": "string",
          "cover_image": "string",
          "google_map_url": "string",
          "website": "string",
          "street_number": "string",
          "street_name": "string",
          "address_details": "string",
          "city": "string",
          "state": "string",
          "country": "string",
          "zipcode": "string",
          "formatted_address": "string",
          "latitude": "string",
          "longitude": "string",
          "cp_merchant_category_code": "string",
          "cardacceptor_name_location": "string"
       
      
    }
    """;

    // await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> getCCTransactionsDetails() async {
    String jsonString = """
    {
        "id": "bbd94888-ac93-5268-b0b4-fcb6c0bd4b08",
        "cp_root_transaction_id": 19647135,
        "card_last_4_digits": "8353",
        "amount": "1857.27",
        "transacted_at": "2020-06-26T07:09:50Z",
        "transaction_number": "30712045",
        "merchant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
        "account_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
        "tenant_id": "424a82dc-217a-4435-8397-27e7c0c0c7b2",
        "card_id": "29067702-4d4e-40fc-b838-ec97eaaa9b90",
        "category_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
        "tip_amount": "5.00",
        "credit_indicator": "credit",
        "settled_at": null,
        "status": "settled",
        "type": "regular",
        "type_category": "regular",
        "pos_type": "online",
        "labels": [
          "disputed"
        ],
        "dispute_id": "0c62dfed-ede7-44de-a9d1-b907389f2734",
        "expiry_at": null,
        "transaction_locality": "regular",
        "digital_wallet": "apple_pay",
        "root_id": 19647136,
        "sequence": 2,
        "network_data": {
          "merchant_category_code": "kjkjsldflsjfls",
          "merchant_category_code_description": "ksdjfkjsdkfjksdjf",
          "merchant_city": "Lost City",
          "card_acceptor_id_code": "534545",
          "card_acceptor_terminal_id": "dfhdfhdfhdhd",
          "card_acceptor_name_location": "hhdfhdh",
          "mcc_category_code": "dfhdfhd",
          "merchant_id": "dfhdfhdfhdfh",
          "merchant_state": "Nowhere",
          "merchant_zipcode": "zipzipzip",
          "merchant_name": "Metallica Store",
          "merchant_street_address": "Street 007",
          "merchant_country": "USA"
        },
        "type_category_metadata": "Dispute Reversed - Provisional Credit Reversal Adjustment",
        "txn_code": "CR001",
        "description": "sfsdfsfsd"
    }
    """;

    await Future.delayed(Duration(seconds: 1));
    return jsonDecode(jsonString);
  }

  @override
  Future<Map> ccCreateACHPayment(
      String accountId, CCFundingAccountModel selectedFundingAccount) async {
    await Future.delayed(Duration(seconds: 1));

    return {"id": "9a001ed5-8f39-4f84-a87b-8b3ccf838f4d"};
  }

  @override
  Future<Map> ccScheduleAutoPayment(String methodId, double? amount,
      String accountId, CCPaymentType paymentType, int autoPayDate) async {
    await Future.delayed(Duration(seconds: 1));

    return {"id": "9a001ed5-8f39-4f84-a87b-8b3ccf838f4d"};
  }

  @override
  Future<Map> awardLoyaltyPoints(String actionCode) {
    // TODO: implement awardLoyaltyPoints
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> acceptCardHolderAgreement(applicationID, Map<String, dynamic> data) {
    // TODO: implement acceptCardHolderAgreement
    throw UnimplementedError();
  }

  @override
  Future<Map> getRetirementSavings() {
    // TODO: implement getRetirementSavings
    throw UnimplementedError();
  }

  @override
  Future<Either<CustomException, dynamic>> getEligibleTransferAccounts() {
    // TODO: implement getEligibleTransferAccounts
    throw UnimplementedError();
  }

  @override
  Future<Map> requestEarlyAccess(String product) {
    // TODO: implement requestEarlyAccess
    throw UnimplementedError();
  }
}
