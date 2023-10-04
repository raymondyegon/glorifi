enum CCDashboardCardType {
  ActivateCard,
  ActiveDispute,
  AccountSuspended,
  PaymentDue
}

class CCCardModel {
  String title;
  String subText;
  // String route;

  CCCardModel({
    required this.title,
    required this.subText,
    // required this.route,
  });
}
