

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


/**
 * Created by Amuser
 * Date:2019/12/12.
 * Desc:
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


