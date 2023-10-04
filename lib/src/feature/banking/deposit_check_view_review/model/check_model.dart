import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/deposited_check_controller.dart';

class CheckModel {
  CheckStatus status;
  String date;
  String description;
  String number;
  double amount;
  String back_image;
  String front_image;

  CheckModel(
      {required this.status,
      required this.date,
      required this.description,
      required this.number,
      required this.amount,
      required this.back_image,
      required this.front_image});
}
