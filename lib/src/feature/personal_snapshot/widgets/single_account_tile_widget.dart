import 'package:flutter/material.dart';
import 'package:glorifi/src/widgets/tiles/expandable_two_line_tile/expandable_two_line_list_tile.dart';
import 'package:glorifi/src/widgets/tiles/expandable_two_line_tile/widgets/expandable_tile_section.dart';
import 'package:glorifi/src/widgets/tiles/expandable_two_line_tile/widgets/expandable_tile_text_button.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

class SingleAccountTileWidget extends StatelessWidget {
  const SingleAccountTileWidget({Key? key, required this.data})
      : super(key: key);

  final SingleAccountTileData data;

  @override
  Widget build(BuildContext context) {
    bool _hasButton = data.buttonText != null;

    return ExpandableTwoLineListTile(
      title: data.title,
      child: Column(
        children: [
          Divider(height: 0),
          ...data.items.map((e) {
            int _index = data.items.indexOf(e);
            bool _isLast = _index == data.items.length - 1;
            return Column(
              children: [
                ExpandableTileSection(
                  title: e.name,
                  subtitle: e.label,
                  trailingText: (e.currentBalance as double)
                      .formatSimpleCurrencyWithDynamicDecimal(),
                ),
                if (_hasButton || !_isLast) Divider(height: 0),
              ],
            );
          }).toList(),
          if (_hasButton)
            ExpandableTileTextButton(
              text: data.buttonText!,
              onPressed: data.buttonAction,
            ),
        ],
      ),
    );
  }
}

class SingleAccountTileData {
  SingleAccountTileData({
    required this.title,
    required this.items,
    this.buttonText,
    this.buttonAction,
  });

  final String title;
  final List<dynamic> items;
  final String? buttonText;
  final VoidCallback? buttonAction;
}
