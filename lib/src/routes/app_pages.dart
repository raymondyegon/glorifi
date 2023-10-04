import 'package:brokerage/brokerage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/bindings/cockpit_bindings.dart';
import 'package:glorifi/src/bindings/compare_user_binding.dart';
import 'package:glorifi/src/bindings/create_acc_bindings.dart';
import 'package:glorifi/src/bindings/credit_card_bindings.dart';
import 'package:glorifi/src/bindings/credit_faq_bindings.dart';
import 'package:glorifi/src/bindings/credit_score_detail_screen_binding.dart';
import 'package:glorifi/src/bindings/credit_usage_binding.dart';
import 'package:glorifi/src/bindings/demo_image_picker_binding.dart';
import 'package:glorifi/src/bindings/deposit_check_camera_bindings.dart';
import 'package:glorifi/src/bindings/dev_zone_bindings.dart';
import 'package:glorifi/src/bindings/enable_credit_score_step1_name_binding.dart';
import 'package:glorifi/src/bindings/enable_credit_score_step2_address_binding.dart';
import 'package:glorifi/src/bindings/enable_credit_score_step3_ssn_binding.dart';
import 'package:glorifi/src/bindings/enable_credit_score_step4_phone_binding.dart';
import 'package:glorifi/src/bindings/home_value_binding.dart';
import 'package:glorifi/src/bindings/insurance_bindings.dart';
import 'package:glorifi/src/bindings/insurance_category_bindings.dart';
import 'package:glorifi/src/bindings/mobile_deposit_bindings.dart';
import 'package:glorifi/src/bindings/mortgage_bindings.dart';
import 'package:glorifi/src/bindings/mortgage_detail_bindings.dart';
import 'package:glorifi/src/bindings/my_bank_bindings.dart';
import 'package:glorifi/src/bindings/text_field_bindings.dart';
import 'package:glorifi/src/bindings/video_bindings.dart';
import 'package:glorifi/src/create-account/create_account_page.dart';
import 'package:glorifi/src/feature/Brokerage/brokerage_main.dart';
import 'package:glorifi/src/feature/app_lock/bindings/app_lock_bindings.dart';
import 'package:glorifi/src/feature/app_lock/views/app_lock_screen.dart';
import 'package:glorifi/src/feature/atms/find_atms_screen.dart';
import 'package:glorifi/src/feature/backbase/backbase_screen.dart';
import 'package:glorifi/src/feature/banking/account_details_screen.dart';
import 'package:glorifi/src/feature/banking/consent/check_deposit_consent.dart';
import 'package:glorifi/src/feature/banking/consent/check_deposit_terms.dart';
import 'package:glorifi/src/feature/banking/deposit_check/back_check_photo_confirmation.dart';
import 'package:glorifi/src/feature/banking/deposit_check/deposit_check_camera_screen.dart';
import 'package:glorifi/src/feature/banking/deposit_check/mobile_deposit_accepted.dart';
import 'package:glorifi/src/feature/banking/deposit_check/mobile_deposit_in_review.dart';
import 'package:glorifi/src/feature/banking/deposit_check/mobile_deposit_screen.dart';
import 'package:glorifi/src/feature/banking/deposit_check/mobile_deposit_to_screen.dart';
import 'package:glorifi/src/feature/banking/deposit_check/mobile_deposit_verifying_check_screen.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/check_review_actions.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/deposited_checks.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/print.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/view_check.dart';
import 'package:glorifi/src/feature/banking/manage_account/manage_account_screen.dart';
import 'package:glorifi/src/feature/banking/my_banking_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_binding.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_select_product_group_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_binding.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/account_details/ebs_account_details_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/account_details/ebs_all_transactions_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/account_details/ebs_transaction_detail_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/account_settings/ebs_wire_instructions.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_screen.dart';
import 'package:glorifi/src/feature/banking/sign_up_in_minutes_screen.dart';
import 'package:glorifi/src/feature/bundle_completed/bindings/bundle_complete_binding.dart';
import 'package:glorifi/src/feature/bundle_completed/views/bundle_complete_screen.dart';
import 'package:glorifi/src/feature/bundles/bindings/bundle_bindings.dart';
import 'package:glorifi/src/feature/bundles/bundles.dart';
import 'package:glorifi/src/feature/cockpit/cockpit_screen.dart';
import 'package:glorifi/src/feature/cockpit/cockpit_screen.dart';
import 'package:glorifi/src/feature/cockpit/common_widgets/referral.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/accounts_screen.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/bindings/explore_bindings.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/explore/explore_screen.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_feed.dart';
import 'package:glorifi/src/feature/cockpit/feed_sections/navigation/accounts.dart';
import 'package:glorifi/src/feature/cockpit/feed_sections/navigation/money.dart';
import 'package:glorifi/src/feature/cockpit/profile/linkedScreens/alerts.dart';
import 'package:glorifi/src/feature/cockpit/profile/linkedScreens/profile.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_error_handle/bindings/profile_error_handle_binding.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_error_handle/views/profile_error_handle_view.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/notifications.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/bindings/reward_landing_binding.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/views/reward_landing_view.dart';
import 'package:glorifi/src/feature/credit_card/credit_card_coming_soon.dart';
import 'package:glorifi/src/feature/credit_card/credit_card_faq.dart';
import 'package:glorifi/src/feature/credit_card/credit_card_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/activate_physical_card/binding/cc_activate_physical_card_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/activate_physical_card/screen/cc_activate_card_failure_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/activate_physical_card/screen/cc_activate_card_success_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/activate_physical_card/screen/cc_activate_card_verification_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/bindings/acc_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/feedback/acc_application_in_progress_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/feedback/acc_application_in_review_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/acc_choose_credit_card_type_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/card_holder_agreement/acc_accept_card_holder_agreement.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/feedback/acc_resume_application_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/employment_status/acc_employment_status_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/expense/acc_accommodation_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/expense/acc_housing_cost_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/expense/binding/expense_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/acc_address_info_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/acc_contact_info_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/acc_personal_info_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/acc_verify_ssn_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/kyc/binding/kyc_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/bindings/cc_details_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/screen/basic_card_details_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/screen/brass_card_details_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/offers/acc_offer_blue_and_gold_credit_card_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/offers/acc_offer_blue_credit_card_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/offers/acc_offer_brass_card_details_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/offers/acc_offer_choose_card_design_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/offers/acc_offer_gold_credit_card_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/review_application/acc_review_application_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/entrypoint/screen/credit_card_benefits_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/exit/acc_card_cancelation.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/exit/acc_confirm_card_cancelation.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/exit/acc_frozen_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/exit/acc_not_approved_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/exit/acc_not_available_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/exit/acc_ssn_error_feedback_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/processing/acc_processing_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/processing/acc_processing_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/cc_dashboard_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/screens/cc_dashboard_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/bindings/identity_check_bindings.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/screens/acc_verify_identity_part1.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/screens/capture_id_back_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/screens/capture_id_front_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/screens/capture_selfie_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/screens/verify_identity_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/binding/cc_manage_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/binding/credit_limit_and_apr_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/screen/cc_manage_report_card_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/screen/cc_manage_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/screen/credit_limit_and_apr_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/bindings/cc_payments_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_auto_pay_info_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payment_amount_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/statements/bindings/cc_statements_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/statements/screens/cc_statements_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/binding/cc_transaction_detail_binding.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/screens/cc_transaction_detail_screen.dart';
import 'package:glorifi/src/feature/dev/dev_zone_screen.dart';
import 'package:glorifi/src/feature/errors/widget/error_outside_usa_widget.dart';
import 'package:glorifi/src/feature/insurance/insurance_category_list.dart';
import 'package:glorifi/src/feature/insurance/insurance_screens.dart';
import 'package:glorifi/src/feature/insurance/roadside_assistance.dart';
import 'package:glorifi/src/feature/investment/binding/investment_signup_bindings.dart';
import 'package:glorifi/src/feature/investment/binding/investment_stock_selection_bindings.dart';
import 'package:glorifi/src/feature/investment/binding/user_name_bindings.dart';
import 'package:glorifi/src/feature/investment/get_started/get_started_screen.dart';
import 'package:glorifi/src/feature/investment/signup/signup_screen.dart';
import 'package:glorifi/src/feature/investment/stock/stock_selection_screen.dart';
import 'package:glorifi/src/feature/investment/user_details/user_dob_screen.dart';
import 'package:glorifi/src/feature/investment/user_details/user_gender_screen.dart';
import 'package:glorifi/src/feature/legal/bindings/legal_bindngs.dart';
import 'package:glorifi/src/feature/legal/views/legal_screen.dart';
import 'package:glorifi/src/feature/mortgage/mortgage_detail_screen.dart';
import 'package:glorifi/src/feature/mortgage/mortgage_detail_submitted_screen.dart';
import 'package:glorifi/src/feature/mortgage/mortgage_pre_apply_screen.dart';
import 'package:glorifi/src/feature/mortgage/mortgage_screen.dart';
import 'package:glorifi/src/feature/my_credit_card/credit_card_account/my_credit_card_screen.dart';
import 'package:glorifi/src/feature/onboard/all_products/bindings/all_products_binding.dart';
import 'package:glorifi/src/feature/onboard/all_products/views/all_products_view.dart';
import 'package:glorifi/src/feature/onboard/app_unlock/app_unlock.dart';
import 'package:glorifi/src/feature/onboard/communications/bindings/communications_binding.dart';
import 'package:glorifi/src/feature/onboard/communications/views/communications_view.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/create_profile_plus.dart';
import 'package:glorifi/src/feature/onboard/documents/bindings/documents_binding.dart';
import 'package:glorifi/src/feature/onboard/documents/views/documents_view.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_phone_number/bindings/edit_phone_number_binding.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_phone_number/views/edit_phone_number_view.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_preferred_name/bindings/edit_preferred_name_binding.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_preferred_name/views/edit_preferred_name_view.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/bindings/edit_profile_bindings.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/view/edit_profile_landing.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/contact_info.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/glorifi_account.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/login_credentials.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_success/bindings/edit_profile_success_binding.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_success/views/edit_profile_success_view.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_zip_code/bindings/edit_zip_code_binding.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_zip_code/views/edit_zip_code_view.dart';
import 'package:glorifi/src/feature/onboard/login/bindings/login_bindings.dart';
import 'package:glorifi/src/feature/onboard/login/views/login_screen.dart';
import 'package:glorifi/src/feature/onboard/splash/bindings/splash_bindings.dart';
import 'package:glorifi/src/feature/onboard/splash/screen/splash_screen.dart';
import 'package:glorifi/src/feature/onboard/unsafe_device_detected/bindings/unsafe_device_detected_binding.dart';
import 'package:glorifi/src/feature/onboard/unsafe_device_detected/views/unsafe_device_detected_view.dart';
import 'package:glorifi/src/feature/onboard/value/bindings/value_binding.dart';
import 'package:glorifi/src/feature/onboard/value/views/value_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/creditUsage/credit_usage_details_view.dart';
import 'package:glorifi/src/feature/personal_snapshot/creditUsage/credit_usage_view.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/credit_score_retrive_success.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/credit_score_detail_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/enable_credit_score_step1_name.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/enable_credit_score_step2_address.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/enable_credit_score_step3_ssn.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/enable_credit_score_step4_phone.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/enable_credit_score_success_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/home_value_details_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/home_value_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/select_address_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/success_address_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/manage_accounts_snapshot_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/manage/unlink_account/unlink_account_success_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/net_worth_binding.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/net_worth_detail_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_bindings.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_accounts_opened/enable_to_see_data_screen.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_accounts_opened/personal_snapshot_full_state.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/total_debt_bindings.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/total_debt_detail_screen.dart';
import 'package:glorifi/src/feature/plaid/plaid_demo.dart';
import 'package:glorifi/src/feature/plaid/plaid_success_screen.dart';
import 'package:glorifi/src/feature/policy_detail/bindings/policy_detail_binding.dart';
import 'package:glorifi/src/feature/policy_detail/policy_detail_screen.dart';
import 'package:glorifi/src/feature/policy_detail/policy_documents.dart';
import 'package:glorifi/src/feature/policy_detail/submit_claim.dart';
import 'package:glorifi/src/feature/products/common_screen/welcome_to_glorifi_screen.dart';
import 'package:glorifi/src/feature/support/callback/callback_success_screen.dart';
import 'package:glorifi/src/feature/support/callback/request_call_back_screen.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/contact_support_category_screen.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/contact_support_screen.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/guest_user_form_screen.dart';
import 'package:glorifi/src/feature/support/message_us/message_us_screen.dart';
import 'package:glorifi/src/feature/support/success_error_empty_state/contact_support_error_screen.dart';
import 'package:glorifi/src/feature/support/success_error_empty_state/email_sent_error_screen.dart';
import 'package:glorifi/src/feature/support/success_error_empty_state/email_sent_success_screen.dart';
import 'package:glorifi/src/feature/text_widget_demo/text_field_widget.dart';
import 'package:glorifi/src/feature/unqork/unqork_screen.dart';
import 'package:glorifi/src/feature/update_handler/bindings/update_handler_bindings.dart';
import 'package:glorifi/src/feature/update_handler/screen/update_handler_screen.dart';
import 'package:glorifi/src/feature/video/video_player.dart';
import 'package:glorifi/src/glorifi-widgets/second_page.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/compare_option_details_view.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/compare_option_view.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/compare_result_view.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/user_info_view.dart';
import 'package:glorifi/src/routes/web_auth_callback_screen.dart';
import 'package:glorifi/src/sample_feature/image_picker.dart';
import 'package:glorifi/src/sample_feature/sample_item_details_view.dart';

import '../bindings/faq_categories_bindings.dart';
import '../bindings/mortgage_pre_apply_bindings.dart';
import '../feature/cockpit/feed2.0/snapshot/sections/insights/insights_story/insights_story.dart';
import '../feature/credit_card/apply_for_credit_card.dart';
import '../feature/credit_card/credit_card_unavailable_screen.dart';
import '../feature/insurance/continue_create_quote.dart';
import '../feature/mortgage/blend_sso/connect_blend_sso_screen.dart';
import '../feature/mortgage/mortgage_unavailable_screen.dart';
import '../feature/personal_snapshot/manage/screens/manage_personal_snapshot_screen.dart';
import '../feature/personal_snapshot/total_accounts_opened/total_accounts_opened_screen.dart';
import '../feature/support/faq/faq_answer_screen.dart';
import '../feature/support/faq/faq_categories_page.dart';
import '../feature/support/faq/faq_listing_screen.dart';
import '../feature/support/faq/faq_search_screen.dart';
import '../utils/responsive/responsive.dart';
import 'auth_middleware.dart';

// Project imports:
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: kIsWeb ? Routes.splash : Routes.initial,
      page: () => const SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
        name: Routes.devZone,
        page: () => const DevZoneScreen(),
        binding: DevZoneBindings()),
    GetPage(
      name: kIsWeb ? Routes.initial : Routes.login,
      page: () => LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.cockpit,
      page: () => CockpitScreen(),
      binding: CockpitBindings(),
    ),
    GetPage(
      name: Routes.reward,
      page: () => RewardLandingView(),
      binding: RewardLandingBinding(),
    ),

    GetPage(
      name: Routes.referral,
      page: () => Referral(),
    ),

    GetPage(
      name: Routes.createProfilePlus,
      page: () => CreateProfilePlus(),
    ),
    GetPage(
      name: Routes.sampleItem,
      page: () => const SampleItemDetailsView(),
    ),

    GetPage(
      name: Routes.mortgage,
      page: () => MortgageScreen(),
      binding: MortgageBindings(),
    ),
    GetPage(
      name: Routes.mortgagePreApply,
      page: () => MortgagePreApplyScreen(),
      binding: MortgagePreApplyBindings(),
    ),

    GetPage(
      name: Routes.connectBlendSso,
      page: () => ConnectBlendSsoScreen(),
    ),

    GetPage(
      name: Routes.insurance,
      page: () => const InsuranceScreen(),
    ),

    GetPage(
      name: Routes.accountDetails,
      page: () => const AccountDetails(),
    ),
    GetPage(
      name: Routes.createAccount,
      page: () => const CreateAccountPage(),
      binding: CreateAccountBindings(),
    ),
    GetPage(
      name: Routes.secondpage,
      page: () => const SecondPage(),
      binding: CreateAccountBindings(),
    ),
    GetPage(
        name: Routes.valueScreens,
        page: () => ValueScreen(),
        binding: ValueBindings()),
    GetPage(
      name: Routes.unqorkPage,
      page: () => UnqorkScreen(),
    ),
    GetPage(
      name: Routes.backbasePage,
      page: () => BackBaseScreen(),
    ),
    GetPage(
      name: Routes.welcomeToGlorifi,
      page: () => WelcomeToGlorifi(),
    ),
    GetPage(
      name: Routes.signUpInMinutes,
      page: () => SignUpInMinutes(),
    ),
    GetPage(
      name: Routes.editProfileLanding,
      page: () => EditProfileLanding(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.contactInfo,
      page: () => ContactInfo(),
    ),
    GetPage(
      name: Routes.glorifiAccount,
      page: () => GlorifiAccount(),
    ),
    GetPage(
      name: Routes.loginCredentials,
      page: () => LoginCredentials(),
    ),
    GetPage(
      name: Routes.snapshot,
      page: () => SnapshotFeed(),
    ),
    GetPage(name: Routes.accounts, page: () => AccountsScreen()),
    GetPage(
      name: Routes.totalDebtDetailScreen,
      page: () => TotalDebtDetailScreen(),
      binding: TotalDebtBindings(),
    ),
    GetPage(
      name: Routes.netWorthDetailScreen,
      page: () => NetWorthDetailScreen(),
      binding: NetWorthBindings(),
    ),
    GetPage(
      name: Routes.investmentDOB,
      page: () => UserDOBScreen(),
      binding: UserNameBindings(),
    ),
    GetPage(
      name: Routes.investmentGender,
      page: () => UserGenderScreen(),
      binding: UserNameBindings(),
    ),
    GetPage(
      name: Routes.stockSelection,
      page: () => const StockSelectionScreen(),
      binding: StockSelectionBindings(),
    ),
    GetPage(
      name: Routes.getStarted,
      page: () => const GetStartedScreen(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
      middlewares: [EnsureNotAuthedMiddleware()],
    ),
    GetPage(
      name: Routes.imagePickerDemo,
      page: () => ImagePicker(),
      binding: DemoImagePickerBinding(),
    ),
    //Insights Pages

    GetPage(
      name: Routes.brokerageMainPage,
      page: () => BrokerageMainPage(),
      binding: CreditCardBindings(),
    ),
    GetPage(
      name: Routes.insightsStory,
      page: () => InsightsStory(),
    ),

    GetPage(
      name: Routes.money,
      page: () => Money(),
    ),
    GetPage(
      name: Routes.accounts,
      page: () => Accounts(),
    ),
    GetPage(
      name: Routes.alerts,
      page: () => Alerts(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => Profile(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => LegalScreen(),
      binding: LegalBindings(),
    ),
    GetPage(
        name: Routes.video,
        page: () => VideoPlayerDemo(),
        binding: VideoPlayerBinding()),
    GetPage(
        name: Routes.creditCardFAQ,
        page: () => CreditCardFAQ(),
        binding: CreditCardFAQBindings()),
    GetPage(
        name: Routes.creditCardScreen,
        page: () => CreditCardScreen(),
        binding: CreditCardBindings()),
    GetPage(
      name: Routes.applyForCreditCardScreen,
      page: () => ApplyForCreditCard(),
    ),

    /// Credit Card (NEW FLOW)
    GetPage(
      name: Routes.accApplicationInProgress,
      page: () => ACCApplicationInProgressScreen(),
    ),
    GetPage(
      name: Routes.accApplicationInReview,
      page: () => ACCApplicationInReviewScreen(),
    ),
    GetPage(
      name: Routes.accResumeApplication,
      page: () => ACCResumeApplicationScreen(),
    ),
    GetPage(
      name: Routes.creditCardBenefits,
      page: () => CreditCardBenefitsScreen(),
      bindings: [ACCBinding(), CCDetailsBinding()],
    ),
    GetPage(
      name: Routes.accPersonalInfo,
      page: () => ACCPersonalInformationScreen(),
      bindings: [KYCBinding()],
    ),
    GetPage(
      name: Routes.accContactInfo,
      page: () => ACCContactInfoScreen(),
    ),
    GetPage(
      name: Routes.accAddress,
      page: () => ACCAddressScreen(),
    ),
    GetPage(
      name: Routes.accAccommodation,
      page: () => ACCAccommodationScreen(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: Routes.accHousingCost,
      page: () => ACCHousingCostScreen(),
    ),
    GetPage(
      name: Routes.accVerifySSN,
      page: () => ACCVerifySSNScreen(),
    ),
    GetPage(
      name: Routes.accProcessing,
      page: () => ACCProcessingScreen(),
      binding: ACCProcessingBinding(),
    ),
    GetPage(
      name: Routes.accChooseCreditCardType,
      page: () => ACCChooseCreditCardTypeScreen(),
    ),
    GetPage(
      name: Routes.accChooseCreditCardDesign,
      page: () => ACCChooseCardDesignScreen(),
    ),
    GetPage(
      name: Routes.accEmploymentStatus,
      page: () => ACCEmploymentStatusScreen(),
    ),
    GetPage(
      name: Routes.accSSNErrorFeedback,
      page: () => ACCSSNErrorFeedbackScreen(),
    ),

    GetPage(
      name: Routes.creditCardFAQ,
      page: () => CreditCardFAQ(),
      binding: CreditCardFAQBindings(),
    ),

    GetPage(
      name: Routes.insuranceCategoryList,
      page: () => const InsuranceCategoryList(),
      binding: InsuranceCategoryBindings(),
    ),
    GetPage(
      name: Routes.creditUsage,
      page: () => CreditUsageView(),
      binding: CreditUsageBindings(),
    ),
    GetPage(
      name: Routes.creditUsageDetails,
      page: () => CreditUsageDetailsView(),
      binding: CreditUsageBindings(),
    ),
    GetPage(
      name: Routes.compareUser,
      page: () => UserInfoView(),
    ),
    GetPage(
      name: Routes.compareOptionView,
      page: () => CompareOptionView(),
      binding: CompareUserBinding(),
    ),
    GetPage(
      name: Routes.compareOptionDetailsView,
      page: () => CompareOptionDetailsView(),
      binding: CompareUserBinding(),
    ),
    GetPage(
      name: Routes.compareResultView,
      page: () => CompareResultView(),
      binding: CompareUserBinding(),
    ),
    GetPage(
      name: Routes.insuranceScreen,
      page: () => InsuranceScreen(),
      binding: InsuranceBindings(),
    ),
    GetPage(
      name: Routes.homeValueDetailsScreen,
      page: () => HomeValueDetailsScreen(),
      binding: HomeValueBindings(),
    ),
    GetPage(
      name: Routes.selectAddressScreen,
      page: () => SelectAddressScreen(),
      binding: HomeValueBindings(),
    ),
    GetPage(
      name: Routes.successAddressScreen,
      page: () => SuccessAddressScreen(),
      binding: HomeValueBindings(),
    ),
    GetPage(
      name: Routes.myBanking,
      page: () => MyBankingScreen(),
      binding: MyBankBindings(),
    ),
    GetPage(
      name: Routes.mobileDeposit,
      page: () => MobileDepositScreen(),
      binding: MobileDepositBindings(),
    ),
    GetPage(
      name: Routes.mobileDepositVerifyingCheck,
      page: () => MobileDepositVerifyingCheckScreen(),
      binding: MobileDepositBindings(),
    ),
    GetPage(
      name: Routes.mobileDepositTo,
      page: () => MobileDepositToScreen(),
      binding: MobileDepositBindings(),
    ),
    GetPage(
      name: Routes.mobileDepositAccepted,
      page: () => MobileDepositAcceptedScreen(),
    ),
    GetPage(
      name: Routes.mobileDepositInReview,
      page: () => MobileDepositInReviewScreen(),
    ),
    GetPage(
      name: Routes.checkReviewActions,
      page: () => CheckViewReviewActionsScreen(),
    ),
    GetPage(
      name: Routes.checkPrint,
      page: () => Print(),
      binding: MobileDepositBindings(),
    ),

    GetPage(
      name: Routes.depositedChecks,
      page: () => DepositedChecksScreen(),
      binding: MobileDepositBindings(),
    ),
    GetPage(
      name: Routes.viewCheck,
      page: () => ViewCheck(),
      binding: MobileDepositBindings(),
    ),
    GetPage(
      name: Routes.cashOnHand,
      page: () => CashOnHandScreen(),
    ),
    GetPage(
      name: Routes.appUnlock,
      page: () => AppUnlock(),
    ),
    GetPage(
      name: Routes.totalAccountsOpened,
      page: () => TotalAccountsOpenedScreen(),
    ),
    GetPage(
      name: Routes.enableToSeeData,
      page: () => EnableToSeeDataScreen(),
    ),
    GetPage(
      name: Routes.personalSnapShotFullState,
      page: () => PersonalSnapshotsFullState(),
    ),
    GetPage(
      name: Routes.faqCategoriesListingScreen,
      // binding: FAQCategoriesBindings(),
      page: () => FAQCategoryListingScreen(),
    ),
    GetPage(
      name: Routes.faqQuestionsListingScreen,
      page: () => FAQListingScreen(),
    ),
    GetPage(
        name: Routes.messageUsScreen,
        page: () => MessageUsScreen(),
        binding: FAQCategoriesBindings()),
    GetPage(
        name: Routes.emailSentSuccessScreen,
        page: () => EmailSuccessScreen(),
        binding: FAQCategoriesBindings()),
    GetPage(
        name: Routes.faqAnswerScreen,
        page: () => FAQAnswerScreen(),
        binding: FAQCategoriesBindings()),
    GetPage(
      name: Routes.contactSupportCategoryScreen,
      page: () => ContactSupportCategoryScreen(),
      binding: FAQCategoriesBindings(),
    ),
    GetPage(
      name: Routes.guestUserFormScreen,
      page: () => GuestUserFormScreen(),
      binding: FAQCategoriesBindings(),
    ),
    GetPage(
      name: Routes.requestCallBack,
      page: () => RequestCallbackScreen(),
      binding: FAQCategoriesBindings(),
    ),
    GetPage(
      name: Routes.callbackSuccess,
      page: () => CallbackSuccessScreen(),
      binding: FAQCategoriesBindings(),
    ),
    GetPage(
      name: Routes.emailSentError,
      page: () => EmailSentErrorScreen(),
      binding: FAQCategoriesBindings(),
    ),
    GetPage(
      name: Routes.homeValueScreen,
      page: () => HomeValueScreen(),
      binding: HomeValueBindings(),
    ),
    GetPage(
      name: Routes.reusableTextWidget,
      page: () => TextFiledWidget(),
      binding: TextFiledWidgetBindings(),
    ),
    GetPage(
      name: Routes.contactSupportScreen,
      page: () => ContactSupportScreen(),
      binding: FAQCategoriesBindings(),
    ),
    GetPage(
      name: Routes.brokerage,
      page: () {
        initializeBrokerage();
        return BrokerageHomePage();
      },
    ),
    GetPage(
      name: Routes.ALL_PRODUCTS,
      page: () => AllProductsView(),
      binding: AllProductsBinding(),
    ),

    GetPage(
      name: Routes.notificationList,
      page: () => Notifications(),
    ),
    GetPage(
      name: Routes.COMMUNICATIONS,
      page: () => CommunicationsView(),
      binding: CommunicationsBinding(),
    ),
    GetPage(
      name: Routes.DOCUMENTS,
      page: () => DocumentsView(),
      binding: DocumentsBinding(),
    ),
    GetPage(
        name: Routes.searchFaqScreen,
        page: () => FaqSearchScreen(),
        binding: FAQCategoriesBindings()),
    GetPage(
      name: Routes.managePersonalSnapshotScreen,
      page: () => ManagePersonalSnapshotScreen(),
    ),
    GetPage(
      name: Routes.manageAccountSnapshotScreen,
      page: () => ManageAccountsSnapshotScreen(),
    ),
    GetPage(
        name: Routes.unlinkAccountSuccessScreen,
        page: () => UnlinkAccountSuccessScreen()),
    GetPage(
      name: Routes.checkDepositConsent,
      page: () => CheckDepositConsentScreen(),
      binding: MobileDepositBindings(),
    ),
    GetPage(
      name: Routes.checkDepositTerms,
      page: () => CheckDepositTermsScreen(),
      binding: MobileDepositBindings(),
    ),
    GetPage(
      name: Routes.checkDepositCamera,
      page: () => DepositCheckCameraScreen(),
      binding: DepositCheckCameraBinding(),
    ),
    GetPage(
      name: Routes.checkDepositCameraBackConfirmation,
      page: () => BackCheckPhotoConfirmation(),
    ),
    GetPage(
      name: Routes.manageAccount,
      page: () => ManageAccountScreen(),
    ),
    GetPage(
      name: Routes.plaidDemo,
      page: () => PlaidDemo(),
    ),
    GetPage(
      name: Routes.plaidSuccessScreen,
      page: () => PlaidSuccessScreen(),
    ),
    GetPage(
      name: Routes.enableCreditScoreStep1Name,
      page: () => const EnableCreditScoreStep1Name(),
      binding: EnableCreditScoreStep1NameBinding(),
    ),
    GetPage(
      name: Routes.enableCreditScoreStep2Address,
      page: () => const EnableCreditScoreStep2Address(),
      binding: EnableCreditScoreStep2AddressBinding(),
    ),
    GetPage(
      name: Routes.enableCreditScoreStep3SSN,
      page: () => const EnableCreditScoreStep3SSN(),
      binding: EnableCreditScoreStep3SSNBinding(),
    ),
    GetPage(
      name: Routes.enableCreditScoreStep4Phone,
      page: () => EnableCreditScoreStep4Phone(),
      binding: EnableCreditScoreStep4PhoneBinding(),
    ),
    GetPage(
      name: Routes.enableCreditScoreSuccessScreen,
      page: () => EnableCreditScoreSuccessScreen(),
      //  binding: CreditScorePhoneNoBinding(),
    ),
    GetPage(
      name: Routes.creditScoreRetrieveSuccess,
      page: () => CreditScoreRetrieveSuccessView(),
      //  binding: CreditScorePhoneNoBinding(),
    ),
    GetPage(
      name: Routes.creditScoreDetailScreen,
      page: () => CreditScoreDetailScreen(),
      binding: CreditScoreDetailScreenBinding(),
    ),
    GetPage(
      name: Routes.mortgageDetail,
      page: () => const MortgageDetailScreen(),
      binding: MortgageDetailBindings(),
    ),
    GetPage(
      name: Routes.mortgageDetailSubmitted,
      page: () => const MortgageDetailSubmittedScreen(),
    ),
    GetPage(
      name: Routes.EDIT_ZIP_CODE,
      page: () => EditZipCodeView(),
      binding: EditZipCodeBinding(),
    ),
    GetPage(
      name: Routes.editPhoneNumber,
      page: () => EditPhoneNumberView(),
      binding: EditPhoneNumberBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE_SUCCESS,
      page: () => EditProfileSuccessView(),
      binding: EditProfileSuccessBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PREFERRED_NAME,
      page: () => EditPreferredNameView(),
      binding: EditPreferredNameBinding(),
    ),
    GetPage(
        name: Routes.policyDetailsScreen,
        page: () => PolicyDetailScreen(),
        binding: PolicyDetailBindings()),
    GetPage(
      name: Routes.mortgageUnavailable,
      page: () => MortgageUnavailableScreen(),
    ),
    GetPage(
      name: Routes.exploreProducts,
      binding: ExploreBinding(),
      page: () => ExploreScreen(),
    ),
    GetPage(
      name: Routes.roadsideAssistanceScreen,
      page: () => RoadsideAssistance(),
    ),
    GetPage(
      name: Routes.appLockScreen,
      binding: AppLockBindings(),
      page: () => AppLockScreen(),
    ),
    GetPage(
      name: Routes.updateHandlerScreen,
      binding: UpdateHandlerBindings(),
      page: () => UpdateHandlerScreen(),
    ),
    GetPage(
      name: Routes.submitClaimScreen,
      page: () => SubmitClaim(),
    ),
    GetPage(
      name: Routes.bundlesScreen,
      binding: BundleBindings(),
      page: () => Bundles(),
    ),
    GetPage(
      name: Routes.policyDocuments,
      page: () => PolicyDocuments(),
    ),
    GetPage(
      name: Routes.creditCardComingSoonScreen,
      page: () => CreditCardComingSoon(),
      binding: CreditCardBindings(),
    ),
    GetPage(
        name: Routes.continueCreateQuote,
        page: () => ContinueCreateQuoteScreen(),
        middlewares: [EnsureAuthMiddleware()]),
    GetPage(
      name: Routes.findAtms,
      page: () => const FindAtmsScreen(),
    ),
    GetPage(
      name: Routes.UNSAFE_DEVICE_DETECTED,
      page: () => UnsafeDeviceDetectedView(),
      binding: UnsafeDeviceDetectedBinding(),
    ),
    GetPage(
      name: Routes.myCreditCard,
      page: () => const MyCreditCardScreen(),
    ),

    GetPage(
        name: Routes.bundleComplete,
        page: () => BundleCompleteScreen(),
        binding: BundleCompleteBinding()),
    GetPage(
      name: Routes.PROFILE_ERROR_HANDLE,
      page: () => ProfileErrorHandleView(),
      binding: ProfileErrorHandleBinding(),
    ),
    GetPage(
      name: Routes.outsideUSAError,
      page: () => ErrorOutsideUSAWidget(),
    ),
    GetPage(
      name: Routes.ebsAccountDetails,
      page: () => EBSAccountDetailsScreen(),
      binding: EBSServicingBinding(),
    ),
    GetPage(
      name: Routes.ccDashboard,
      page: () => CCDashboardScreen(),
      binding: CCDashboardBinding(),
    ),
    GetPage(
      name: Routes.ccPayments,
      page: () => CCPaymentAmountScreen(),
      binding: CCPaymentBinding(),
    ),
    GetPage(
      name: Routes.ebsTransfer,
      page: () => TransferScreen(),
      binding: EBSServicingBinding(),
    ),
    GetPage(
      name: Routes.ebsTransactionDetail,
      page: () => EBSTransactionDetailScreen(),
    ),
    GetPage(
      name: Routes.openBankAccount,
      page: () => OAOSelectProductGroupScreen(),
      binding: OpenBankAccountBinding(),
    ),
    GetPage(
      name: Routes.contactSupportErrorScreen,
      page: () => ContactSupportErrorScreen(),
      binding: FAQCategoriesBindings(),
    ),
    GetPage(
      name: Routes.allTransactions,
      page: () => EBSAllTransactionsList(),
    ),
    GetPage(
      name: Routes.ebsWireInstructions,
      page: () => EBSWireInstructions(),
    ),
    GetPage(
      name: Routes.webAuthCallBack,
      page: () => WebAuthCallBackScreen(),
    ),
    GetPage(
        name: Routes.accAcceptCardAgreement,
        page: () => ACCAcceptCardAgreement()),

    GetPage(
      name: Routes.outsideUSAError,
      page: () => Scaffold(
        appBar: AppBar(
          title: const Text('Connection Outside USA Detected'),
        ),
        body: ResponsiveUtilInit(builder: () => ErrorOutsideUSAWidget()),
      ),
    ),
    GetPage(
      name: Routes.accFrozenScreen,
      page: () => ACCFrozenScreen(),
    ),
    GetPage(
      name: Routes.accOfferGoldCreditCardScreen,
      page: () => ACCOfferGoldCreditCardScreen(),
    ),
    GetPage(
      name: Routes.accNotApprovedScreen,
      page: () => ACCNotApprovedScreen(),
    ),
    GetPage(
      name: Routes.accOfferBlueCreditCardScreen,
      page: () => ACCOfferBlueCreditCardScreen(),
    ),
    GetPage(
      name: Routes.accOfferBlueAndGoldCreditCardScreen,
      page: () => ACCOfferBlueAndGoldCreditCardScreen(),
    ),
    GetPage(
      name: Routes.creditCardUnavailable,
      page: () => CreditCardUnavailable(),
      binding: CreditCardBindings(),
    ),
    GetPage(
      name: Routes.accCardCancelation,
      page: () => ACCCardCancelation(),
    ),
    GetPage(
      name: Routes.accConfirmCardCancelation,
      page: () => ACCConfirmCardCancellation(),
    ),
    GetPage(
      name: Routes.accReviewApplicationScreen,
      page: () => ACCReviewApplicationScreen(),
    ),
    GetPage(
      name: Routes.brassCardDetails,
      page: () => BrassCardDetailsScreen(),
    ),
    GetPage(
      name: Routes.basicCardDetails,
      page: () => BasicCardDetailsScreen(),
    ),
    GetPage(
      name: Routes.accNotAvailableScreen,
      page: () => ACCNotAvailableScreen(),
    ),
    GetPage(
      name: Routes.accVerifyIdentity,
      page: () => ACCVerifyIdentityPart1(),
    ),
    GetPage(
        name: Routes.ccTransactionDetailsScreen,
        page: () => CCTransactionDetailScreen(),
        binding: CCTransactionDetailBinding()),

    GetPage(
      name: Routes.creditCardStatementsScreen,
      page: () => CCStatementsScreen(),
      binding: CCStatementsBinding(),
    ),
    GetPage(
      name: Routes.captureIdFrontScreen,
      page: () => CaptureIdFrontScreen(),
      binding: IdentityCheckBindings(),
    ),
    GetPage(
      name: Routes.captureIdBackScreen,
      page: () => CaptureIdBackScreen(),
      binding: IdentityCheckBindings(),
    ),

    GetPage(
      name: Routes.captureSelfieScreen,
      page: () => CaptureSelfieScreen(),
      binding: IdentityCheckBindings(),
    ),
    GetPage(
      name: Routes.idVerificationScreen,
      page: () => VerifyIdentityScreen(),
      binding: IdentityCheckBindings(),
    ),
    GetPage(
      name: Routes.ccActivatePhysicalCard,
      page: () => CCActivateCardVerificationScreen(),
      binding: CCActivatePhysicalCardBinding(),
    ),
    GetPage(
      name: Routes.ccActivatePhysicalCardSuccess,
      page: () => CCActivateCardSuccessScreen(),
    ),

    GetPage(
      name: Routes.savingsRetirementScreen,
      page: () => RetirementScreen(),
      binding: SavingsRetirementBindings(),
    ),

    GetPage(
      name: Routes.ccActivatePhysicalCardFailure,
      page: () => CCActivateCardFailureScreen(),
    ),
    GetPage(
      name: Routes.accOfferBrassCardDetailsScreen,
      page: () => AccOfferBrassCardDetailsScreen(),
    ),
    GetPage(
      name: Routes.ccManage,
      page: () => CCManageScreen(),
      binding: CCManageBinding(),
    ),
    GetPage(
      name: Routes.ccManageReportCardScreen,
      page: () => CCManageReportCardScreen(),
    ),
    GetPage(
      name: Routes.ccAutoPaymentInfoScreen,
      page: () => CCAutoPayInfoScreen(),
    ),
    GetPage(
      name: Routes.viewCreditLimitAndApr,
      page: () => ViewCreditLimitAndAprScreen(),
      binding: CreditLimitAndAprBinding(),
    ),
  ];
}
