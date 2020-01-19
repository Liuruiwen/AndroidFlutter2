import 'package:flutter/material.dart';

/**
 * Created by Amuser
 * Date:2019/7/4.
 * Desc:弹窗案列
 * https://www.jianshu.com/p/4bbbb5aa855d
 * https://www.jianshu.com/p/52e0cce2be0a
 */

 class DialogWidget extends Dialog{
   String text;

   DialogWidget({Key key, @required this.text}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return new Material( //创建透明层
       type: MaterialType.transparency, //透明类型
       child: new Center( //保证控件居中效果
         child: new SizedBox(
           width: 120.0,
           height: 120.0,
           child: new Container(
             decoration: ShapeDecoration(
               color: Color(0xffffffff),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(
                   Radius.circular(8.0),
                 ),
               ),
             ),
             child: new Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 new CircularProgressIndicator(),
                 new Padding(
                   padding: const EdgeInsets.only(
                     top: 20.0,
                   ),
                   child: new Text(
                     text,
                     style: new TextStyle(fontSize: 12.0),
                   ),
                 ),
               ],
             ),
           ),
         ),
       ),
     );
   }
 }