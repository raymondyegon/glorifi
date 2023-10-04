///google places autocomplete
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/core/api/api_endpoints.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/model/address_autocomplete/address_autocomplete_suggestions_model.dart';
import 'package:glorifi/src/model/address_autocomplete/place_detail_model.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

enum AddressAutocompleteType {
  regular,
  glorifiSilverField,
}

class AddressAutocompleteWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(PlaceDetailModel place) onAutocompleteTap;
  final String? label;
  final bool  autoFocus;
  final String? hintText;
  final String error;
  final Function(String value)? onChanged;
  final AddressAutocompleteType type;

  const AddressAutocompleteWidget({
    Key? key,
    required this.controller,
    required this.onAutocompleteTap,
    this.label,
    this.autoFocus=false,
    this.hintText,
    required this.error,
    this.onChanged,
    this.type = AddressAutocompleteType.regular,
  }) : super(key: key);

  @override
  State<AddressAutocompleteWidget> createState() => _AddressAutocompleteWidgetState();
}

class _AddressAutocompleteWidgetState extends State<AddressAutocompleteWidget> {
  final GlobalKey _key = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _suggestionsOverlay;
  String _term = '';
  Offset _position = Offset.zero;
  double _widgetWidth = 0;
  Timer? _t;
  bool _isSuggestionsOverlayOpened = false;
  double _suggestionsBoxTopSpace = 8;
  BoxDecoration _suggestionsBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: GlorifiColors.bermudaGray),
    color: GlorifiColors.white,
  );

  String get _autocompleteQuery =>
      'https://maps.googleapis.com/maps/api/place/autocomplete/json?&input=$_term&inputtype=textquery&key=${ApiEndPoints.googleMapApiKey}&components=country:US';

  String _detailQuery(String id) =>
      'https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=${ApiEndPoints.googleMapApiKey}';

  @override
  void initState() {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _closeSuggestions();
      }
    });
    super.initState();
  }

  void _onChanged(String val) async {
    widget.onChanged?.call(val);
    if (_t != null) {
      _t!.cancel();
    }
    _term = val;
    if (val == '') {
      _closeSuggestions();
    }
    if (val.length > 4) {
      _t = Timer(Duration(milliseconds: 200), () async {
        final AddressAutocompleteSuggestionsModel? _suggestions = await _getSuggestions();
        if (_suggestions != null && _suggestions.items.length > 0) {
          _showSuggestions(context, _suggestions);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case AddressAutocompleteType.regular:
        return GlorifiTextField(
          key: _key,
          textEditingController: widget.controller,
          label: widget.label,autofocus: widget.autoFocus,
          validator: GlorifiTextField.requiredFieldValidator(widget.error),
          focusNode: _focusNode,
          onChanged: _onChanged,
        );
      case AddressAutocompleteType.glorifiSilverField:
        _suggestionsBoxTopSpace = 0;
        _suggestionsBoxDecoration = BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: GlorifiColors.silver),
          color: GlorifiColors.white,
        );
        return GlorifiTextField(
          key: _key,
          label: widget.hintText,
          textEditingController: widget.controller,
          validator: GlorifiTextField.requiredFieldValidator(widget.error),
          onChanged: _onChanged,
        );
    }
  }

  void _showSuggestions(BuildContext context, AddressAutocompleteSuggestionsModel suggestions) {
    _setPosition();
    _closeSuggestions();
    _suggestionsOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _closeSuggestions,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: _position.dy,
            left: _position.dx,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AnimatedSize(
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: _widgetWidth,
                  constraints: BoxConstraints(maxHeight: 200),
                  decoration: _suggestionsBoxDecoration,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      ...suggestions.items
                          .map(
                            (e) => Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _getDetail(e.id),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: suggestions.items.length - 1 == suggestions.items.indexOf(e)
                                            ? Colors.transparent
                                            : GlorifiColors.grey,
                                      ),
                                    ),
                                  ),
                                  height: 60,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          e.description,
                                          style: xSmallRegular12Primary(),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    if (_suggestionsOverlay != null) Overlay.of(context)!.insert(_suggestionsOverlay!);
    _isSuggestionsOverlayOpened = true;
  }

  Future<AddressAutocompleteSuggestionsModel?> _getSuggestions() async {
    try {
      var response = await Dio().get(_autocompleteQuery);
      return AddressAutocompleteSuggestionsModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  void _getDetail(String id) async {
    try {
      var response = await Dio().get(_detailQuery(id));
      _closeSuggestions();
      if (response.data['status'] == 'OK') {
        final PlaceDetailModel _place = PlaceDetailModel.fromJson(response.data);
        FocusScope.of(context).unfocus();
        widget.onAutocompleteTap(_place);
      }
    } catch (e) {
      Log.error(e);
    }
  }

  ///get position and dimensions of textfield
  ///to position suggestions widget in overlay
  _setPosition() {
    if (_key.currentContext != null) {
      RenderBox renderBox = _key.currentContext!.findRenderObject()! as RenderBox;
      final tempPosition = renderBox.localToGlobal(Offset.zero);
      final inputHeight = renderBox.size.height;
      _widgetWidth = renderBox.size.width;
      _position = Offset(tempPosition.dx, tempPosition.dy + inputHeight + _suggestionsBoxTopSpace);
    }
  }

  _closeSuggestions() {
    if (_isSuggestionsOverlayOpened) {
      _suggestionsOverlay!.remove();
      _isSuggestionsOverlayOpened = false;
    }
  }

  @override
  void dispose() {
    _closeSuggestions();
    _focusNode.dispose();
    super.dispose();
  }
}
