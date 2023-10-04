import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/controllers/menu_navigation_controller.dart';
import 'package:glorifi/src/utils/glorifi_breakpoints.dart';
import 'package:glorifi/src/widgets/shared/menu.dart';
import 'package:glorifi/src/widgets/web/shared/footer.dart';
import 'package:glorifi/src/widgets/web/shared/navbar.dart';
import 'package:glorifi/src/widgets/shared/app_bar_notification.dart';
import 'package:glorifi/src/widgets/shared/mobile_navbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AdaptiveNavigationContainer extends StatefulWidget {
  const AdaptiveNavigationContainer(
      {Key? key, this.title, required this.children})
      : super(key: key);

  final String? title;

  final List<Map<String, Object>> children;

  @override
  State<AdaptiveNavigationContainer> createState() =>
      _AdaptiveNavigationContainerState();
}

class _AdaptiveNavigationContainerState
    extends State<AdaptiveNavigationContainer> {
  int _selectedScreenIndex = 0;
  void _selectScreen(int index) {
    if ((index + 1) != widget.children.length) {
      setState(() {
        _selectedScreenIndex = index;
      });
    }
  }

  bool _isDesktop(int width) {
    return kIsWeb && width > GlorifiBreakpoints.desktop;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width.toInt();
    final height = screenSize.height.toInt();

    final isDesktop = _isDesktop(width.toInt());
    return Scaffold(
      appBar: isDesktop
          ? NavBar(
              selectedScreenIndex: _selectedScreenIndex,
              listItems: widget.children,
              selectScreen: _selectScreen,
            ) as PreferredSizeWidget
          : AppBarNotification(title: widget.title, notificationIcon: true),
      body: isDesktop
          ? _desktopBody(height)
          : MobileBody(
              child: widget.children[_selectedScreenIndex]['screen'] as Widget,
            ),
      bottomNavigationBar: isDesktop
          ? null
          : MobileNavbar(
              selectedScreenIndex: _selectedScreenIndex,
              listItems: widget.children,
              selectScreen: _selectScreen,
            ),
    );
  }

  Widget _desktopBody(int height) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: <Widget>[
                  Container(
                    height: height - 366,
                    alignment: Alignment.center,
                    child: widget.children[_selectedScreenIndex]['screen']
                        as Widget,
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MobileBody extends StatefulWidget {
  final Widget child;
  const MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  _MobileBodyState createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _openNavController = Get.put(MenuNavigationController());
    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _openNavController.drawerSlideController,
          builder: (context, child) {
            return FractionalTranslation(
              translation: Offset(
                  _openNavController.drawerSlideController.value - 1.0, 0.0),
              child: _openNavController.isDrawerClosed()
                  ? const SizedBox()
                  : Menu(toggleDrawer: _openNavController.toggleDrawer),
            );
          },
        ),
      ],
    );
  }
}
