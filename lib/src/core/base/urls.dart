import 'package:glorifi/src/environment/environment.dart';

class Urls {
  static final String appUrl = Environment().config.appUrl;
  static final String websiteUrl = Environment().config.websiteUrl;

  static final String privacyPolicyUrl =
      'https://www.glorifi.com/privacy-policy';
  static final String termsAndConditionUrl =
      'https://www.glorifi.com/terms-and-conditions';

  // Okta
  static final String oktaBaseUrl = Environment().config.oktaTenant;
  static final String oktaIssuerPath = Environment().config.oktaIssuerPath;
  static final String oktaIssuerUrl = '${oktaBaseUrl}${oktaIssuerPath}';
  static final String oktaRedirectUrl = 'com.glorifi.app://loginCallback';
  static final String oktaLogoutRedirectUrl = 'com.glorifi.app://logoutCallback';

  // Blend
  static final String blendSSOUrl = '${oktaBaseUrl}${Environment().config.blendSSOPath}';

  // Unqork
  static final String unqorkBaseUrl = Environment().config.unqorkUrl;
  static final String unqorkAuthUrl =
      '${unqorkBaseUrl}${Environment().config.unqorkAuthPath}';
  static final String unqorkUnauthUrl = '${unqorkBaseUrl}/app/redirectunauthenticated';
  static final String unqorkHomeownerParams = 'params=ho3';
  static final String unqorkCondoParams = 'params=ho6';
  static final String unqorkRenterParams = 'params=ho4';
  static final String unqorkAutoParams = 'params=ao1';

  // Bindable
  static final String bindableInsureBaseUrl = Environment().config.bindableInsureUrl;
  static final String bindableQuoteBaseUrl = Environment().config.bindableQuoteUrl;
  static final String bindablePetPath = '/pet-insurance?external_id=';
  static final String bindableFloodPath = '/flood-insurance?external_id=';
  static final String bindableUmbrellaPath = '/umbrella-insurance?external_id=';
  static final String bindableBoatPath = '/boat-insurance?external_id=';
  static final String bindableMotorcyclePath = '/start-motorcycle?external_id=';
  static final String bindableHomePath = '/start-home?external_id=';
  static final String bindableRentersPath = '/start-renters?external_id=';
  static final String bindableAutoPath = '/start-auto?external_id=';

  // Rewards
  static final String rewardsBaseUrl = Environment().config.rewardsBaseUrl;

  // Marqeta
  static final String setPinUrl = Environment().config.marqetaBaseUrl;

  // EBS Statements
  static String statementUrl(String docId, String token) =>
      '${Environment().config.apiBaseUrl}/core/banking/statements/document/$docId?accessToken=$token';
}
