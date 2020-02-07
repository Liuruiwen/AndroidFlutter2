import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/PageStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/CircleImage.dart';
import 'package:flutter_module/moudle/ui/login/bean/LoginPageBean.dart';
import 'package:flutter_module/moudle/ui/login/bloc/login_page_bloc.dart';
import 'package:flutter_module/moudle/ui/login/login_page.dart';
import 'package:flutter_module/moudle/ui/person/myself_page.dart';
import 'package:flutter_module/moudle/ui/person/user_info_page.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_module/util/SpUntil.dart';

import 'about_me_page.dart';

/**
 * Created by Amuser
 * Date:2019/12/19.
 * Desc:我的
 */
class PersonPage extends BaseFulWidget{
  BuildContext _context;

  PersonPage(this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PersonPage();
  }

}

class _PersonPage extends PageStateWidget<PersonPage>{
  AppBloc _appBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBloc=BlocProvider.of<AppBloc>(context);
    _appBloc.faStream.listen((call){
      switch (call.method) {
        case 'login_out'://退出登录
          setState(() {});
          var msg = call.arguments;
          if(msg.toString()=="ok"){
            _loginOut();
          }

          break;
      }
    });
    
  }



  @override
  Widget setBodyWidget(context) {
    // TODO: implement setBodyWidget
   return SingleChildScrollView(
        child:StreamBuilder<LoginPageBean>(
            stream: _appBloc.loginStream,
            builder: (context,nbs){
              return _getBodyWidget(nbs.data);
            }),);

  }


  Widget _getBodyWidget(LoginPageBean bean){
    return Column(
      children: <Widget>[
        getStateWidget(),
        _getHead(bean),
        _getItem("用户详情", () {
          bean!=null
              ? pushWidget(widget._context, new UserInfoPage())
              : _loginOut();
        }),
        _getItem("分享", () {
          showToast("此功能正在开发中");
        }),
        _getItem("关于我", () {
          pushWidget(widget._context, new AboutMeWidget());
        }),
       bean==null? new Container() : _getItem("退出登录", () {
         if(bean.openid!=null){
           _appBloc.getMethodChannel().invokeListMethod('login_out',bean.openid);
           return;
         }
          _loginOut();
        }),

      ],
    );
  }

  Widget _getHead(LoginPageBean bean) {
    return new Stack(
      alignment: new Alignment(0, 0),
      children: <Widget>[
        new Image(image: new AssetImage('drawable/image/mine_head.jpg'),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: getHeight(Dimens.dp400),
          fit: BoxFit.cover,
        ),
        new GestureDetector(
          child: new Column(
            children: <Widget>[
              new CircleImage(
                url: bean==null ?"": bean.headImage==null?"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1578924116&di=c59b350637136244f1559c1ffaba974e&src=http://n.sinaimg.cn/sinacn10113/762/w983h579/20190417/1a2b-hvvuiym8518690.jpg"
                    :bean.headImage,
                circleHeight: Dimens.dp150,
                circleWidth: Dimens.dp150,
              ),
              new Container(
                child: new Text( bean==null?"亲，您还未登录哦":bean.nickname,style: TextStyle(fontSize: getSp(Dimens.sp28),color: Colors.white),),
                margin: EdgeInsets.only(top: getWidth(Dimens.dp20)),
              )
            ],
          ),
          behavior: HitTestBehavior.opaque,
          onTap: () {
                if(bean==null){
                  _loginOut();
                }
          },
        ),

      ],
    );
  }


  Widget _getItem(String content, Function tap) {
    return new Container(
      decoration: BoxDecoration(
          border:Border(bottom:BorderSide(width: 1,color:  Colours.gray_line) )
      ),
      padding: EdgeInsets.only(top:getWidth(30),bottom:getWidth(30)),
      margin: EdgeInsets.only(left:getWidth(30),right: getWidth(30) ),
      child: new GestureDetector(
        child: new Row(
          children: <Widget>[
            new Expanded(child: new Text(content)),
            new Icon(Icons.keyboard_arrow_right, color: Colours.gray_ce,)
          ],
        ),
        onTap: tap,
      ),

    );
  }


  _loginOut() async{
   await  SpUntil.instance.spClear(SpUntil.SP_LOGIN);
   _appBloc.addLoginData(null);
    pushWidget(widget._context,BlocProvider(child: LoginPage(), bloc: LoginPageBloc()));
  }
}