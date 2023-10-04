import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glorifi/src/feature/errors/model/error_ui_model.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

class BaseErrorMobileWidget extends StatelessWidget {
  final ErrorUiModel errorUiModel;

  const BaseErrorMobileWidget({
    Key? key,
    required this.errorUiModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          errorUiModel.title,
          style:
              headlineRegular31Secondary(color: GlorifiColors.cornflowerBlue),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 24.h,
        ),
        if (errorUiModel.subtitle.isNotEmpty)
          Text(
            errorUiModel.subtitle,
            style: bodyBold18Primary(color: GlorifiColors.midnightBlue),
            textAlign: TextAlign.center,
          ),
        if (errorUiModel.subtitle.isNotEmpty)
          SizedBox(
            height: 16.h,
          ),
        if (errorUiModel.content.isNotEmpty)
          Text(
            errorUiModel.content,
            style: smallRegular16Primary(color: GlorifiColors.midnightBlue),
            textAlign: TextAlign.center,
          ),
        if (errorUiModel.content.isNotEmpty)
          SizedBox(
            height: 56.h,
          ),
        if (errorUiModel.action != null)
          PrimaryDarkButton(
            title: errorUiModel.actionTitle,
            onTap: errorUiModel.action,
          ),
      ],
    );
  }
}
