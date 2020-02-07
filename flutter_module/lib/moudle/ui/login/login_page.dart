import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/ItemTextField.dart';
import 'package:flutter_module/moudle/base/widget/LoadingButton.dart';
import 'package:flutter_module/moudle/base/widget/RoundButton.dart';
import 'package:flutter_module/moudle/ui/login/bean/LoginPageBean.dart';
import 'package:flutter_module/moudle/ui/login/bean/TXBean.dart';
import 'package:flutter_module/moudle/ui/login/bloc/register_page_bloc.dart';
import 'package:flutter_module/moudle/ui/login/register_page.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_module/res/styles.dart';
import 'dart:convert' as convert;

import '../../../Common.dart';
import 'bloc/login_page_bloc.dart';

/**
 * Created by Amuser
 * Date:2020/1/9.
 * Desc:登录页
 */
class LoginPage extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}

class _LoginPage extends BaseStateWidget<LoginPage> {
  final TextEditingController etControllerUser = TextEditingController();
  final TextEditingController etControllerUserPwd = TextEditingController();
  LoginPageBloc _bloc;
  AppBloc _appBloc;
  Matrix4 matrix4;
  int _animateWidth=0;
  int _loginState=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<LoginPageBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
    _appBloc.loginStream.listen((data){
         if(data!=null){
           closeWidget();
         }
    });
    _appBloc.faStream.listen((call)async{
      switch (call.method) {
        case 'login':
          setState(() {});
          var msg = call.arguments;
          TXBean bean=TXBean.fromJson( convert.jsonDecode(msg.toString()));
          bool isLogin = await _bloc.loginData(bean.name,
              "123456",true,bean.headImage,bean.openid);
          if(isLogin){
            _processLoginData(bean.headImage);
          }else{
            bool isRegister = await _bloc.registerData(bean.name,
                "123456","123456");
            if(isRegister){
              _processLoginData(bean.headImage);
            }
          }
          break;
    }});
  }
  Future<dynamic> _handler(MethodCall call) async{
    switch (call.method) {
      case 'login':
        setState(() {});
        var msg = call.arguments;
        TXBean bean=TXBean.fromJson( convert.jsonDecode(msg.toString()));
        bool isLogin = await _bloc.loginData(bean.name,
           "123456",true,bean.headImage,bean.openid);
        if(isLogin){
          _processLoginData(bean.headImage);
        }else{
          bool isRegister = await _bloc.registerData(bean.name,
              "123456","123456");
          if(isRegister){
            _processLoginData(bean.headImage);
          }
        }
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _getBody(),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.fromLTRB(
                getWidth(Dimens.dp20),
                getHeight(Dimens.dp60),
                getWidth(Dimens.dp20),
                getHeight(Dimens.dp40)),
            child: new Icon(
              Icons.keyboard_arrow_left,
              size: 30,
              color: Colors.white,
            ),
          ),
          onTap: () {
            closeWidget();
          },
        ),
      ],
    ));
  }



  Widget _getBody() {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("drawable/image/login_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: <Widget>[
          Container(
            height: getHeight(Dimens.dp200),
          ),
          new ItemTextField(
            controller: etControllerUser,
            prefixIcon: Icons.person,
            hintContent: "请输入用户名",
            margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
          ),
          Gaps.vGap15,
          new ItemTextField(
              controller: etControllerUserPwd,
              prefixIcon: Icons.lock,
              hintContent: "请输入密码",
              hasSuffixIcon: true),
          Gaps.vGap15,
          LoadingButton("登录",_loginState,_animateWidth,() {
            _processLoginData(null);
          },(){
            _login();
          }),
          new Container(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text("亲，注册了？",
                    style: TextStyle(color: Colors.black, fontSize: getSp(30))),
                new GestureDetector(
                  child: new Text(
                    "注册",
                    style: TextStyle(color: Colors.white, fontSize: getSp(30)),
                  ),
                  onTap: () {
                    pushWidget(context,BlocProvider(child: RegisterPage(), bloc: RegisterPageBloc()));
                  },
                )
              ],
            ),
            margin: EdgeInsets.fromLTRB(30, 10, 30, 0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             GestureDetector(
               child: Image.asset("drawable/image/umeng_socialize_qq.png",width: getWidth(Dimens.dp150),height: getHeight(Dimens.dp150),),
               onTap: (){
                 _appBloc.getMethodChannel().invokeListMethod('login_qq', '第三方登录');
               },
             ),
              GestureDetector(
                child: Image.asset("drawable/image/umeng_socialize_wechat.png",width: getWidth(Dimens.dp150),height: getHeight(Dimens.dp150),),
                onTap: (){
                  _appBloc.getMethodChannel().invokeListMethod('login_weixin', '第三方登录');
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  _login() async {
    if ("${etControllerUser.text.trim()}" == "") {
      showToast("用户名不能为空");
      return;
    }
    if ("${etControllerUserPwd.text.trim()}" == "") {
      showToast("密码不能为空");
      return;
    }
    setState(() {
      _loginState=2;
      _animateWidth=100;
    });
    bool isLogin = await _bloc.loginData("${etControllerUser.text.trim()}",
        "${etControllerUserPwd.text.trim()}");
    if (isLogin) {
      setState(() {
        _loginState=3;
      });
    }else{
      setState(() {
        _loginState=1;
        _animateWidth=0;
      });
    }
  }

  _processLoginData(String url) async{
    LoginPageBean bean = await _appBloc.getLoginBean();
    bean.headImage=url;
    _appBloc.addLoginData(bean);
    _appBloc.addMethodCall(null);
  }


}
