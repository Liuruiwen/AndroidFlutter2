

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


/**
 * Created :Auser
 *  Date: 2019/5/6.
 *  Desc:widget基类
 */
abstract class BaseFulWidget  extends StatefulWidget {

 void showToast(String msg){
   Fluttertoast.showToast(
       msg: msg,
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.CENTER,
       timeInSecForIos: 1,
       backgroundColor: Colors.blue,
       textColor: Colors.white);
 }


}


