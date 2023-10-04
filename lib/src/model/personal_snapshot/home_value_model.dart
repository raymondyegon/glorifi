import 'package:glorifi/src/widgets/charts/line_chart/line_chart.dart';

class HomeValueModel {
  HomeValueModel({
    this.cardId = 6,
    this.value,
    this.asOfDate,
    this.description = '',
    this.title = '',
    this.historical = const [],
  });

  final int cardId;
  final double? value;
  final DateTime? asOfDate;
  final String description;
  final String title;
  final List<TimeLineChartTypeInfo> historical;

  factory HomeValueModel.fromJson(Map<String, dynamic> json) {
    final int _cardId = json['card_id'] ?? 6;
    final double? _value = json['current'];
    final _asOfDate =
        json['as_of_date'] != null ? DateTime.parse(json['as_of_date']) : DateTime.now();
    final _title = json['title'] ?? 'Home Value';
    final _description = json['description'] ?? '';
    final _historicalApi = json['historical'] ?? {};

    List<dynamic> _formatHistoricalApi = _historicalApi.entries.toList().map((r) {
      Map info = Map.from({
        "date": DateTime.parse(r.key),
        "value": r.value?.toDouble() ?? 0.0,
      });
      return info;
    }).toList();

    final historicalArray =
        _formatHistoricalApi.map((h) => TimeLineChartTypeInfo.fromJson(h)).toList();

    return HomeValueModel(
        cardId: _cardId,
        value: _value,
        asOfDate: _asOfDate,
        description: _description,
        title: _title,
        historical: historicalArray,
        );
  }
}
