import 'package:glorifi/src/core/logger.dart';

abstract class BaseConfig {
  String get name;

  String get appUrl;

  String get websiteUrl;

  String get apiBaseUrl;

  String get apiSubscriptionKey;

  bool get useMock;

  bool get sendAnalytics;

  String get oktaTenant;

  String get oktaIssuerPath;

  String get bindIDClient;

  String get bindIDIdp;

  String get blendSSOPath;

  String get backbaseUrl;

  String get bindableInsureUrl;

  String get bindableQuoteUrl;

  String get unqorkUrl;

  // TODO remove when path is same for all envs
  String get unqorkAuthPath;

  String get vanEppsUrl;

  String get contentfulAPIKey;

  String get contentfulSpacerID;

  String get rewardsBaseUrl;

  String get marqetaBaseUrl;

}

class MockConfig implements BaseConfig {
  @override
  String get name => Environment.mock;

  @override
  String get appUrl => 'https://app.mock-glorifi.com';

  @override
  String get websiteUrl => "https://glorifi-test.azurewebsites.net";

  @override
  String get apiBaseUrl => 'https://apps-api-external.mock-glorifi.com';

  @override
  String get apiSubscriptionKey => 'xxxxxxxxxxxxxxxxxxxxx';

  @override
  bool get useMock => true;

  @override
  bool get sendAnalytics => false;

  // Okta
  @override
  String get oktaTenant => 'https://glorifisandbox.oktapreview.com';

  @override
  String get oktaIssuerPath => '/oauth2/';

  @override
  String get bindIDClient => '0oa22l89upDJGfZgm1d7';

  @override
  String get bindIDIdp => '0oa22jiwfkkrTiGL21d7';

  @override
  String get blendSSOPath =>
      '/home/glorifisandbox_blendconsumer_1/0oa22llhpyYqtJshK1d7/aln22lozgehvsNVk31d7';

  // Vendors
  @override
  String get backbaseUrl => 'https://banking.pat-glorifi.com';

  @override
  String get contentfulAPIKey => '8f2IfGWU2cpDUbnquF6imGdMKElzGSC2Pmd5pgwKXiI';

  @override
  String get contentfulSpacerID => '2d8t9chjyy25';

  @override
  String get bindableInsureUrl => 'https://qa-insurance.glorifi.com';

  @override
  String get bindableQuoteUrl => 'https://qa-quote.glorifi.com';

  @override
  // TODO: implement vanEppsUrl
  String get vanEppsUrl => 'https://www.enrollvb.com/glorifi-demo?memberId=';

  @override
  String get unqorkUrl => 'https://purpose-stagingx.unqork.io';

  // TODO remove when path is same for all envs
  @override
  String get unqorkAuthPath => '/auth/oidc/GloriFi?destination=/app/redirect';

  @override
  String get rewardsBaseUrl => 'https://rewards.mock-glorifi.com';

  @override
  String get marqetaBaseUrl => '';
}

class DevConfig implements BaseConfig {
  @override
  String get name => Environment.dev;

  @override
  String get appUrl => 'http://localhost:8080';

  @override
  String get websiteUrl => "https://glorifi-test.azurewebsites.net";

  @override
  String get apiBaseUrl => 'https://animo-testapimgmt.azure-api.net';

  @override
  String get apiSubscriptionKey => 'A6205c845f9f4976ad2e48488d143ed7';

  @override
  bool get useMock => false;

  @override
  bool get sendAnalytics => false;

  // Okta
  @override
  String get oktaTenant => 'https://glorifisandbox.oktapreview.com';

  @override
  String get oktaIssuerPath => '/oauth2/aus2eh1u19laOvlWM1d7';

  @override
  String get bindIDClient => '0oa22l89upDJGfZgm1d7';

  @override
  String get bindIDIdp => '0oa22jiwfkkrTiGL21d7';

  @override
  String get blendSSOPath =>
      '/home/glorifisandbox_blendconsumer_1/0oa22llhpyYqtJshK1d7/aln22lozgehvsNVk31d7';

  // Vendors
  @override
  String get backbaseUrl => 'https://banking.pat-glorifi.com';

  @override
  String get bindableInsureUrl => 'https://qa-insurance.glorifi.com';

  @override
  String get bindableQuoteUrl => 'https://qa-quote.glorifi.com';

  @override
  String get vanEppsUrl => 'https://www.enrollvb.com/glorifi-demo?memberId=';

  @override
  // String get unqorkUrl => 'https://purpose-stagingx.unqork.io';
  String get unqorkUrl => 'https://purpose-uatx.unqork.io';

  // TODO remove when path is same for all envs
  @override
  // String get unqorkAuthPath => '/auth/oidc/GloriFi?destination=/app/redirect';
  String get unqorkAuthPath => '/auth/oidc/glorifi?destination=/app/redirect';

  @override
  String get contentfulAPIKey => '8f2IfGWU2cpDUbnquF6imGdMKElzGSC2Pmd5pgwKXiI';

  @override
  String get contentfulSpacerID => '2d8t9chjyy25';

  @override
  String get rewardsBaseUrl => 'https://glorifi.bwloyalty.com';

  @override
  String get marqetaBaseUrl => 'https://coreappassets.blob.core.windows.net/\$web/index.html';
}

class UatConfig implements BaseConfig {
  @override
  String get name => Environment.uat;

  @override
  String get appUrl => 'https://app.pat-glorifi.com';

  @override
  String get websiteUrl => 'https://www.pat-glorifi.com';

  @override
  String get apiBaseUrl => 'https://animo-testapimgmt.azure-api.net';

  // Use this someday when we have real UAT
  // String get apiBaseUrl => 'https://apps-api-external.pat-glorifi.com';

  @override
  String get apiSubscriptionKey => 'A6205c845f9f4976ad2e48488d143ed7';

  @override
  bool get useMock => false;

  @override
  bool get sendAnalytics => false;

  // Okta
  @override
  String get oktaTenant => 'https://glorifisandbox.oktapreview.com';

  @override
  String get oktaIssuerPath => '/oauth2/aus2eh1u19laOvlWM1d7';

  @override
  String get bindIDClient => '0oa22l89upDJGfZgm1d7';

  @override
  String get bindIDIdp => '0oa22jiwfkkrTiGL21d7';

  @override
  String get blendSSOPath =>
      '/home/glorifisandbox_blendconsumer_1/0oa22llhpyYqtJshK1d7/aln22lozgehvsNVk31d7';

  // Vendors
  @override
  String get backbaseUrl => 'https://banking.pat-glorifi.com';

  @override
  String get bindableInsureUrl => 'https://qa-insurance.glorifi.com';

  @override
  String get bindableQuoteUrl => 'https://qa-quote.glorifi.com';

  @override
  String get vanEppsUrl => 'https://www.enrollvb.com/glorifi-demo?memberId=';

  @override
  String get unqorkUrl => 'https://purpose-uatx.unqork.io';

  // TODO remove when path is same for all envs
  @override
  String get unqorkAuthPath => '/auth/oidc/glorifi?destination=/app/redirect';

  @override
  String get contentfulAPIKey => '8f2IfGWU2cpDUbnquF6imGdMKElzGSC2Pmd5pgwKXiI';

  @override
  String get contentfulSpacerID => '2d8t9chjyy25';

  @override
  // TODO String get rewardsBaseUrl => 'https://rewards.pat-glorifi.com';
  String get rewardsBaseUrl => 'https://glorifi.bwloyalty.com';

  @override
  String get marqetaBaseUrl => 'https://coreappassets.blob.core.windows.net/\$web/index.html';
}

class ProdConfig implements BaseConfig {
  @override
  String get name => Environment.prod;

  @override
  String get appUrl => 'https://app.glorifi.com';

  @override
  String get websiteUrl => 'https://www.glorifi.com';

  @override
  String get apiBaseUrl => 'https://apps-api-external.glorifi.com';

  @override
  String get apiSubscriptionKey => '';

  @override
  bool get useMock => false;

  @override
  bool get sendAnalytics => true;

  // Okta
  @override
  String get oktaTenant => 'https://glorifi.okta.com';

  @override
  String get oktaIssuerPath => '/oauth2/auss5vqi8FbewTnKj696';

  @override
  String get bindIDClient => '0oa22l89upDJGfZgm1d7';

  @override
  String get bindIDIdp => '0oas5vkgtewDdnzJp696';

  @override
  String get blendSSOPath =>
      '/home/glorifi_blendconsumer_4/0oaratr0q91cSl1ct696/alnrawagowDssWcox696';

  // Vendors
  @override
  String get backbaseUrl => 'https://banking.glorifi.com';

  @override
  String get bindableInsureUrl => 'https://insurance.glorifi.com';

  @override
  String get bindableQuoteUrl => 'https://quote.glorifi.com';

  @override
  // TODO: implement vanEppsUrl
  String get vanEppsUrl => 'https://www.enrollvb.com/glorifi-demo?memberId=';

  @override
  String get unqorkUrl => 'https://glorifiinsurance.unqork.io';

  // TODO remove when path is same for all envs
  @override
  String get unqorkAuthPath => '/auth/oidc/Glorifi?destination=/app/redirect';

  @override
  String get contentfulAPIKey => '8f2IfGWU2cpDUbnquF6imGdMKElzGSC2Pmd5pgwKXiI';

  @override
  String get contentfulSpacerID => '2d8t9chjyy25';

  @override
  String get rewardsBaseUrl => 'https://rewards.glorifi.com';

  @override
  String get marqetaBaseUrl => r'https://coreappassets.blob.core.windows.net/$web/prod-index.html';
}

class ProdAlphaConfig implements BaseConfig {
  @override
  String get name => Environment.prod;

  @override
  String get appUrl => 'https://app.glorifi.com';

  @override
  String get websiteUrl => 'https://www.glorifi.com';

  @override
  String get apiBaseUrl => 'https://apim-app-compute-external-prod-es2.azure-api.net';

  @override
  String get apiSubscriptionKey => '';

  @override
  bool get useMock => false;

  @override
  bool get sendAnalytics => true;

  // Okta
  @override
  String get oktaTenant => 'https://glorifi.okta.com';

  @override
  String get oktaIssuerPath => '/oauth2/auss5vqi8FbewTnKj696';

  @override
  String get bindIDClient => '0oa22l89upDJGfZgm1d7';

  @override
  String get bindIDIdp => '0oas5vkgtewDdnzJp696';

  @override
  String get blendSSOPath =>
      '/home/glorifi_blendconsumer_4/0oaratr0q91cSl1ct696/alnrawagowDssWcox696';

  // Vendors
  @override
  String get backbaseUrl => 'https://banking.glorifi.com';

  @override
  String get bindableInsureUrl => 'https://insurance.glorifi.com';

  @override
  String get bindableQuoteUrl => 'https://quote.glorifi.com';

  @override
  // TODO: implement vanEppsUrl
  String get vanEppsUrl => 'https://www.enrollvb.com/glorifi-demo?memberId=';

  @override
  String get unqorkUrl => 'https://glorifiinsurance.unqork.io';

  // TODO remove when path is same for all envs
  @override
  String get unqorkAuthPath => '/auth/oidc/Glorifi?destination=/app/redirect';

  @override
  String get contentfulAPIKey => '8f2IfGWU2cpDUbnquF6imGdMKElzGSC2Pmd5pgwKXiI';

  @override
  String get contentfulSpacerID => '2d8t9chjyy25';

  @override
  String get rewardsBaseUrl => 'https://rewards.glorifi.com';

  @override
  String get marqetaBaseUrl =>
      r'https://coreappassets.blob.core.windows.net/$web/prod-index.html';
}

class Environment {
  factory Environment() {
    return _singleton;
  }

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  static const String mock = 'MOCK';
  static const String dev = 'DEV';
  static const String uat = 'UAT';
  static const String prod = 'PROD';
  static const String prodAlpha = 'PRODES2';

  late BaseConfig config;

  initConfig(String environment) {
    config = _getConfig(environment);
  }

  BaseConfig _getConfig(String environment) {
    Log.debug("***** STARTING in $environment mode *****");
    switch (environment) {
      case Environment.mock:
        return MockConfig();
      case Environment.dev:
        return DevConfig();
      case Environment.uat:
        return UatConfig();
      case Environment.prod:
        return ProdConfig();
        case Environment.prodAlpha:
        return ProdAlphaConfig();
      default:
        return DevConfig();
    }
  }
}
