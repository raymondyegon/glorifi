enum UpdateTerms { mandatory, optional, updated }

class LoginArgs {
  final bool fromAppLock;
  final String logoutMessage;
  final bool fromSplashScreen;
  final UpdateTerms updateTerms;

  LoginArgs({
    this.fromAppLock = false,
    this.logoutMessage = "",
    this.fromSplashScreen = false,
    this.updateTerms = UpdateTerms.updated,
  });

  factory LoginArgs.fromJson(Map<String, dynamic> json) {
    return LoginArgs(
      fromAppLock: json['fromAppLock'],
      logoutMessage: json['logoutMessage'],
      fromSplashScreen: json['fromSplashScreen'],
      updateTerms: json['updateTerms'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fromAppLock'] = fromAppLock;
    data['logoutMessage'] = logoutMessage;
    data['fromSplashScreen'] = fromSplashScreen;
    data['updateTerms'] = updateTerms;
    return data;
  }
}
