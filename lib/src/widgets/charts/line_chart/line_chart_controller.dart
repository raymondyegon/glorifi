import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/widgets/charts/line_chart/line_chart.dart';

enum LabelFormat { MMMd, years }

class LineChartController extends GetxController {
  LineChartController(this._data);

  final List<TimeLineChartTypeInfo> _data;

  final List<TimeLineChartTypeInfo> processedData = [];
  final List<int> _timestamps = [];

  late int firstTimestamp;
  late int middleTimestamp;
  late int lastTimestamp;
  late int partialTimestamp13andHalfPercent;
  late int partialTimestamp86andHalfPercent;

  late int interval;
  LabelFormat _labelFormat = LabelFormat.MMMd;

  double maxValue = 0;
  double minValue = 9999999999999999999999999999999999999.0;

  Rx<FlSpot?> markerSpot = FlSpot(0, 0).obs;
  RxBool showMarker = false.obs;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  String getLabel(int timeStamp) {
    switch (_labelFormat) {
      case LabelFormat.MMMd:
        return DateTime.fromMillisecondsSinceEpoch(timeStamp).toMMMd();
      case LabelFormat.years:
        return DateTime.fromMillisecondsSinceEpoch(timeStamp).year.toString();
    }
  }

  void _preProcessData() {
    if (_data.isNotEmpty) {
      processedData.addAll(_data);
    } else {
      final _now = DateTime.now();
      processedData.addAll([
        TimeLineChartTypeInfo(
          DateTime(_now.year, _now.month - 2, _now.day),
          0,
        ),
        TimeLineChartTypeInfo(
          DateTime(_now.year, _now.month - 1, _now.day),
          0,
        ),
        TimeLineChartTypeInfo(
          _now,
          0,
        ),
      ]);
    }

    ///we need at least 2 points to draw a chart
    if (processedData.length == 1) {
      if (_labelFormat == LabelFormat.years) {
        final DateTime firstDate = processedData.first.domainName;
        processedData.insert(
            0,
            TimeLineChartTypeInfo(
                DateTime(
                  firstDate.year - 1,
                  firstDate.month,
                  firstDate.day,
                ),
                0));
      } else {
        final DateTime firstDate = processedData.first.domainName;
        processedData.insert(
          0,
          TimeLineChartTypeInfo(
              DateTime(
                firstDate.year,
                firstDate.month - 1,
                firstDate.day,
              ),
              0),
        );
      }
    }
  }

  void loadData() {
    _preProcessData();
    _timestamps.clear();
    _timestamps.addAll(
        processedData.map((e) => e.domainName.millisecondsSinceEpoch).toList());
    firstTimestamp = _timestamps.first;
    lastTimestamp = _timestamps.last;
    middleTimestamp =
        ((lastTimestamp - firstTimestamp) / 2 + firstTimestamp).toInt();
    interval = lastTimestamp - firstTimestamp;

    partialTimestamp13andHalfPercent = (interval / 100 * 13.5).toInt();
    partialTimestamp86andHalfPercent = (interval / 100 * 86.5).toInt();

    ///if interval is more than 1 year
    if (interval > 365 * 24 * 60 * 60 * 1000) {
      _labelFormat = LabelFormat.years;
    }
  }

  void setMarkerPosition(BoxConstraints constraints, double bottomPadding) {
    processedData.forEach((element) {
      if (element.measureName > maxValue) {
        maxValue = element.measureName.toDouble();
      }

      if (element.measureName < minValue) {
        minValue = element.measureName.toDouble();
      }
    });

    if (markerSpot.value == null || showMarker.isFalse) {
      Future.delayed(Duration(milliseconds: 1)).then((value) {
        final x = constraints.maxWidth /
            (interval / (lastTimestamp - firstTimestamp));

        if (minValue == maxValue) {
          minValue = 0;
        }
        final range = maxValue - minValue;

        final double yAxisScaleCoefficient =
            (constraints.maxHeight - bottomPadding) / range;

        late double y;
        if (minValue < 0) {
          y = yAxisScaleCoefficient *
              (processedData.last.measureName + minValue.abs());
        } else {
          y = yAxisScaleCoefficient * processedData.last.measureName;
        }

        markerSpot.value = FlSpot(x, y);
        showMarker.value = true;
      });
    }
  }
}
