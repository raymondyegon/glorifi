import 'package:glorifi/src/feature/insurance/model/display_identifier.dart';
import 'package:intl/intl.dart';

class Quotes {
  int? partyId;
  String? quoteName;
  String? quoteNumber;
  String? vendor;
  String? startedDate;
  DisplayIdentifier? displayIndentifier;

  Quotes(
      {this.partyId,
      this.quoteName,
      this.quoteNumber,
      this.vendor,
      this.startedDate,
      this.displayIndentifier});

  Quotes.fromJson(Map<String, dynamic> json) {
    partyId = json['party_id'];
    quoteName = json['quote_name'];
    quoteNumber = json['quote_number'];
    vendor = json['vendor'];
    startedDate = json['started_date'];
    displayIndentifier = json['display_indentifier'] != null
        ? DisplayIdentifier.fromJson(json['display_indentifier'])
        : null;
  }

  String? getParsedDate() {
    var inputFormat = DateFormat('yyyy-MM-dd');
    var inputDate = inputFormat.parse(startedDate!);
    var outputFormat = DateFormat('dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return "Started: $outputDate";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['party_id'] = partyId;
    data['quote_name'] = quoteName;
    data['quote_number'] = quoteNumber;
    data['vendor'] = vendor;
    data['started_date'] = startedDate;
    if (displayIndentifier != null) {
      data['display_indentifier'] = displayIndentifier!.toJson();
    }
    return data;
  }
}
