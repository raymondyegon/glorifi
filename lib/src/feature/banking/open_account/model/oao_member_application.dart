import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_debit_card.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_deposit_account.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/utils/string_utils.dart';
import 'package:us_states/us_states.dart';

enum OAOAuthorizations { contact, allDisclosures }

final num minCDDeposit = 500;

class OAOMemberApplication {
  OAODepositAccount? selectedProduct;
  Rx selectedCard = OAODebitCard(
          cardProductToken: '',
          cardArt: '',
          cardDescription: '',
          cardSubtitle: '',
          cardTitle: '')
      .obs;

  // Personal
  String? firstName;
  String? middleName;
  String? lastName;
  DateTime? dob;

  // Contact
  String? phoneNumber;
  String? email;

  double fundedAmount = 0;

  // Address
  PartialAddress address;
  PartialAddress mailingAddress;

  bool get hasMailingAddress =>
      mailingAddress.line1 != "" && mailingAddress.line1 != null;

  String? USCitizenship = "";
  RxList<String> nonUSCitizenship = RxList();
  RxString workStatus = "".obs;

  String? ssn;

  RxBool isError = false.obs;

  RxMap<OAOAuthorizations, bool> authorizations = {
    OAOAuthorizations.contact: false,
    OAOAuthorizations.allDisclosures: false
  }.obs;

  // Post application submission
  String? accountNumber = "";
  String? routingNumber = "";
  String? accountId = "";

  int income = 0;

  Rx<bool> overdraftAuthorized = false.obs;
  Rx<bool> expeditedShipping = false.obs;

  String get fullName => [firstName, middleName, lastName]
      .where((value) => value != null && value != "")
      .join(" ");

  bool get giveExpeditedShippingOption => fundedAmount >= 15;

  OAOMemberApplication({
    this.selectedProduct,
    this.firstName,
    this.middleName,
    this.lastName,
    this.dob,
    this.phoneNumber,
    this.email,
    required this.address,
    required this.mailingAddress,
    this.ssn,
    this.USCitizenship,
  });

  // Used for Quick Apply
  factory OAOMemberApplication.fromJson(
    Map<String, dynamic> json,
    OAODepositAccount? product,
  ) {
    final address = PartialAddress(
      line1: json['addressStreet'],
      line2: json['addressStreet2'],
      city: json['addressCity'],
      zip: json['addressZip'],
    );
    address.state.value = USStates.getName(json['addressState']) ?? '';

    final mailingAddress = PartialAddress(
      line1: json['mailingAddressStreet'],
      line2: json['mailingAddressStreet2'],
      city: json['mailingAddressCity'],
      zip: json['mailingAddressZip'],
    );
    mailingAddress.state.value = json['mailingAddressState'];

    return OAOMemberApplication(
      selectedProduct: product,
      address: address,
      mailingAddress: mailingAddress,
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: DateTime.parse(json['birthDate']),
      email: json['email'],
      phoneNumber: (json['phoneNumber'] as String).toPrettyPhoneNumberDisplay(),
      USCitizenship: 'US Citizen',
    );
  }

  Map<String, dynamic> toCreateBankingUserPayload() => {
        'firstName': firstName,
        'middleName': middleName,
        'lastName': lastName,
        'tinType': ssn!.startsWith('9') ? 3 : 0,
        'tin': ssn?.replaceAll(RegExp('[^0-9]'), ''),
        'dateOfBirth': dob!.toServiceFormat(),
        'email': email,
        'phoneNumber': phoneNumber!.replaceAll(RegExp('[^0-9]'), ''),
        'addressStreet': address.line1,
        'addressStreet2': address.line2,
        'addressCity': address.city,
        'addressState': USStates.getAbbreviation(address.state.value),
        'addressZip': address.zip,
        'mailingAddressStreet': mailingAddress.line1,
        'mailingAddressStreet2': mailingAddress.line2,
        'mailingAddressCity': mailingAddress.city,
        'mailingAddressState': mailingAddress.state.value,
        'mailingAddressZip': mailingAddress.zip,
        'income': income,
        'workStatus': workStatus.value,
        'citizenship': [
          [USCitizenship],
          nonUSCitizenship.value
        ].expand((i) => i).whereType<String>().toList()
      };

  @override
  String toString() {
    return 'OAOMemberApplication{selectedProduct: $selectedProduct, firstName: $firstName, '
        'middleName: $middleName, lastName: $lastName, dob: $dob, phoneNumber: $phoneNumber, '
        'email: $email, address: $address, mailingAddress: $mailingAddress, USCitizenship: $USCitizenship, '
        'ssn: $ssn, '
        'overdraftAuthorized: $overdraftAuthorized}';
  }
}

class PartialAddress {
  String? line1;
  String? line2;
  String? city;
  Rx<String> state = "".obs;
  String? zip;

  RxList errors = [].obs;

  String get formatted {
    if (line2 != null && line2!.isNotEmpty) {
      String string = line1!;
      if (line2 != null && line2!.isNotEmpty) {
        string += "\n$line2";
      }
      string += "\n$city, $state $zip";
      return string;
    } else {
      return "$line1, $city, $state  $zip";
    }
  }

  PartialAddress({
    this.line1,
    this.line2,
    this.city,
    this.zip,
  });

  void clear() {
    line1 = null;
    line2 = null;
    city = null;
    state("");
    zip = null;
    errors.clear();
  }

  @override
  String toString() {
    return 'PartialAddress{line1: $line1, line2: $line2, city: $city, state: $state.value, zip: $zip}';
  }
}
