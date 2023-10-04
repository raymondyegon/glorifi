class TotalAccountsOpenedModel {
  final int? count;
  final String? accountStatus;
  final String? description;
  final String? duration;
  final String? location;
  final int? openAccountCount;
  final int? closedAccountCount;
  final bool? fullState;
  final List<String>? openAccounts;
  final List<String>? closedAccounts;

  TotalAccountsOpenedModel({
    this.count,
    this.accountStatus: '',
    this.description: '',
    this.duration: '',
    this.location: '',
    this.openAccountCount: 0,
    this.closedAccountCount: 0,
    this.fullState: true,
    this.openAccounts,
    this.closedAccounts,
  });
}

class AppString {
  static String generalContent =
      'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.';
}
