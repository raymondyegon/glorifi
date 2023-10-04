class OAOWorkflowOptions {
  static Future successfulMockAPI() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }

  static Future failedMockAPI() async {
    await Future.delayed(const Duration(milliseconds: 500));
    throw 'this mocked api call failed';
  }

  final bool ignoreFailedAPICall;
  final Future<dynamic> Function()? mockAPI;

  OAOWorkflowOptions({
    required this.ignoreFailedAPICall,
    this.mockAPI,
  });
}
