import 'package:intl/intl.dart';

extension DoubleX on double{
  formatNumberInEn_US({bool showDecimalPoint = false}){
    NumberFormat numberFormat;
    numberFormat =  showDecimalPoint? NumberFormat("#,##0.00", "en_US"):NumberFormat("#,##0", "en_US");
    return numberFormat.format(this);

  }
}