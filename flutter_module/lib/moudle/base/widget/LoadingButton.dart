import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2020/1/12.
 * Desc:
 */
typedef Future onLoadingFinish();
class LoadingButton extends StatefulWidget{
  int _state=1;
  int _animateWidth=0;
  onLoadingFinish _finish;
  Function _function;
  String _title;

  LoadingButton(this._title,this._state,this._animateWidth, this._finish, this._function);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoadingButton();
  }

}
class _LoadingButton extends State<LoadingButton> with SingleTickerProviderStateMixin{
  AnimationController _controller; //动画控制器
  Animation _animation; //动画执行
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(
            duration: Duration(milliseconds: (600).round()),
            vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addListener((){setState(() {});});
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(milliseconds: 200), (){
          widget._finish();
        });

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      width: MediaQuery
          .of(context)
          .size
          .width ,
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
//            transform: Matrix4.identity()
//              ..scale(_animateX,_animateY, _animateZ),
          height:getWidth(Dimens.dp100),
          width:widget._animateWidth==0? MediaQuery
              .of(context)
              .size
              .width:getWidth(widget._animateWidth),
          margin: EdgeInsets.fromLTRB(getWidth(Dimens.dp50), getHeight(Dimens.dp80), getWidth(Dimens.dp50), 0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(child: _getLoginWidget(),),
        ),
        onTap:widget._function,
      ),
    );
  }


  Widget _getText(){
    return new Center(
      child: new Text(widget._title,
        style: TextStyle(
            color: Colors.white,
            fontSize:getSp(Dimens.sp30)),
      ),
    );
  }

  Widget _getLoading(){
    return SizedBox(
      height: getWidth(Dimens.dp50),
      width: getWidth(Dimens.dp50),
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor:AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }

  Widget _getLoginWidget() {
    switch (widget._state) {
      case 1:
        return _getText();
      case 2:
        return _getLoading();
      case 3:
        _controller.forward();
        return Container(
          padding: EdgeInsets.only(right: getWidth(55),bottom:  getWidth(18)),
          child: CustomPaint(
              painter: LoadingFinish(_animation.value),
        )
        );
    }
  }

  //获取宽度
  getWidth(int width){
    return ScreenUtil.getInstance().setWidth(width);
  }
  ///获取高度
  double  getHeight(int height){
    return ScreenUtil.getInstance().setHeight(height);
  }

  getSp(int sp){
    return  ScreenUtil.getInstance().setSp(sp);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}

class LoadingFinish extends CustomPainter{
  double _animateValue=0.0;
  LoadingFinish(this._animateValue); //绘制流程
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..color = Colors.white//画笔颜色
//      ..strokeCap = StrokeCap.round //画笔笔头类型
//      ..isAntiAlias = false //是否开启抗锯齿
////      ..blendMode = BlendMode.src//颜色混合模式
      ..style = PaintingStyle.stroke //画笔样式，默认为填充
//      ..colorFilter = ColorFilter.mode(Colors.red,
////          BlendMode.src) //颜色渲染模式
////      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0) //模糊遮罩效果
//      ..filterQuality = FilterQuality.high //颜色渲染模式的质量
      ..strokeWidth = 4.0; //画笔的宽度

    var path = Path();
    path.lineTo(20/3*_animateValue,50/3*_animateValue);
    path.lineTo(100/3*_animateValue,10/3*_animateValue);
    canvas.drawPath(path, _paint);
  }


  //刷新布局的时候告诉flutter 是否需要重绘
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}