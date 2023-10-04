// TODO: Use Gitlab or Launch Darkly or something
class FeatureFlagManager {
  static bool get mobileCheckDepositEnabled {
    return true;
  }

  static bool get bundlesEnabled {
    return false;
  }

  static bool get mortgageEnabled {
    return false;
  }

  static bool get insuranceEnabled {
    return false;
  }

  static bool get bankingEnabled {
    return true;
  }

  static bool get snapshotTotalNetWorthEnabled {
    return true;
  }

  static bool get snapshotCashOnHandEnabled {
    return true;
  }

  static bool get snapshotCreditScoreEnabled {
    return false;
  }

  static bool get snapshotDebtEnabled {
    return true;
  }

  static bool get snapshotHomeValueEnabled {
    return true;
  }

  static bool get rewardsRedeemEnabled {
    return true;
  }

  //Support Categories
  static bool get BankingSupportEnabled {
    return false;
  }
  static bool get InsuranceSupportEnabled {
    return false;
  }
  static bool get MortgageSupportEnabled {
    return false;
  }
  static bool get GeneralQuestionsSupportEnabled {
    return true;
  }
}
