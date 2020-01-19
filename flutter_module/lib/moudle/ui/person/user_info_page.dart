import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseWidget.dart';
import 'package:flutter_module/moudle/base/widget/CircleImage.dart';
import 'package:flutter_module/moudle/ui/login/bean/LoginPageBean.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/Dimens.dart';

/**
 * Created by Amuser
 * Date:2020/1/13.
 * Desc:用户详情
 */
class UserInfoPage extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return new _UserInfoPage();;
  }

}

class _UserInfoPage extends BaseWidget<UserInfoPage> {
  AppBloc _appBloc;
  @override
  String getTitle() {
    // TODO: implement getTitle
    return "用户详情";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBloc=BlocProvider.of<AppBloc>(context);
  }
  @override
  Widget setBodyWidget(BuildContext buildContext) {
    // TODO: implement setBodyWidget
    return StreamBuilder<LoginPageBean>(
      stream: _appBloc.loginStream,
        builder: (context,nabs){
      return ListView(
        children: <Widget>[
          new Center(
            child: new CircleImage(
                url: nabs.data.headImage==null?"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1578924116&di=c59b350637136244f1559c1ffaba974e&src=http://n.sinaimg.cn/sinacn10113/762/w983h579/20190417/1a2b-hvvuiym8518690.jpg"
                    :nabs.data.headImage,
                circleHeight: Dimens.dp150,
                circleWidth:Dimens.dp150,
                margin: EdgeInsets.all(30)
            ),
          ),
          _getItem("昵称：" + nabs.data.nickname),
          _getItem("Id：" + nabs.data.id.toString()),
          _getItem("类型：" + nabs.data.type.toString()),
        ],
      );
    });
  }

  Widget _getItem(String content) {
    return new Container(
      child: new Text(content),
      decoration: BoxDecoration(
          border:Border(bottom:BorderSide(width: 1,color:  Colours.gray_line) )
      ),
      padding: EdgeInsets.only(top:getWidth(30),bottom:getWidth(30)),
      margin: EdgeInsets.only(left:getWidth(30),right: getWidth(30) ),
    );
  }

}