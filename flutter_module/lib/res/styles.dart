import 'package:flutter/widgets.dart';

import 'Colours.dart';
import 'Dimens.dart';

class TextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_dark,
    fontWeight: FontWeight.bold,
  );
}

class Decorations {
  static Decoration bottom = BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.33, color: Colours.divider)));
}

/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap5 = new SizedBox(width: Dimens.go_dp5);
  static Widget hGap10 = new SizedBox(width: Dimens.go_dp10);
  static Widget hGap15 = new SizedBox(width: Dimens.go_dp15);
  static Widget hGap30 = new SizedBox(width: Dimens.go_dp30);

  /// 垂直间隔
  static Widget vGap5 = new SizedBox(height: Dimens.go_dp5);
  static Widget vGap10 = new SizedBox(height: Dimens.go_dp10);
  static Widget vGap15 = new SizedBox(height: Dimens.go_dp15);

  static Widget getHGap(double w) {
    return SizedBox(width: w);
  }

  static Widget getVGap(double h) {
    return SizedBox(height: h);
  }
}
