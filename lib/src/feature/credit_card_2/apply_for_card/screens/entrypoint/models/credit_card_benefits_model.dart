class CreditCardBenefitsModel {
  CreditCardBenefitsModel({
    this.title,
    this.description,
    this.annualFee,
    this.benefits,
  });

  final String? title;
  final String? description;
  final String? annualFee;
  final List<String>? benefits;

  CreditCardBenefitsModel getBrassCardMockData() {
    return CreditCardBenefitsModel(
      title: "Cartridge brass World Elite Mastercard® card",
      description:
          "An exclusive, elite card that’s perfect for everyday carry. This is the heaviest cartridge brass contactless card on the market.",
      annualFee: "\$525 annual fee",
      benefits: [
        "2% rewards on every purchase",
        "Get Lyft and DoorDash credits",
        "Mastercard Golf",
        "Priceless Cities Offers",
        "Airport Concierge",
        "Travel and Lifestyle Services",
        "Identity Theft Protection",
        "Cellular Wireless Protection",
        "Concierge Services",
        "Zero Liability Protection",
        "Global Emerency Service",
      ],
    );
  }

  CreditCardBenefitsModel getGloriFiMastercardMockData() {
    return CreditCardBenefitsModel(
      title: "GloriFi \nMastercard®",
      description:
          "Get all the everyday benefits of Mastercard® without an annual fee. ",
      annualFee: "No annual fee",
      benefits: [
        "1.5% rewards on every purchase",
        "Mastercard Golf",
        "Priceless Cities Offers",
        "Airport Concierge",
        "Identity Theft Protection",
        "Zero Liability Protection",
        "Global Emerency Service",
      ],
    );
  }
}
