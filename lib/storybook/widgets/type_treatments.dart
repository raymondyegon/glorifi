import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_breakpoints.dart';

class TypeTreatments extends StatelessWidget {
  const TypeTreatments({
    Key? key,
  }) : super(key: key);

  static List<Map<String, dynamic>> typeTreatments = [
    {
      'size': 10,
    },
    {
      'size': 12,
    },
    {
      'size': 14,
    },
    {
      'size': 16,
    },
    {
      'size': 18,
    },
    {
      'size': 24,
    },
    {
      'size': 28,
    },
    {
      'size': 32,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: width,
      height: height,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Typographic Scale',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'GloriFi interface typography prioritizes accessibility. Text should be readable and help the user understand what’s important by well contrasted size, color, and hierarchy.',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 80),
              const Text(
                'Type Treatments',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Divider(
                color: Color(0xff323338),
                height: 30,
                thickness: 3,
              ),
              const SizedBox(height: 30),
              ...typeTreatments.map((data) {
                final size = data['size'];
                return width > GlorifiBreakpoints.desktop
                    ? DesktopWidget(size: size)
                    : MobileWidget(size: size);
              })
            ],
          ),
        ],
      ),
    );
  }
}

class MobileWidget extends StatelessWidget {
  const MobileWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size: ${size}px',
          style: TextStyle(fontSize: size),
        ),
        const SizedBox(height: 10),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ut dignissim a, sem. Donec posuere dui pulvinar quam varius enim.',
          style: TextStyle(fontSize: size),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class DesktopWidget extends StatelessWidget {
  const DesktopWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Size: ${size}px',
          style: TextStyle(fontSize: size),
        ),
        const SizedBox(width: 50),
        Expanded(
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac ut dignissim a, sem. Donec posuere dui pulvinar quam varius enim.',
            style: TextStyle(fontSize: size),
          ),
        ),
        SizedBox(height: (60 + size).toDouble()),
      ],
    );
  }
}
