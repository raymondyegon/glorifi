import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;

    const styleTitle = TextStyle(
      color: Color(
        0xff3D3D3D,
      ),
      fontWeight: FontWeight.w700,
      fontSize: 16,
    );

    const styleText = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 18,
      decoration: TextDecoration.underline,
    );

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          left: width / 22,
          right: width / 22,
          top: 22,
        ),
        color: const Color(0xffD8D8D8),
        height: 316,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'ABOUT',
                  style: styleTitle,
                ),
                SizedBox(height: 17),
                Text(
                  'In The News',
                  style: styleText,
                ),
                SizedBox(height: 17),
                Text(
                  'Rewards',
                  style: styleText,
                ),
                SizedBox(height: 17),
                Text(
                  'Refer Someone',
                  style: styleText,
                ),
                SizedBox(height: 17),
                Text(
                  'The Store',
                  style: styleText,
                ),
              ],
            ),
            SizedBox(
              width: width / 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'FINANCIAL WELLNESS',
                    style: styleTitle,
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Download the App',
                    style: styleText,
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Tips & Tricks',
                    style: styleText,
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Articles, Videos & Podcasts',
                    style: styleText,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'PRODUCTS',
                  style: styleTitle,
                ),
                SizedBox(height: 17),
                Text(
                  'Banking',
                  style: styleText,
                ),
                SizedBox(height: 17),
                Text(
                  'Insurance',
                  style: styleText,
                ),
                SizedBox(height: 17),
                Text(
                  'Mortgage',
                  style: styleText,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'SUPPORT',
                  style: styleTitle,
                ),
                SizedBox(height: 17),
                Text(
                  'FAQs',
                  style: styleText,
                ),
                SizedBox(height: 17),
                Text(
                  'Live Chat',
                  style: styleText,
                ),
                SizedBox(height: 17),
                Text(
                  'Chatbot',
                  style: styleText,
                ),
                SizedBox(height: 17),
                Text(
                  'Server Status',
                  style: styleText,
                ),
              ],
            ),
            SizedBox(
              width: width / 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'LEGAL',
                    style: styleTitle,
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Privacy Policy',
                    style: styleText,
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Terms of Use',
                    style: styleText,
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Legal stuff about this not being legal financial advice',
                    style: styleText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
