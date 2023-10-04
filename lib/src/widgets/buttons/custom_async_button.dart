import 'package:flutter/material.dart';

class CustomAsyncButton extends StatefulWidget {
  final BorderRadius? inkwellBorderRadius;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final Function? onTap;
  final Widget child;
  final Widget? loadingWidget;

  const CustomAsyncButton({
    Key? key,
    required this.child,
    this.loadingWidget,
    this.onTap,
    this.height,
    this.width,
    this.inkwellBorderRadius,
    this.decoration,
  }) : super(key: key);

  @override
  State<CustomAsyncButton> createState() => _CustomAsyncButtonState();
}

class _CustomAsyncButtonState extends State<CustomAsyncButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Widget _loadingWidget = widget.loadingWidget ??
        Center(
          child: Container(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(),
          ),
        );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: loading
            ? () {}
            : () async {
                try {
                  loading = true;
                  setState(() {});
                  await widget.onTap!();
                } finally {
                  loading = false;
                  setState(() {});
                }
              },
        borderRadius: widget.inkwellBorderRadius,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: widget.decoration,
          child: loading ? _loadingWidget : widget.child,
        ),
      ),
    );
  }
}
