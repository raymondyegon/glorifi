import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/feature/onboard/video_player.dart';

class OnboardingAbout extends StatefulWidget {
  const OnboardingAbout({Key? key}) : super(key: key);

  @override
  _OnboardingAboutState createState() => _OnboardingAboutState();
}

class _OnboardingAboutState extends State<OnboardingAbout> {
  var _pageIndex = 0;

  final contentValues = [
    {
      'title': '',
      'subtitle': '',
    },
    {
      'title': 'Take control of your data.',
      'subtitle': 'We are advocates for transparency.',
    },
    {
      'title': 'Gain financial education.',
      'subtitle':
          'Get tips and learn more about your financial health from trusted financial educators.',
    },
    {
      'title': 'Compare against others like you.',
      'subtitle':
          'Sometimes it is helpful to see how you financially stack up against your peers.',
    },
    {
      'title': 'Get rewarded',
      'subtitle':
          'You work hard for your money and think you should be rewarded.',
    }
  ];

  void _showNext() {
    setState(() {
      if (_pageIndex == contentValues.length - 1) {
        _pageIndex = 0;
        return;
      }
      _pageIndex++;
    });
  }

  void _watchVideo() {
    Navigator.of(context).pushNamed(VideoPlayer.routeName);
  }

  Widget _containerForIndex() {
    switch (_pageIndex) {
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Placeholder to let MainAxisAlignment handle placement
            const SizedBox(),
            // Logo
            SvgPicture.asset('assets/images/Temp-Logo.svg'),
            //WatchVideo
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: GestureDetector(
                onTap: _watchVideo,
                child: Chip(
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  label: const Text('Watch Video'),
                ),
              ),
            )
          ],
        );
      case 1:
      case 2:
      case 3:
      case 4:
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(contentValues[_pageIndex]['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'univers',
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                contentValues[_pageIndex]['subtitle'] as String,
                style: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _showNext,
        child: _containerForIndex(),
      ),
    );
  }
}
