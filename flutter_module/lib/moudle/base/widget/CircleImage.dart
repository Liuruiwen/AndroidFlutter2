import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2019/12/16.
 * Desc:
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

