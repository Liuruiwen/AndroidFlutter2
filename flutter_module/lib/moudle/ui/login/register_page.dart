import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/ItemTextField.dart';
import 'package:flutter_module/moudle/base/widget/RoundButton.dart';
import 'package:flutter_module/moudle/ui/login/bean/LoginPageBean.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_module/res/styles.dart';
import 'bloc/register_page_bloc.dart';
import 'package:flutter_module/moudle/base/widget/LoadingButton.dart';
/**
 * Created by Amuser
 * Date:2020/1/9.
 * Desc:登录页
 */
class RegisterPage extends BaseFulWidget {
  RegisterPage();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPage();
  }
}

class _RegisterPage extends BaseStateWidget<RegisterPage> {
  final TextEditingController etControllerUser = TextEditingController();
  final TextEditingController etControllerUserPwd = TextEditingController();
  final TextEditingController etControllerConfirmPwd = TextEditingController();
  RegisterPageBloc _bloc;
  AppBloc _appBloc;
  int _animateWidth=0;
  int _loginState=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<RegisterPageBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
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
          new ItemTextField(
              controller: etControllerConfirmPwd,
              prefixIcon: Icons.lock,
              hintContent: "请确认密码",
              hasSuffixIcon: true),
          Gaps.vGap15,
          LoadingButton("注册",_loginState,_animateWidth,() {
            _processRegisterData();
          },(){
            _register();
          }),
        ],
      ),
    );
  }

  _register() async {
    if ("${etControllerUser.text.trim()}" == "") {
      showToast("用户名不能为空");
      return;
    }
    if ("${etControllerUserPwd.text.trim()}" == "") {
      showToast("密码不能为空");
      return;
    }
    if ("${etControllerConfirmPwd.text.trim()}" == "") {
      showToast("新密码确认不能为空");
      return;
    }
    if ("${etControllerUserPwd.text.trim()}" != "${etControllerConfirmPwd.text.trim()}") {
      showToast("两次密码输入不一致");
      return;
    }
    setState(() {
      _loginState=2;
      _animateWidth=100;
    });
    bool isLogin = await _bloc.registerData("${etControllerUser.text.trim()}",
        "${etControllerUserPwd.text.trim()}","${etControllerConfirmPwd.text.trim()}");
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

  _processRegisterData() async{
    LoginPageBean bean = await _appBloc.getLoginBean();
    _appBloc.addLoginData(bean);
    closeWidget();
  }
}
