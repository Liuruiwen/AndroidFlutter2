import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2019/8/1.
 * Desc:圆形头像
 */
class CircleImage extends  StatelessWidget {

 const CircleImage({Key key,this.url, this.radiusSize=50, this.circleWidth, this.circleHeight, this.margin}) :super(key: key);

  final String url;
  final double radiusSize;
  final int circleWidth;
  final int circleHeight;
  final EdgeInsetsGeometry margin;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _getCircleImage();
  }

  /**
   * 获取圆型头像
   */
  Widget _getCircleImage(){

   return new Container(
      child:   new CircleAvatar(
        backgroundImage: NetworkImage(url),
        radius: radiusSize,
      ),
      width:  ScreenUtil.getInstance().setWidth(circleWidth),
      height:  ScreenUtil.getInstance().setWidth(circleWidth),
     margin: margin,
    );
  }



}

