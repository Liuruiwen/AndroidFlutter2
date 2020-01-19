import 'package:flutter/material.dart';
import 'BaseFulWidget.dart';
import 'BaseStateWidget.dart';
/**
 * Created :Auser
 *  Date: 2019/5/6.
 *  Desc:初始化Scaffold
 */

class BaseWidget<T extends BaseFulWidget> extends BaseStateWidget<T> {



  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return Scaffold(
            appBar: AppBar(
              leading:GestureDetector(
                child: new Center(child: setLeftWidget(),),
                onTap: (){
                  onLeftClick();
                },
              ),
              title: new Text(getTitle()) ,
              centerTitle: true,
               actions: <Widget>[
                 GestureDetector(
                   child: setRightWidget(),
                   onTap: (){
                     onRightClick();
                   },
                 ),
               ],
            ),
            body:  setBodyWidget(context),
          );
  }

  Widget setLeftWidget(){
    return  new Icon(
        Icons.keyboard_arrow_left, size: 30);
  }

  Widget setBodyWidget(BuildContext buildContext){
    return Center(
      child: Text("没有创建view哦"),
    );
  }

  Widget setRightWidget(){
    return Container();
  }


  void onLeftClick() {
    closeWidget();
  }

  void onRightClick() {

  }
  String getTitle(){
    return "";
  }



}