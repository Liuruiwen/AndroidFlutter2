
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/moudle/ui/login/bean/LoginPageBean.dart';
import 'package:flutter_module/util/SpUntil.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert' as convert;
import '../Common.dart';
import 'BlocBase.dart';

/**
 * Created by Amuser
 * Date:2019/12/6.
 * Desc:
 */
class AppBloc extends BlocBase {

  AppCode _appCode;
  BehaviorSubject<AppCode> _subject = BehaviorSubject<AppCode>();

  Stream<AppCode> get themeStream => _subject.stream;

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
   LoginPageBean bean = await getLoginBean();
   if(bean!=null){
     addLoginData(bean);
   }

  }

  addMethodCall(MethodCall call){
    _faSubject.add(call);
  }


}


class AppCode {
  Color appThemeColor;

}