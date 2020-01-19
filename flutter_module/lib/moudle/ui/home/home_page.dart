import 'dart:ui';

import 'package:banner_view/banner_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/PageStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/WebPage.dart';
import 'package:flutter_module/moudle/ui/home/bean/BannerBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectListBean.dart';
import 'package:flutter_module/moudle/ui/home/bloc/home_page_bloc.dart';
import 'package:flutter_module/moudle/ui/home/bloc/hot_project_page_bloc.dart';
import 'package:flutter_module/moudle/ui/home/bloc/search_page_bloc.dart';
import 'package:flutter_module/moudle/ui/home/hot_project_page.dart';
import 'package:flutter_module/moudle/ui/home/search_page.dart';
import 'package:flutter_module/moudle/ui/home/widget/hot_project_widget.dart';
import 'package:flutter_module/moudle/ui/home/wx_public_list.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_module/util/CommonUtil.dart';
import '../../../Common.dart';
import 'bean/ChaptersBean.dart';
import 'bloc/wx_public_list_bloc.dart';

/**
 * Created by Amuser
 * Date:2019/12/15.
 * Desc:首页
 */
class HomePage extends BaseFulWidget {
  BuildContext _context;

  HomePage(this._context);

  @override
  _HomePage createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends PageStateWidget<HomePage> {
  HomePageBloc _bloc;
  AppBloc _appBloc;
  ScrollController _scrollController;
  int _stateColor=0;
//  MethodChannel _methodChannel = MethodChannel(Common.CONNECT_CONTEXT); //与android连接

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<HomePageBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
    _scrollController=new ScrollController()..addListener((){
      if(_scrollController.position.pixels<=100){
        setState(() {
          _stateColor=(_scrollController.position.pixels/200*10%5).toInt();
        });
      }else{
        setState(() {
          _stateColor=5;
        });

      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.initData(widget._context));

//    _methodChannel.setMethodCallHandler(_handler);
  }
//接收android监听
  Future<dynamic> _handler(MethodCall call) {
    switch (call.method) {
      case 'android':
        setState(() {});
        var msg = call.arguments;
//        _text = msg.toString();
        break;
    }
  }


  @override
  Widget setBodyWidget(context) {
    // TODO: implement setBodyWidget
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              Container(
                height:  MediaQueryData.fromWindow(window).padding.top+getHeight(Dimens.dp80),
              ),
              _getBanner(),
              _getConmmonWidget("公众号达人", "", _bloc.chapterStream, () {}),
              _getChapters(),
              _getConmmonWidget("热门项目", "更多》", _bloc.projectStream, () {
                pushWidget(
                    widget._context,
                    BlocProvider(
                        child: HotProjectPage(), bloc: HotProjectPageBloc()));
              }),
              _getProjectWidget(),
            ],
          ),
        ),
        getStateWidget(),
        _getHeader()
      ],
    );
  }

  Widget _getHeader() {
    return Container(
      color: getStateColor(_stateColor),
      margin: EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
      padding: EdgeInsets.fromLTRB(getWidth(Dimens.dp20), getWidth(Dimens.dp15), getWidth(Dimens.dp20), getWidth(Dimens.dp15)),
      child: Row(
        children: <Widget>[
          new GestureDetector(
              child: new Container(
                child: Text(
                  "佛山",
                  style: TextStyle(fontSize: getSp(Dimens.sp26),color: getFontColor(_stateColor,1)),
                ),
                padding: EdgeInsets.only(left: 5),
              ),
              onTap: () {
                //发消息给Android
                _appBloc.getMethodChannel().invokeListMethod(
                    'flutter', '不晓得说点什么好');
              }),
          Expanded(
              child: GestureDetector(child: Container(
                //修饰黑色背景与圆角
                decoration: new BoxDecoration(
                  border: Border.all(color: getFontColor(_stateColor,2), width: 1.0), //灰色的一层边框
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
                ),
                alignment: Alignment.centerLeft,
                height: getHeight(Dimens.dp60),
                padding: EdgeInsets.only(left: getWidth(Dimens.dp20)),
                margin: EdgeInsets.fromLTRB(10.0, 0.0, 10, 0),
                child:  Row(
                  children: <Widget>[
                    new Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.blue,
                    ),
                    Expanded(child: Text("学无止境，开始搜索之路",style: TextStyle(color: Colours.divider,fontSize: getSp(Dimens.sp26)),textAlign: TextAlign.center,))
                  ],
                ),
              ),onTap: (){
                pushWidget(widget._context,
                    BlocProvider(child: SearchPage(), bloc: SearchPageBloc()));
              },)),
        ],
      ),
    );
  }

  Color getStateColor(int state){
    switch(state){
      case 0:
        return Colors.white;
      case 1:
        return Colors.blue[100];
      case 2:
        return Colors.blue[200];
      case 3:
        return Colors.blue[300];
      case 4:
        return Colors.blue[400];
      case 5:
        return Colors.blue[500];

    }

  }

  Color getFontColor(int state,int type){
    switch(state){
      case 0:
        return type==1?Colors.blue[500]:Colors.grey[200];
      case 1:
        return Colors.white24;
      case 2:
        return Colors.white38;
      case 3:
        return Colors.white54;
      case 4:
        return Colors.white60;
      case 5:
        return Colors.white;

    }

  }




  Widget _getBanner() {
    return StreamBuilder<List<BannerBean>>(
        stream: _bloc.bannerStream,
        builder: (context, nbs) {
          return nbs.data == null ? Container() : getBanner(nbs.data);
        });
  }

  ///===========banner图============
  Widget getBanner(List<BannerBean> list) {
    List<Widget> _list = list?.map((item) {
      return new GestureDetector(
        child: Image.network(item.imagePath, fit: BoxFit.cover),
        onTap: () {
          pushWidget(widget._context,
              WebPage(item.url,item.title));
        },
      );
    })?.toList();
    return new Container(
      child: new BannerView(
        _list,
        intervalDuration: const Duration(seconds: 3),
      ),
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }

  ///===========公众号============
  Widget _getChapters() {
    return StreamBuilder<List<ChaptersBean>>(
        stream: _bloc.chapterStream,
        builder: (context, nab) {
          return nab.data == null
              ? Container()
              : Container(
                  height: getHeight(Dimens.dp200),
                  child: ListView.builder(
                      itemCount: nab.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: getWidth(Dimens.dp120),
                                height: getHeight(Dimens.dp120),
                                alignment: Alignment.center,
                                child: Text(
                                  "公众号",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getSp(Dimens.sp26)),
                                ),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    //可以设置角度，BoxShape.circle直接圆形
                                    color: CommonUtil.getChaptersColor(position % 6)),
                              ),
                              Container(
                                width: getWidth(Dimens.dp170),
                                margin: EdgeInsets.only(
                                    top: getHeight(Dimens.dp16)),
                                alignment: Alignment.center,
                                child: Text(nab.data[position].name,
                                    style: TextStyle(
                                        color: CommonUtil.getChaptersColor(position % 6),
                                        fontSize: getSp(Dimens.sp26))),
                              )
                            ],
                          ),
                          onTap: () {
                            pushWidget(
                                widget._context,
                                BlocProvider(
                                    child: WxPublicList(
                                        nab.data[position].name,
                                        nab.data[position].id,
                                        CommonUtil.getChaptersColor(position % 6)),
                                    bloc: WxPublicListBloc()));
                          },
                        );
                      }),
                );
        });
  }
  ///==========热门项目=========
  Widget _getProjectWidget() {
    return StreamBuilder<List<NewListDataBean>>(
        stream: _bloc.projectStream,
        builder: (context, nbs) {
          if (nbs.data != null) {
            List<Widget> _list = nbs.data?.map((item) {
              return Container(
                child: HotProjectWidget(item,widget._context),
                padding: EdgeInsets.only(
                    top: getWidth(Dimens.dp15), bottom: getWidth(Dimens.dp15)),
                margin: EdgeInsets.only(
                    left: getWidth(Dimens.dp30), right: getWidth(Dimens.dp30)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colours.divider))),
              );
            })?.toList();
            return Column(
              children: _list,
            );
          }
          return Container();
        });
  }

  ///=======Mark 标注=====
  Widget _getConmmonWidget<T>(
      String markName, String markMore, Stream<T> stream, Function function) {
    return StreamBuilder<T>(
        stream: stream,
        builder: (context, nbs) {
          return nbs.data == null
              ? Container()
              : Container(
                  height: getHeight(Dimens.dp100),
                  padding: EdgeInsets.only(
                      left: getWidth(Dimens.dp30),
                      right: getWidth(Dimens.dp30)),
                  child: Row(
                    children: <Widget>[
                      Text(
                        markName,
                        style: TextStyle(
                            color: Colours.gray_33,
                            fontSize: getSp(Dimens.sp30),
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Text(
                            markMore,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: getSp(Dimens.sp30),
                            ),
                            textAlign: TextAlign.right,
                          ),
                          onTap: function,
                        ),
                      ),
                    ],
                  ),
                );
        });
  }
}
