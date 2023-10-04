import 'package:intl/intl.dart';

extension DateX on DateTime {
  String todMMM() {
    return DateFormat("d MMM").format(this);
  }

  String toMMMd() {
    return DateFormat("MMM d").format(this);
  }

  String toMMMdyyyy() {
    return DateFormat("MMM d, yyyy").format(this);
  }

  String toServiceFormat() {
    return DateFormat("yyyy-MM-dd").format(this);
  }

  String toDisplayFormat() {
    return DateFormat('MM/dd/yyyy').format(this);
  }
  
}
