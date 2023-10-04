import '../core/base/urls.dart';

const plaid_App = 'GloriFi';

//keys
const faqCategoriesKey = "faqCategories";
const faqAnswerKey = "faqAnswerKey"; //Key of faq categories in Cache.
const gemIndexingKey = "gemIndexing"; //Key of faq categories in Cache.
const actionKey = "action"; //Key of faq categories in Cache.
const destinationKey = "destination"; //Key of faq categories in Cache.
const destinationFAQ = "faq"; //Key of faq categories in Cache.
const redirection = "redirection"; //Key of faq categories in Cache.
const categoryKey = "category"; //Key of faq categories in Cache.

//fonts

const fontUnivers = "univers";
const fontOpenSans = "OpenSans";

//urlSuffix
const retailApp = "/static/retail-app"; //view existing Glorifi account
const onBoarding = "/onboarding-app/onboarding-us"; //create new Glorifi account

//user error messages
const networkError = 'Something went wrong. Please try again.';
const serverError = 'Internal server error. Please try again';
const serverConnectionError = 'Could not connect to the server.';
const resourceNotFound = 'Resource not found';

//support emails
const GeneralSupportEmail = 'General-support@glorifi.com';
const InsuranceSupportEmail = 'insurance-support@glorifi.com';
const MortgageSupportEmail = 'mortgage-support@glorifi.com';
const BankingSupportEmail = 'bank-support@animobancorp.com';
const AgentSupportEmail = 'agent-mlo@glorifi.com';

//support phone
const AgentSupportPhone = '555 555-5555';

final Map bindableUrlMap = {
  "ho3": "${Urls.bindableQuoteBaseUrl}${Urls.bindableHomePath}",
  "ho6": "${Urls.bindableQuoteBaseUrl}${Urls.bindableHomePath}",
  "ho4": "${Urls.bindableQuoteBaseUrl}${Urls.bindableRentersPath}",
  "ao1": "${Urls.bindableQuoteBaseUrl}${Urls.bindableAutoPath}"
};

//Support bottom sheet navigation index map
const FaqCategoryListingScreen = 0;
const FAQListingScreen = 1;
const FAQAnswerScreen = 2;
const FaqSearchScreen = 3;
const ContactSupportCategoryScreen = 4;
const ContactSupportScreen = 5;
const GuestUserFormScreen = 6;
const MessageUsScreen = 7;
const ChatWebViewScreen = 8;
const RequestCallbackScreen = 9;
const CallBackSuccessScreen = 10;
const EmailSentSuccessScreen = 11;
const EmailSentErrorScreen = 12;
const ContactSupportErrorScreen = 13;
