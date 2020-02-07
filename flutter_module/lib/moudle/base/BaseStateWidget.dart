import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'BaseFulWidget.dart';


/**
 * Created by Amuser
 * Date:2019/12/12.
 * Desc:
 */
 class BaseStateWidget<T extends BaseFulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screen(context);
    return getBuildWidget(context);
  }

  void screen(BuildContext buildContext) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)
      ..init(buildContext);
    initLis(buildContext);
  }


  void initLis(BuildContext buildContext) {

  }

  Color setThemeColor() {
    return Colors.red;
  }


  Widget getBuildWidget(BuildContext buildContext) {
    return new Center(child: new Text("请重新编写widget"),);
  }


  void showToast(String msg) {
    widget.showToast(msg);
  }


  void pushWidget(BuildContext buildContext
      , Widget widget,{bool isClose=false}) {
    if (isClose) {
      Navigator.pushAndRemoveUntil(
          buildContext, new MaterialPageRoute(builder: (BuildContext context) {
        return widget;
      }), (route) => route == null);
    } else {
      Navigator.push(
          buildContext,
          MaterialPageRoute(builder: (context) => widget));
    }
  }

  pushForWidget(BuildContext buildContext
      , Widget widget) async {
    return await Navigator.push( //等待
        buildContext,
        MaterialPageRoute(builder: (context) => widget));
  }


  void closeWidget() {
    Navigator.pop(context);
  }




  void closePageForWidget(BuildContext buildContext, Widget widget) {
    Navigator.pushAndRemoveUntil(
        buildContext, new MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }), (route) => route == null);
  }

  Widget getEmptyPage() {
    return new Center(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Image(
                image: new AssetImage('drawable/image/loading_error.jpg'),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: getHeight(Dimens.dp300),
                fit: BoxFit.cover,
              ),
              margin: EdgeInsets.only(left: 80, right: 80, bottom: 30),
            ),
            new Expanded(child:   new Text("亲，系统开小差哦！",style: TextStyle(fontSize: getSp(Dimens.sp30))),)

          ],
        ),
        height:getHeight(Dimens.dp400),
      ),
    );
  }

     getWidth(int width){
    return ScreenUtil.getInstance().setWidth(width);
    }
   double  getHeight(int height){
     return ScreenUtil.getInstance().setHeight(height);
   }

    getSp(int sp){
     return  ScreenUtil.getInstance().setSp(sp);
   }

   getStateWidget(){
    return Container(height: MediaQueryData.fromWindow(window).padding.top,
      color: Colors.blue[500],
    );
   }
 }
