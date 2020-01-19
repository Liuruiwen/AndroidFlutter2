import 'package:flutter/material.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2019/12/31.
 * Desc:缺省页
 */
class EmptyPageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(context);
    return new Center(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Image(
                image: new AssetImage('image/gift_bill_list_empty.png'),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: ScreenUtil.getInstance().setHeight(Dimens.dp300),
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.only(left: 80, right: 80, bottom: 30),
            ),
            new Expanded(child:   new Text(""),)

          ],
        ),
        height:ScreenUtil.getInstance().setHeight(Dimens.dp400),
      ),
    );
  }

}