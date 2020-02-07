import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseWidget.dart';
import 'package:flutter_module/moudle/base/widget/LoadingButton.dart';

/**
 * Created by Amuser
 * Date:2020/1/12.
 * Desc:关于我自己
 */
class MyselfPage extends BaseFulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyselfPage();
  }

}

class _MyselfPage extends BaseWidget<MyselfPage> with SingleTickerProviderStateMixin{
  AnimationController _controller; 
  Animation _animation;
    @override
  String getTitle() {
    // TODO: implement getTitle
    return "关于我";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(
            duration: Duration(milliseconds: (600).round()),
            vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addListener((){
      setState(() {

      });
    });
    _controller.addStatusListener((status) {

      if (status == AnimationStatus.completed) {

      }
    });
  }

  @override
  Widget setBodyWidget(BuildContext buildContext) {
    // TODO: implement setBodyWidget
    return Container(
      color: Colors.white,
      child:Column(children: <Widget>[
        FlatButton(onPressed: (){
          _controller.forward();
        }, child: Text("加载动画")),
        Container(
          alignment: Alignment.center,
          color: Colors.blue,
          width: 100,
          height: 100,
          child: Padding(padding: EdgeInsets.only(right: 50),
          child: CustomPaint(
            painter: LoadingFinish(_animation.value),
//              child: Container(),
          ),
          )
        )
      ],)
    );
  }
}