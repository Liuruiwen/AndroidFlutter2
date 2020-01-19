import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ui/login/bean/LoginPageBean.dart';
import 'package:flutter_module/util/SpUntil.dart';
import 'package:rxdart/subjects.dart';
import 'dart:convert' as convert;
import '../../../ApiConfirg.dart';
/**
 * Created by Amuser
 * Date:2020/1/9.
 * Desc:
 */
class RegisterPageBloc extends HttpBloc{

  //====================注册================
  Future<bool> registerData(String username,String password,String repassword) async{
    return    await  postData<LoginPageBean>(ApiConfig.HTTP_REGISTER, {
      "username": username,"password": password,"repassword": repassword,
    }, (data){
      if (data != null) {
        LoginPageBean bean=data;
        SpUntil.instance.spString(SpUntil.SP_LOGIN, convert.jsonEncode(bean.toJson()));

        return true;
      }

      return false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future initData(BuildContext context) {
    // TODO: implement initData
  }

}