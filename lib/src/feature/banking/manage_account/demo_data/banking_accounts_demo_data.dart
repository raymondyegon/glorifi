import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/feature/banking/manage_account/model/account_model.dart';

var bankingAccountsDemoData = [
  AccountModel(
    accountName: 'Costco Anywhere Visa',
    accountNumber: '*1234',
    balance: 2890.00,
    bankName: 'Citibank Online',
    accountType: AccountType.CHECKING,
  ),
  AccountModel(
    accountName: 'Chase Sapphire Preferred',
    accountNumber: '*5467',
    balance: 2890.00,
    bankName: 'Chase',
    accountType: AccountType.SAVINGS,
  )
];

var savingsAccountsDemoData = [
  AccountModel(
    accountName: 'Chase Sapphire Preferred',
    accountNumber: '*5467',
    balance: 2890.00,
    bankName: 'Chase',
    accountType: AccountType.SAVINGS,
  )
];

var retirementAccountsDemoData = [
  AccountModel(
    accountName: 'Empowered Retirement',
    accountNumber: '*5467',
    balance: 2890.00,
    bankName: 'Empowered',
    accountType: AccountType.NONE,
  )
];

var creditCardAccountsDemoData = [
  AccountModel(
    accountName: 'Costco Anywhere Visa',
    accountNumber: '*1234',
    balance: 2890.00,
    bankName: 'Citibank Online',
    accountType: AccountType.CHECKING,
  ),
];

var cdAccountsDemoData = [
  AccountModel(
    accountName: 'Chase CD',
    accountNumber: '*5467',
    balance: 2890.00,
    bankName: 'Chase',
    accountType: AccountType.CD,
  )
];
