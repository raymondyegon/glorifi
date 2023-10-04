import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/deposited_check_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/model/check_model.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';

var checkModel = <CheckModel>[
  CheckModel(
      date: 'May 29, 2022',
      amount: 5587.60,
      description: "Deposited to savings *123",
      number: 'Check # 232434234',
      status: CheckStatus.Complete,
      front_image: GlorifiAssets.checkFront,
      back_image: GlorifiAssets.checkBack),
  CheckModel(
      date: 'May 29, 2022',
      amount: 5587.60,
      description: "Deposited to savings *123",
      number: 'Check # 232434234',
      status: CheckStatus.Rejected,
      front_image: GlorifiAssets.checkFront,
      back_image: GlorifiAssets.checkBack),
  CheckModel(
      date: 'May 29, 2022',
      amount: 5587.60,
      description: "Deposited to savings *123",
      number: 'Check # 232434234',
      status: CheckStatus.Complete,
      front_image: GlorifiAssets.checkFront,
      back_image: GlorifiAssets.checkBack)
];
