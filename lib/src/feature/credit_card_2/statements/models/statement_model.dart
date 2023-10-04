import 'package:intl/intl.dart';

class StatementModel{

  StatementModel(this.month,this.endDate);
  String month;
  DateTime endDate;

  get formattedEndDate=> DateFormat('MMMM dd').format(endDate);


}