import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/utils/glorifi_breakpoints.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key, required this.toggleDrawer}) : super(key: key);

  final Function toggleDrawer;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    return Container(
      color: const Color(0xff505050),
      child: SizedBox(
          width: (width > GlorifiBreakpoints.desktop) ? 500 : width,
          child: ListView(
            children: [
              _buildHeader(),
              _buildContent(width),
            ],
          )),
    );
  }

  Widget _buildContent(double width) {
    const styleTitle = TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
    );

    const styleLink = TextStyle(
      fontSize: 18.4,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
    );

    final styleButtonLink = TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      minimumSize: Size.zero,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.zero,
      ),
    );

    final styleButton = TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      backgroundColor: Colors.white,
      primary: Colors.black,
      minimumSize: Size(width, 70),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    );

    const styleTextButton = TextStyle(
      fontSize: 18.4,
      fontWeight: FontWeight.w700,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Accounts',
            style: styleTitle,
          ),
          const SizedBox(height: 16),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'GloriFi Checking Account ending in 2011',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Chase Checking Account ending in 4232',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButton,
            onPressed: () => {},
            child: const Text(
              'Open a GloriFi Bank Account',
              style: styleTextButton,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: width,
            child: TextButton(
              style: styleButtonLink,
              onPressed: () => {},
              child: const Text(
                '+ Link Another Account',
                textAlign: TextAlign.center,
                style: styleLink,
              ),
            ),
          ),
          const SizedBox(height: 64),
          const Text(
            'My Profile',
            style: styleTitle,
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Account Management',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Manage Settings',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'My Quote',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'My Goals',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'My Rewards',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'My Saved Articles, Videos & Podcasts',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Sign Out',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 64),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'About GloriFi',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'In The News',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Rewards',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Refer Someone',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'The Store',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'GloriFi.com',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 64),
          const Text(
            'Financial Wellness',
            style: styleTitle,
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Tips & Tricks',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Articles, Videos & Podcasts',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 64),
          const Text(
            'Products',
            style: styleTitle,
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Banking',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Insurance',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Mortgage',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 64),
          const Text(
            'Support',
            style: styleTitle,
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'FAQs',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Live Chat',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Chatbot',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Server Status',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 64),
          const Text(
            'Legal',
            style: styleTitle,
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Terms of Use',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Privacy Policy',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 32),
          TextButton(
            style: styleButtonLink,
            onPressed: () => {},
            child: const Text(
              'Legal stuff about this not being legal financial advice',
              style: styleLink,
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/Temp-Logo.svg',
            width: 155,
          ),
          const Spacer(),
          IconButton(
            // ignore: unnecessary_lambdas
            onPressed: () => toggleDrawer(),
            iconSize: 40,
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
