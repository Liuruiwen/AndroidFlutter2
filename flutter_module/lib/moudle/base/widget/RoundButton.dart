import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2019/8/1.
 * Desc:按钮
 */

class RoundButton extends StatelessWidget {


  const RoundButton({Key key, this.textContent, this.textColor = Colors
      .white, this.textSp = 30, this.buttonBg = Colors.blue,
    this.bgRadius = 60, this.bgWidth=0, this.bgHeight = 80, this.margin, this.buttonClick})
      : super(key: key);
  final String textContent;
  final Color textColor;
  final int textSp;
  final Color buttonBg;
  final double bgRadius;
  final double bgWidth;
  final int bgHeight;
  final EdgeInsetsGeometry margin;
  final Function buttonClick;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getRundButton(context);
  }


  Widget _getRundButton(BuildContext buildContext) {
    return new GestureDetector(
      child: new Container(
        child: new Center(
          child: new Text(textContent,
            style: TextStyle(
                color: textColor,
                fontSize: ScreenUtil.getInstance().setSp(
                    textSp)),
          ),
        ),
        decoration: BoxDecoration(
          color: buttonBg == null ? Colors.blue : buttonBg,
          borderRadius: BorderRadius.circular(bgRadius == 0 ? 60 : bgRadius),
        ),
        width: bgWidth == 0 ? MediaQuery
            .of(buildContext)
            .size
            .width : bgWidth,
        height: ScreenUtil.getInstance().setHeight(bgHeight),
        margin: margin==null?EdgeInsets.fromLTRB(30, 0, 30, 0):margin,
      ),
      onTap: buttonClick,
    );
  }
}