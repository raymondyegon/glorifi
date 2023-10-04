import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class ColorPalette extends StatelessWidget {
  const ColorPalette({
    Key? key,
  }) : super(key: key);

  static List<Map<String, dynamic>> typeTreatments = [
    {
      'size': 10,
      'color': GlorifiColors.bloodOrange,
      'name': 'Blood Orange',
      'name_color': '${GlorifiColors.bloodOrange}'
    },
    {
      'size': 12,
      'color': GlorifiColors.cornflowerBlue,
      'name': 'Cornflower Blue',
      'name_color': '${GlorifiColors.cornflowerBlue}'
    },
    {
      'size': 14,
      'color': GlorifiColors.denimBlue,
      'name': 'Denim Blue',
      'name_color': '${GlorifiColors.denimBlue}'
    },
    {
      'size': 16,
      'color': GlorifiColors.lightGreen,
      'name': 'Light Green',
      'name_color': '${GlorifiColors.lightGreen}'
    },
    {
      'size': 18,
      'color': GlorifiColors.red,
      'name': 'Red',
      'name_color': '${GlorifiColors.red}'
    },
    {
      'size': 24,
      'color': GlorifiColors.vividSkyBlue,
      'name': 'VividSky Blue',
      'name_color': '${GlorifiColors.vividSkyBlue}'
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
                'Color Palette',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'GloriFi interface color prioritizes accessibility and is used systematically.',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 80),
              const Text(
                'Brand Colors',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Divider(
                color: Color(0xff323338),
                height: 30,
                thickness: 3,
              ),
              const Text(
                'Used as main colors for user interface and components ',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              ...typeTreatments.map((data) {
                final name = data['name'];
                final nameColor = data['name_color'];
                final color = data['color'];
                final textColor =
                    name == 'Light Green' ? Colors.black : Colors.white;

                return Column(
                  children: [
                    Container(
                      color: color,
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            nameColor,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
