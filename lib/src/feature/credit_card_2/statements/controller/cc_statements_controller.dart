import 'package:glorifi/src/feature/credit_card_2/statements/models/statement_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/double_utils.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/charts/glorifi_barchart/model/glorifi_bar_chart_model.dart';

class CCStatementsController extends BaseController {
  /// graph data
  final List<GloriFiBarChartData> _dummyChartData = [
    GloriFiBarChartData("Dec", 873.44, prefixText: r"$"),
    GloriFiBarChartData("Jan", 1800, prefixText: r"$"),
    GloriFiBarChartData("Feb", 1978, prefixText: r"$"),
    GloriFiBarChartData("Mar", 1432, prefixText: r"$"),
    GloriFiBarChartData("Apr", 2321, prefixText: r"$"),
    // Running month data [green color]
    GloriFiBarChartData("May", 550,
        prefixText: r"$", focusedBarColor: GlorifiColors.greenTint[600]),
  ];
  get barchartData => _dummyChartData;

  ///statement info data [graph footer]
  double _lastStatementValue = 2321;
  get lastStatementValue => _lastStatementValue.formatNumberInEn_US();
  String _lastStatementMonth = "April";
  get lastStatementTitle => "Last statement ($_lastStatementMonth)";
  double _spendingSinceLastStatementValue = 500;
  get spendingSinceLastStatement =>
      '\$${_spendingSinceLastStatementValue.formatNumberInEn_US(showDecimalPoint: true)}';
  String nextStatementDate = '4/28/2022';

  /// statements

  List<Map<String, dynamic>> statementsMap = [
    {
      "year": "2022",
      "statements": [
        StatementModel("May", DateTime(2022, 4, 20)),
        StatementModel("April", DateTime(2022, 3, 18)),
        StatementModel("March", DateTime(2022, 3, 15)),
        StatementModel("February", DateTime(2022, 2, 18)),
        StatementModel("January", DateTime(2022, 1, 20)),
      ]
    },
    {
      "year": "2021",
      "statements": [

        StatementModel("May", DateTime(2021, 4, 20)),

      ]
    },
    {
      "year": "2020",
      "statements": [
        StatementModel("Dec", DateTime(2020, 12, 20)),

      ]
    },
  ];

  @override
  void onInit() {
    super.onInit();

    //TODO: fetch data from API
  }
}
