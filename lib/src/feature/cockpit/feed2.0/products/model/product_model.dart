import 'package:glorifi/src/utils/glorifi_assets.dart';

class ProductModel {
  final String type;
  final ProductItem? productHeader;
  final String? imageUrl;
  final String? secondaryHeaderTitle;
  final String? secondaryHeaderSubTitle;
  // Only Insurance
  final ProductIconList? iconList;
  final ProductQuoteList? productQuoteList;
  final List<ProductItem>? productItems;
  // Only Credit Card
  final ProductionOptionList? productOptions;
  final String? footnote;
  // Only Mortgage
  final String? footnoteIconName;

  ProductModel(
      {required this.type,
      this.productHeader,
      this.imageUrl,
      this.secondaryHeaderTitle = null,
      this.secondaryHeaderSubTitle = null,
      this.iconList = null,
      this.productQuoteList,
      this.productItems,
      this.productOptions = null,
      this.footnote = null,
      this.footnoteIconName = null});

  factory ProductModel.banking() => ProductModel(
          type: 'banking',
          imageUrl: '',
          productHeader: ProductItem(
              content:
                  'With over 90,000 no-fee ATM locations  and real-time transactions, you’re going to love GloriFi banking products and services. ',
              hint: 'GLORIFI BANKING PRODUCTS',
              imageUrl: 'assets/images/products/banking_0.png',
              arrivingString: 'ARRIVING FALL 2022',
              title: 'BANKING MADE EASY'),
          productQuoteList: ProductQuoteList(
            title: 'WHAT EVERYONE\'S SAYING',
            productQuotes: [
              ProductQuote(
                  content:
                      '“I felt like the process of getting an account was straightforward and easy. This was very easy and useful.”',
                  customer: '-Harriet, 43, Texas'),
              ProductQuote(
                  content:
                      '“I would fund and use the account right away because it was so quick and easy to open.”',
                  customer: '-John, 54, New Jersey'),
              ProductQuote(
                  content:
                      '“Overall this is nice, very simple, and super useful. I can’t tell you enough how much I love this ... it just feels so good.”',
                  customer: '-Ethan, 46, Texas'),
            ],
          ),
          productItems: [
            ProductItem(
                content:
                    'We built GloriFi Checking for hardworking patriots who deserve to see their cash grow. And with a competitive APY, you can do just that. ',
                hint: "CHECKING",
                imageUrl: 'assets/images/products/banking_1.png',
                title: 'LIBERTY & CHECKING FOR ALL'),
            ProductItem(
                content:
                    'We believe you should get to keep your hard-earned money—and grow it with a competitive APY  that\'s higher than the national average.',
                hint: "SAVINGS",
                imageUrl: 'assets/images/products/banking_2.png',
                title: 'FINANCIAL FREEDOM STARTS WITH SAVING'),
            ProductItem(
                content:
                    'We set the rate. You pick the term. Competitive returns on fixed-rate CDs are that easy.',
                hint: "CERTIFICATE OF DEPOSITS",
                imageUrl: 'assets/images/products/banking_3.png',
                title: 'YOUR FUTURE IS WORTH SAVING FOR'),
          ],
          // ignore: use_raw_strings
          footnote: """
1 We’ve partnered with Allpoint® and MoneyPass® to provide you with Surcharge-Free ATM access at any of the 90,000+ ATMs within the Allpoint and MoneyPass network. Third-party fees do apply when using out-of-network ATMs.

2 Variable interest rates subject to change at any time. 1.00% APY on balances up to \$15,000.00 and 0.50% APY on balances equal to or greater than \$15,000.01. Rates are current as of 06/27/2022. Additional information can be found on our rate sheet.  

FDIC Insured up to \$250,000.00.

GloriFi is a financial technology company, not a bank. Banking services provided by Stearns Bank, N.A., Member FDIC. 
      """);
  factory ProductModel.creditCard() => ProductModel(
      type: 'creditCard',
      imageUrl: 'assets/images/products/mobile_screenshot.png',
      productHeader: ProductItem(
          content:
              'Spend smart and give back with a card that empowers you to put your money where your values are.',
          hint: 'GLORIFI CREDIT CARDS',
          imageUrl: 'assets/images/products/cards.png',
          title: 'SEND A MESSAGE WITH EVERY PURCHASE',
          arrivingString: 'ARRIVING SUMMER 2022'),
      productQuoteList: ProductQuoteList(
        title: 'WHAT EVERYONE\'S SAYING',
        productQuotes: [
          ProductQuote(
              content:
                  '“My overall impression of this credit card servicing is that it is simple and effective and intuitive. I am a big fan of it.”',
              customer: '-Robert, 43, Texas'),
          ProductQuote(
              content:
                  '“I think it’s fantastic! I think it\'s a very invaluable tool ... and it\'s a very easy to use app.”',
              customer: '-Jennifer, 53, Georgia'),
          ProductQuote(
              content:
                  '“I think this is great, everything is at your fingertips for credit card. I think you have a very visually appealing app.”',
              customer: '-Jamie, 54, Virginia'),
          ProductQuote(
              content:
                  '“Managing the credit card was very intuitive. I love doing everything without having to call a number. I like the visuals, and the “easy to understand” nature [of it].”',
              customer: '-Elizabeth, 46, Pennsylvania')
        ],
      ),
      productItems: [
        ProductItem(
            content:
                'Earn up to 2% cash back or rewards points for travel, gift cards, or charitable donations — plus all the perks and rewards you expect with Mastercard®. ',
            hint: "CREDIT CARD BENEFITS",
            imageUrl: 'assets/images/products/cards_benifit.png',
            title: 'EARN UP TO 2% REWARDS OR CASH BACK'),
        ProductItem(
            content:
                'Stand behind the heroes who stand for law and order when you choose to donate your Mastercard® points to the Tunnel to Towers Foundation, a 501(c)(3) helping families who lost a loved one in the line of duty.',
            hint: "CARD BENEFITS",
            imageUrl: 'assets/images/products/back_the_blue.png',
            title: 'BACK THE BLUE'),
      ],
      productOptions: ProductionOptionList(
        options: [
          // TODO: Create Product Item for each Card Option.
          ProductItem(
              content:
                  'An exclusive, elite card that’s perfect for everyday carry, the GloriFi Cartridge Brass World Elite Mastercard® is the heaviest cartridge brass contactless card on the market. Earn 2% rewards points on every purchase.',
              hint: 'credit card options',
              imageUrl: 'assets/images/products/card_background_1.png',
              title: 'GloriFi CARTRIDGE BRASS WORLD ELITE MASTERCARD®'),
          ProductItem(
              content:
                  'Each day, brave men and women across this great country risk it all to protect our families and communities.\n\nProudly back the blue with the GloriFi Thin Blue Line Mastercard®. Plus, you’ll earn 1.5% rewards points on every purchase with no annual fee.',
              hint: 'credit card options',
              imageUrl: 'assets/images/products/card_background_2.png',
              title: 'GloriFi THIN BLUE LINE MASTERCARD®'),
          ProductItem(
              content:
                  'On July 4th, 1776, a nation founded on liberty and freedom for all was born. Though our taking a stand may look a little different these days, we proudly celebrate our inalienable rights to life, liberty, and the pursuit of happiness. Earn 1.5% rewards points on every purchase with no annual fee.',
              hint: 'credit card options',
              imageUrl: 'assets/images/products/card_background_3.png',
              title: 'GloriFi 1776 MASTERCARD®'),
          ProductItem(
              content:
                  'We the people have always defended the Constitution of the United States. When we proudly stand together as one economy, we can preserve the land of the free for our kids and grandkids. Earn 1.5% rewards points on every purchase with no annual fee.',
              hint: 'credit card options',
              imageUrl: 'assets/images/products/card_background_4.png',
              title: 'GloriFi CONSTITUTION MASTERCARD®'),
        ],
      ),
      footnote:
          // ignore: leading_newlines_in_multiline_strings, use_raw_strings
          """1 The standard variable APR for purchases is 14.74% – 24.74%. The standard variable APR for balance transfers is 14.74% – 24.74%. The standard variable APR for cash advances is 14.74% – 24.74%. Please note that these rates will vary with the Prime Rate. If you are charged interest, the charge will be no less than \$1.00. Annual Fee – \$525.00 for the Cartridge Brass (World Elite) Card, \$0 for the Enhanced Card. Fee for balance transfers – either \$5.00 or 3% of the amount of each transfer, whichever is greater. Fee for cash advances – either \$10.00 or 5% of the amount of each cash advance, whichever is greater. Fee for foreign transactions – 3% of the amount of each transaction in U.S. dollars. Subject to credit approval. Additional limitations, terms, and conditions apply. You will receive additional information when you apply. Cartridge Brass (World Elite) and Enhanced Cards not currently available to residents of AZ, CA, MD, MA, NV, NJ, NY.

GloriFi is a technology company, not a Bank. GloriFi Mastercard® and GloriFi World Elite Mastercard® are issued by Evolve Bank & Trust, a Tennessee Chartered bank, located in Memphis, Tennessee, Member FDIC, pursuant to a license by Mastercard® International Incorporated. Mastercard, Priceless and World Elite Mastercard is a registered trademark and the circles design are trademarks, of Mastercard International Incorporated.  2022 Mastercard. All rights reserved. Rewards are offered and managed by GloriFi, not Mastercard. GloriFi is powered by Deserve. 

Bank: GloriFi is a financial technology company, not a bank. Banking services provided by Stearns Bank, N.A., Member FDIC. The Debit Mastercard® and the World Debit Mastercard are issued by Stearns Bank, N.A. pursuant to license by Mastercard International Incorporated and can be used everywhere Mastercard is accepted. Mastercard, World Debit Card and the circles designs are registered trademarks of Mastercard International Incorporated. 2022 Mastercard. All rights reserved.""");

  factory ProductModel.mortgage() => ProductModel(
        type: 'mortgage',
        imageUrl: '',
        secondaryHeaderTitle: 'WELCOME HOME, AMERICA',
        secondaryHeaderSubTitle:
            'Buying a home? Looking to refinance?  GloriFi Mortgage options allow you to find a loan that works within your budget, save on monthly payments, or use your home\'s equity to get cash when you need it.',
        productHeader: ProductItem(
            content:
                'We know a home is so much more than a roof over your head. That’s why your GloriFi mortgage supports your values and your investment. Call 844-GLORIFI (456-7434) to learn more.',
            hint: 'GLORIFI MORTGAGES',
            imageUrl: 'assets/images/products/mortgage_0.png',
            arrivingString: 'ARRIVING SUMMER 2022',
            title: 'EXPERT GUIDANCE AT EVERY STEP'),
        productItems: [
          ProductItem(
              content:
                  'GloriFi offers several types of loans to suit every need: conventional loans, FHA loans, first-time homeowners, adjustable rate mortgages, and loans for America’s veterans (VA).',
              hint: "WHY CHOOSE GLORIFI",
              imageUrl: 'assets/images/products/mortgage_1.png',
              title: 'MORTGAGES TO SUIT EVERY NEED'),
          ProductItem(
              content:
                  'Get more for your money with competitive rates and a monthly payment that fits your budget. Loan terms range from 10 to 30 years.',
              hint: "WHY CHOOSE GLORIFI",
              imageUrl: 'assets/images/products/mortgage_2.png',
              title: 'COMPETITIVE RATES AND FLEXIBLE TERMS'),
        ],
        footnote:
            // ignore: leading_newlines_in_multiline_strings
            """ANIMO MORTGAGE COMPANY LLC d/b/a GloriFi Mortgage // NMLS #2267438 Click here for the Animo Mortgage NMLS consumer access page.

10000 N. Central Expressway., Suite 1300 Dallas, TX 75231, 844-GLORIFI (844-456-7434)

Mortgage Insurance (MI) may be required. MI is generally required for conventional loans with less than 20% down payment. MI fee may apply.

The annual percentage rate (APR) is the cost of credit over the term of the loan expressed as an annual rate. The APR displayed on this page is based on the interest rate, points, and mortgage insurance. The APR displayed on this page does not include finance charges you may be required to pay. Actual rates may vary.

Tools and calculators are provided to help members estimate mortgage costs. The products and pricing displayed on this page are estimates only. Contact your Mortgage Loan Officer for more specific information at GLORIFI (844-456-7434).

All home mortgage products are subject to credit and collateral review. Rates, terms, and conditions are subject to change without notice. Not all products are available in all states or for all amounts. Other restrictions may apply.

Under the National Flood Insurance Program (NFIP), if the subject property is determined to be in a designated Special Flood Hazard Area (SFHA). Then flood insurance is required for the life of the mortgage. FHA loans require an up-front mortgage insurance premium (UFMIP), which may be financed or paid in full at closing. Monthly premiums may apply. Maximum loan amounts vary by county. Your Mortgage Loan Officer can provide a list of HUD Approved Housing Counseling Agencies in your area.

The U.S. Department of Veteran Affairs (VA) provides eligible veterans the opportunity for a guaranteed loan. A Certificate of Eligibility (COE) issued by the VA is required. The VA funding fee applies except as may be exempted by VA guidelines. The fee is higher with a zero percent down payment, and maximum loan limits vary by county. If a down payment of 5% or more is made, the fee is reduced. The VA funding fee is non-refundable. Restrictions and limitations may apply. Ask your Mortgage Loan Officer for more information about eligibility, documentation, and other requirements.

Equal Housing Opportunity""",
        footnoteIconName: GlorifiAssets.equal_housing_lender,
      );
  factory ProductModel.insurance() => ProductModel(
        type: 'insurance',
        imageUrl: '',
        secondaryHeaderTitle: 'OUR PRODUCTS',
        secondaryHeaderSubTitle:
            'Standing behind the rights of responsible firearm owners, GloriFi offers a variety of policies to help protect you and your family against the unexpected.',
        productOptions: ProductionOptionList(
          options: [
            ProductItem(
                content:
                    'Guard your home with a policy designed for the unique needs of firearm owners.',
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_1.png',
                title: 'Home'),
            ProductItem(
                content: 'Enjoy peace of mind with more than a typical policy.',
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_2.png',
                title: 'Condo'),
            ProductItem(
                content: 'Safeguard your belongings at a price you can afford.',
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_3.png',
                title: 'Renters'),
            ProductItem(
                content:
                    'Fast quotes and amazing coverage make switching easy.',
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_4.png',
                title: 'auto'),
            ProductItem(
                content:
                    'Care for your most loyal companions just like you do for your family.',
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_5.png',
                title: 'Pet'),
            ProductItem(
                content:
                    'Navigate the waterways with boat insurance that leaves others in its wake.',
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_6.png',
                title: 'Boat'),
            ProductItem(
                content:
                    "The road throws you curves, but your coverage shouldn't. ",
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_7.png',
                title: 'Motorcyle'),
            ProductItem(
                content:
                    'Enjoy peace of mind for a small price compared to the cost of flood damage.',
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_8.png',
                title: 'Flood'),
            ProductItem(
                content:
                    "Court costs shouldn't endanger your family's future. Umbrella insurance provides protection. ",
                hint: '',
                imageUrl: 'assets/images/products/insurance_slide_icon_9.png',
                title: 'umbrella'),
          ],
        ),
        productHeader: ProductItem(
            content:
                'GloriFi offers all the same protections you’d expect from leading insurance brands, backed by the faith and dedication of a company that supports your values.',
            hint: 'GLORIFI INSURANCE',
            imageUrl: 'assets/images/products/insurance_0.png',
            arrivingString: 'ARRIVING FALL 2022',
            title: 'WE\'VE GOT YOUR BACK'),
        productItems: [
          ProductItem(
              content:
                  r'Get $250,000 built-in personal firearm liability protection with all GloriFi residential policies — at  no additional cost.',
              hint: "WHY CHOOSE GLORIFI",
              imageUrl: 'assets/images/products/insurance_1.png',
              title: 'FIREARM PERSONAL LIABILITY COVERAGE'),
          ProductItem(
              content:
                  'We believe responsible gun owners are some of the finest folks around. That’s why we’re giving you a 10% discount on any residential policy where permissible.',
              hint: "WHY CHOOSE GLORIFI",
              imageUrl: 'assets/images/products/insurance_2.png',
              title: 'RESPONSIBLE GUN OWNERS SAVE 10%'),
          ProductItem(
              content:
                  'You\'re busy. Why not save the hassle of typical insurance quotes? Designed for speed and accuracy, we’ll give you a quote in as little as 15 seconds.',
              hint: "WHY CHOOSE GLORIFI",
              imageUrl: 'assets/images/products/insurance_3.png',
              title: 'GET A QUOTE IN SECONDS'),
        ],
        footnote:
            'The product descriptions provided above are only summaries. The full coverage terms and details, including limitations and exclusions, are contained in the insurance Policy. Coverage and rates may vary by states. If there is any conflict between the contents of this website and the Policy, the Policy will govern in all cases. Claims services are provided by the designated provider listed in the policy or on your Confirmation of Coverage.\n\n“15-second” quotes are an estimate of the time from quote-to-issue once application is received. ',
      );
}

class ProductItem {
  final String imageUrl;

  final String hint;

  final String title;
  final String content;
  final String? arrivingString;

  ProductItem({
    required this.imageUrl,
    required this.hint,
    required this.title,
    required this.content,
    this.arrivingString = null,
  });
}

class ProductQuoteList {
  final String title;
  final List<ProductQuote> productQuotes;

  ProductQuoteList({
    required this.title,
    required this.productQuotes,
  });
}

class ProductQuote {
  final String content;
  final String customer;

  ProductQuote({
    required this.content,
    required this.customer,
  });
}

// Currently just used for Credit Card
class ProductionOptionList {
  final List<ProductItem> options;

  ProductionOptionList({
    required this.options,
  });
}

// Currently just used for Insurance
class ProductIconList {
  final List<ProductIcon> icons;

  ProductIconList({
    required this.icons,
  });
}

class ProductIcon {
  final String iconName;
  final String title;
  final String subTitle;

  ProductIcon({
    required this.iconName,
    required this.title,
    required this.subTitle,
  });
}
