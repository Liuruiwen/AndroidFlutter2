import 'package:flutter/material.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * Created by Amuser
 * Date:2019/8/2.
 * Desc:横线
 */

class LineWidget extends StatelessWidget {

  const LineWidget({Key key, this.lineHeight=1, this.lineColor = Colours.gray_line}) : super(key: key);


  final int lineHeight;
  final Color lineColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getLine(context);
  }

  Widget _getLine(BuildContext buildContext) {
    return new Divider(
      height: ScreenUtil.getInstance().setHeight(lineHeight),
      color: lineColor,);
  }
}