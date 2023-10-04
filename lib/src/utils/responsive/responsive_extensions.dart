import 'package:glorifi/src/utils/responsive/responsive_util.dart';

extension ResponsiveExtensions on num {
  double get w => ResponsiveUtil().setWidth(this);

  double get h => ResponsiveUtil().setHeight(this);

  double get r => ResponsiveUtil().radius(this);

  double get sp => ResponsiveUtil().setSp(this);

  ///Multiple of screen width
  double get sw => ResponsiveUtil().screenWidth * this;

  ///Multiple of screen height
  double get sh => ResponsiveUtil().screenHeight * this;
}
