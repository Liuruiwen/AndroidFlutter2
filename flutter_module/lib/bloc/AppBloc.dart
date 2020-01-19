import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/moudle/ui/login/bean/FABean.dart';
import 'package:flutter_module/moudle/ui/login/bean/LoginPageBean.dart';
import 'package:flutter_module/util/SpUntil.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as convert;
import '../Common.dart';
import 'BlocBase.dart';

/**
 * Created by Amuser
 * Date:2019/10/19.
 * Desc:全局bloc管理
 */
class AppBloc extends BlocBase {

  AppCode _appCode;
  BehaviorSubject<AppCode> _subject = BehaviorSubject<AppCode>();

  Stream<AppCode> get themeStream => _subject.stream;

  //与原生交互的
  MethodChannel _methodChannel =null;
  AppBloc() {
    _appCode = new AppCode();
    _appCode.appThemeColor = Colors.blue;
   
  }
  MethodChannel getMethodChannel(){
    if(_methodChannel==null){
      _methodChannel = MethodChannel(Common.CONNECT_CONTEXT);
    }
    return _methodChannel;
  }

   




  AppCode getAppCode() {
    return _appCode;
  }


  setAppThemeColor(Color color) {
    _appCode.appThemeColor = color;
    _subject.add(_appCode);
  }

  ///=========获取登录数据==========
  BehaviorSubject<LoginPageBean> _loginSubject = BehaviorSubject<
      LoginPageBean>();

  Stream<LoginPageBean> get loginStream => _loginSubject.stream;
  LoginPageBean get loginBean => _loginBean;
  LoginPageBean _loginBean;
   getLoginBean() async{
    String jsonStr = await SpUntil.instance.getSpString(SpUntil.SP_LOGIN);
    if (jsonStr != null) {
      _loginBean = LoginPageBean.fromJson( convert.jsonDecode(jsonStr));
      return _loginBean;
    }
    return null;
  }

  addLoginData(LoginPageBean bean) {
    _loginSubject.add(bean);
  }


  //Android 和Flutter交互
  BehaviorSubject<MethodCall> _faSubject = BehaviorSubject<MethodCall>();
  Stream<MethodCall> get faStream => _faSubject.stream;


  @override
  void dispose() {
    // TODO: implement dispose
    _loginSubject.close();
    _subject.close();
  }

  @override
  Future initData(BuildContext context) async{
    // TODO: implement initData
   await  SpUntil.instance.getSpInstance();
   print("=========你到底进来几次啊==========我去");
   LoginPageBean bean = await getLoginBean();
   if(bean!=null){
     addLoginData(bean);
   }
//   _methodChannel = MethodChannel(Common.CONNECT_CONTEXT);
//   _methodChannel.setMethodCallHandler(_handler);
   
  }

  addMethodCall(MethodCall call){
    _faSubject.add(call);
  }
////接收android监听
  Future<dynamic> _handler(MethodCall call)async{
    print("=======看看===是否进来啊啦啦啦啦啦啦啦");
    _faSubject.add(call);
  }


}


class AppCode {
  Color appThemeColor;

}