import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  const NavBar({
    Key? key,
    required this.selectedScreenIndex,
    required this.listItems,
    required this.selectScreen(int arg),
  }) : super(key: key);

  final int selectedScreenIndex;
  final List<Map<String, Object>> listItems;
  final Function selectScreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          GlorifiAssets.tempLogo,
          width: 155,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...listItems.asMap().keys.toList().map(
              (index) {
                final validIndex = selectedScreenIndex == index;
                if (listItems[index]['title'] == 'Menu') {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () => selectScreen(index),
                    child: Text(
                      '${listItems[index]['title']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            validIndex ? FontWeight.w700 : FontWeight.normal,
                        decoration: validIndex
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                children: <Widget>[
                  const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.notifications_outlined,
                      size: 45,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 10,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Text(
                        '2',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () => {},
                    icon: const Icon(
                      Icons.person_outline,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Text(
                  'John',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(200);
}
