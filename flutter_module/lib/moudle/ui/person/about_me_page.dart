import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseWidget.dart';
import 'package:flutter_module/res/Colours.dart';

/**
 * Created by Amuser
 * Date:2020/1/13.
 * Desc:
 */
class AboutMeWidget extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _AboutMeWidget();
  }

}

class _AboutMeWidget extends BaseWidget<AboutMeWidget> {

@override
  String getTitle() {
    // TODO: implement getTitle
    return "关于我";
  }

  @override
  Widget setBodyWidget(BuildContext buildContext) {
    // TODO: implement setBodyWidget
    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        _getItem("程序员：Amuser"),
        _getItem("交流群：478720016"),
        _getItem("QQ：3329443930"),
        _getItem("个人感慨：一入吾门深似海，两眼忘川世间情！"),
      ],
    );
  }


Widget _getItem(String content) {
  return new Container(
    child: new Text(content),
    decoration: BoxDecoration(
        border:Border(bottom:BorderSide(width: 1,color:  Colours.gray_line) )
    ),
    padding: EdgeInsets.only(top:getWidth(30),bottom:getWidth(30)),
    margin: EdgeInsets.only(left:getWidth(30),right: getWidth(30) ),
  );
}
}