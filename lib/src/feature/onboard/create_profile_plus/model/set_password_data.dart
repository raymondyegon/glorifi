class SetPasswordData {
  String? _tokenType;
  int? _expiresIn;
  String? _scope;
  String? _accessToken;
  String? _refreshToken;
  String? _idToken;
  String? _error;
  String? _errorDescription;

  String? get tokenType => _tokenType;
  int? get expiresIn => _expiresIn;
  String? get scope => _scope;
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get idToken => _idToken;
  String? get error => _error;
  String? get errorDescription => _errorDescription;

  SetPasswordData({
    String? tokenType,
    int? expiresIn,
    String? scope,
    String? accessToken,
    String? refreshToken,
    String? idToken,
    String? error,
    String? errorDescription,
  }) {
    _tokenType = tokenType;
    _expiresIn = expiresIn;
    _scope = scope;
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _idToken = idToken;
    _error = error;
    _errorDescription = errorDescription;
  }

  SetPasswordData.fromJson(Map<String, dynamic> json) {
    _tokenType = json['token_type'];
    _expiresIn = json['expires_in'];
    _scope = json['scope'];
    _accessToken = json['access_token'];
    _refreshToken = json['refresh_token'];
    _idToken = json['id_token'];
    _error = json['error'];
    _errorDescription = json['error_description'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_type'] = _tokenType;
    map['expires_in'] = _expiresIn;
    map['scope'] = _scope;
    map['access_token'] = _accessToken;
    map['refresh_token'] = _refreshToken;
    map['id_token'] = _idToken;
    map['error'] = _error;
    map['error_description'] = _errorDescription;
    return map;
  }
}
