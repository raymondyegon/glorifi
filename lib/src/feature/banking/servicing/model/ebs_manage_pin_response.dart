class EBSManagePinResponse {
  String oneTimeToken;
  String userToken;
  String applicationId;
  String? successUrl;

  EBSManagePinResponse({
    required this.oneTimeToken,
    required this.userToken,
    required this.applicationId,
    this.successUrl,
  });

  factory EBSManagePinResponse.fromJson(Map<String, dynamic> json) => EBSManagePinResponse(
        oneTimeToken: json['one_time_token'],
        userToken: json['user_token'],
        applicationId: json['application_id'],
        successUrl: json['success_url'],
      );
}
