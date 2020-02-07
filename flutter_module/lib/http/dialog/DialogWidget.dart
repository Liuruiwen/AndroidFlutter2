import 'package:flutter/material.dart';


/**
 * Created by Amuser
 * Date:2019/12/6.
 * Desc:
 */
 class DialogWidget extends Dialog{
   String text;

   DialogWidget({Key key, @required this.text}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return new Material(
       type: MaterialType.transparency,
       child: new Center( 
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