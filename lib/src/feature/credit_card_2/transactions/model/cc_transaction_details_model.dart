import 'package:glorifi/src/utils/glorifi_assets.dart';

class CCTransactionDetailsModel {
  CCTransactionDetailsModel({
    this.id,
    this.cp_root_transaction_id,
    this.card_last_4_digits,
    this.amount,
    this.transacted_at,
    this.transaction_number,
    this.merchant_id,
    this.account_id,
    this.tenant_id,
    this.card_id,
    this.category_id,
    this.tip_amount,
    this.credit_indicator,
    this.settled_at,
    this.status,
    this.type,
    this.type_category,
    this.pos_type,
    this.labels,
    this.dispute_id,
    this.expiry_at,
    this.transaction_locality,
    this.digital_wallet,
    this.root_id,
    this.sequence,
    this.network_data,
    this.type_category_metadata,
    this.txn_code,
    this.description,
  });

  String? id;
  int? cp_root_transaction_id;
  String? card_last_4_digits;
  double? amount;
  DateTime? transacted_at;
  String? transaction_number;
  String? merchant_id;
  String? account_id;
  String? tenant_id;
  String? card_id;
  String? category_id;
  double? tip_amount;
  String? credit_indicator;
  String? settled_at;
  String? status;
  String? type;
  String? type_category;
  String? pos_type;
  List<String>? labels;
  String? dispute_id;
  String? expiry_at;
  String? transaction_locality;
  String? digital_wallet;
  int? root_id;
  int? sequence;
  NetworkData? network_data;
  String? type_category_metadata;
  String? txn_code;
  String? description;

  CCTransactionDetailsModel copyWith({
    String? id,
    int? cp_root_transaction_id,
    String? card_last_4_digits,
    double? amount,
    DateTime? transacted_at,
    String? transaction_number,
    String? merchant_id,
    String? account_id,
    String? tenant_id,
    String? card_id,
    String? category_id,
    double? tip_amount,
    String? credit_indicator,
    String? settled_at,
    String? status,
    String? type,
    String? type_category,
    String? pos_type,
    List<String>? labels,
    String? dispute_id,
    String? expiry_at,
    String? transaction_locality,
    String? digital_wallet,
    int? root_id,
    int? sequence,
    NetworkData? network_data,
    String? type_category_metadata,
    String? txn_code,
    String? description,
  }) =>
      CCTransactionDetailsModel(
        id: id ?? this.id,
        cp_root_transaction_id:
            cp_root_transaction_id ?? this.cp_root_transaction_id,
        card_last_4_digits: card_last_4_digits ?? this.card_last_4_digits,
        amount: amount ?? this.amount,
        transacted_at: transacted_at ?? this.transacted_at,
        transaction_number: transaction_number ?? this.transaction_number,
        merchant_id: merchant_id ?? this.merchant_id,
        account_id: account_id ?? this.account_id,
        tenant_id: tenant_id ?? this.tenant_id,
        card_id: card_id ?? this.card_id,
        category_id: category_id ?? this.category_id,
        tip_amount: tip_amount ?? this.tip_amount,
        credit_indicator: credit_indicator ?? this.credit_indicator,
        settled_at: settled_at ?? this.settled_at,
        status: status ?? this.status,
        type: type ?? this.type,
        type_category: type_category ?? this.type_category,
        pos_type: pos_type ?? this.pos_type,
        labels: labels ?? this.labels,
        dispute_id: dispute_id ?? this.dispute_id,
        expiry_at: expiry_at ?? this.expiry_at,
        transaction_locality: transaction_locality ?? this.transaction_locality,
        digital_wallet: digital_wallet ?? this.digital_wallet,
        root_id: root_id ?? this.root_id,
        sequence: sequence ?? this.sequence,
        network_data: network_data ?? this.network_data,
        type_category_metadata:
            type_category_metadata ?? this.type_category_metadata,
        txn_code: txn_code ?? this.txn_code,
        description: description ?? this.description,
      );

  factory CCTransactionDetailsModel.fromJson(Map<String, dynamic> json) =>
      CCTransactionDetailsModel(
        id: json["id"],
        cp_root_transaction_id: json["cp_root_transaction_id"],
        card_last_4_digits: json["card_last_4_digits"],
        amount: double.parse(json["amount"]),
        transacted_at: DateTime.parse(json['transacted_at']),
        transaction_number: json["transaction_number"],
        merchant_id: json["merchant_id"],
        account_id: json["account_id"],
        tenant_id: json["tenant_id"],
        card_id: json["card_id"],
        category_id: json["category_id"],
        tip_amount: double.parse(json["tip_amount"]),
        credit_indicator: json["credit_indicator"],
        settled_at: json["settled_at"],
        status: json["status"],
        type: json["type"],
        type_category: json["type_category"],
        pos_type: json["pos_type"],
        labels: List<String>.from(json["labels"].map((x) => x)),
        dispute_id: json["dispute_id"],
        expiry_at: json["expiry_at"],
        transaction_locality: json["transaction_locality"],
        digital_wallet: json["digital_wallet"],
        root_id: json["root_id"],
        sequence: json["sequence"],
        network_data: NetworkData.fromJson(json["network_data"]),
        type_category_metadata: json["type_category_metadata"],
        txn_code: json["txn_code"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cp_root_transaction_id": cp_root_transaction_id,
        "card_last_4_digits": card_last_4_digits,
        "amount": amount,
        "transacted_at": transacted_at,
        "transaction_number": transaction_number,
        "merchant_id": merchant_id,
        "account_id": account_id,
        "tenant_id": tenant_id,
        "card_id": card_id,
        "category_id": category_id,
        "tip_amount": tip_amount,
        "credit_indicator": credit_indicator,
        "settled_at": settled_at,
        "status": status,
        "type": type,
        "type_category": type_category,
        "pos_type": pos_type,
        "labels": labels,
        "dispute_id": dispute_id,
        "expiry_at": expiry_at,
        "transaction_locality": transaction_locality,
        "digital_wallet": digital_wallet,
        "root_id": root_id,
        "sequence": sequence,
        "network_data": network_data?.toJson(),
        "type_category_metadata": type_category_metadata,
        "txn_code": txn_code,
        "description": description
      };
}

class NetworkData {
  NetworkData({
    this.merchant_category_code,
    this.merchant_category_code_description,
    this.merchant_city,
    this.card_acceptor_id_code,
    this.card_acceptor_terminal_id,
    this.card_acceptor_name_location,
    this.mcc_category_code,
    this.merchant_id,
    this.merchant_state,
    this.merchant_zipcode,
    this.merchant_name,
    this.merchant_street_address,
    this.merchant_country,
  });

  String? merchant_category_code;
  String? merchant_category_code_description;
  String? merchant_city;
  String? card_acceptor_id_code;
  String? card_acceptor_terminal_id;
  String? card_acceptor_name_location;
  String? mcc_category_code;
  String? merchant_id;
  String? merchant_state;
  String? merchant_zipcode;
  String? merchant_name;
  String? merchant_street_address;
  String? merchant_country;

  NetworkData copyWith({
    String? merchant_category_code,
    String? merchant_category_code_description,
    String? merchant_city,
    String? card_acceptor_id_code,
    String? card_acceptor_terminal_id,
    String? card_acceptor_name_location,
    String? mcc_category_code,
    String? merchant_id,
    String? merchant_state,
    String? merchant_zipcode,
    String? merchant_name,
    String? merchant_street_address,
    String? merchant_country,
  }) =>
      NetworkData(
        merchant_category_code:
            merchant_category_code ?? this.merchant_category_code,
        merchant_category_code_description:
            merchant_category_code_description ??
                this.merchant_category_code_description,
        merchant_city: merchant_city ?? this.merchant_city,
        card_acceptor_id_code:
            card_acceptor_id_code ?? this.card_acceptor_id_code,
        card_acceptor_terminal_id:
            card_acceptor_terminal_id ?? this.card_acceptor_terminal_id,
        card_acceptor_name_location:
            card_acceptor_name_location ?? this.card_acceptor_name_location,
        mcc_category_code: mcc_category_code ?? this.mcc_category_code,
        merchant_id: merchant_id ?? this.merchant_id,
        merchant_state: merchant_state ?? this.merchant_state,
        merchant_zipcode: merchant_zipcode ?? this.merchant_zipcode,
        merchant_name: merchant_name ?? this.merchant_name,
        merchant_street_address:
            merchant_street_address ?? this.merchant_street_address,
        merchant_country: merchant_country ?? this.merchant_country,
      );

  factory NetworkData.fromJson(Map<String, dynamic> json) {
    String? icon(String? code) {
      if (code == null) {
        return null;
      }
      switch (code.toLowerCase()) {
        case "self_love":
          return GlorifiAssets.icecream;
        case "health":
          return GlorifiAssets.doctor;
        case "commuting":
          return GlorifiAssets.car;
        case "rewards":
          return GlorifiAssets.rewards;
        case "dining":
          return GlorifiAssets.utensils;
        case "payment":
          return GlorifiAssets.dollarCircle;
        case "bank_account":
          return GlorifiAssets.twoCards;
        case "interest":
          return GlorifiAssets.stock;
        case "late_fee":
          return GlorifiAssets.alertCircle;
        case "food":
          return GlorifiAssets.food;
        case "other":
          return GlorifiAssets.other;
        case "entertainment":
          return GlorifiAssets.film;
        case "education":
          return GlorifiAssets.book;
        case "shopping":
          return GlorifiAssets.tag;
        case "vacation":
          return GlorifiAssets.plane;
        case "bill":
          return GlorifiAssets.statement;
        case "groceries":
          return GlorifiAssets.shopping;
        default:
          return null;
      }
    }

    return NetworkData(
      merchant_category_code: icon(json['merchant_category_code']),
      merchant_category_code_description:
          json["merchant_category_code_description"],
      merchant_city: json["merchant_city"],
      card_acceptor_id_code: json["card_acceptor_id_code"],
      card_acceptor_terminal_id: json["card_acceptor_terminal_id"],
      card_acceptor_name_location: json["card_acceptor_name_location"],
      mcc_category_code: json["mcc_category_code"],
      merchant_id: json["merchant_id"],
      merchant_state: json["merchant_state"],
      merchant_zipcode: json["merchant_zipcode"],
      merchant_name: json["merchant_name"],
      merchant_street_address: json["merchant_street_address"],
      merchant_country: json["merchant_country"],
    );
  }

  Map<String, dynamic> toJson() => {
        "merchant_category_code": merchant_category_code,
        "merchant_category_code_description":
            merchant_category_code_description,
        "merchant_city": merchant_city,
        "card_acceptor_id_code": card_acceptor_id_code,
        "card_acceptor_terminal_id": card_acceptor_terminal_id,
        "card_acceptor_name_location": card_acceptor_name_location,
        "mcc_category_code": mcc_category_code,
        "merchant_id": merchant_id,
        "merchant_state": merchant_state,
        "merchant_zipcode": merchant_zipcode,
        "merchant_name": merchant_name,
        "merchant_street_address": merchant_street_address,
        "merchant_country": merchant_country,
      };
}
