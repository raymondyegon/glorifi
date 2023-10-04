import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/check_print_controller.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Print extends GetView<CheckPrintController> {
  const Print({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: GlorifiColors.bgColor,
      appBar: GlorifiAppBar(
        title: 'Check PDF',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: PdfPreview(
          scrollViewDecoration: BoxDecoration(color: GlorifiColors.bgColor),
          pdfPreviewPageDecoration: BoxDecoration(color: GlorifiColors.bgColor),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          canDebug: false,
          build: (format) => _generatePdf(format, controller.image['image']),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final image = await imageFromAssetBundle(title);

    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(image),
      );
    }));

    return pdf.save();
  }
}
