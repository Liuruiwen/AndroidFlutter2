import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/ChipsTitle.dart';
import 'package:flutter_module/moudle/base/widget/LoadingMoreToast.dart';
import 'package:flutter_module/moudle/base/widget/RefreshWidget.dart';
import 'package:flutter_module/moudle/base/widget/WebPage.dart';
import 'package:flutter_module/moudle/ui/bean/WebBean.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_module/util/CommonUtil.dart';

import 'bean/QueryListBean.dart';
import 'bean/SeachHotKeyBean.dart';
import 'bloc/search_page_bloc.dart';

/**
 * Created by Amuser
 * Date:2020/1/5.
 * Desc:
 */
class SearchPage extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchPage();
  }
}

class _SearchPage extends BaseStateWidget<SearchPage> {
  final TextEditingController _etControllerSearch = TextEditingController();
  SearchPageBloc _bloc;
  String  _keywords;
  AppBloc _appBloc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<SearchPageBloc>(context);
    _appBloc = BlocProvider.of<AppBloc>(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.initData(context));
  }

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _getBorderText(),
        leading: GestureDetector(
          child: Center(
            child: new Icon(Icons.keyboard_arrow_left, size: 30),
          ),
          onTap: () {
            closeWidget();
          },
        ),
        centerTitle: true,
      ),
      body: _getBody(),
    );
  }

  Widget _getBody() {
      return StreamBuilder<List<QueryDataBean>>(
        stream: _bloc.queryStream,
        builder: (context, nbs) {
          if (nbs.data != null) {
            List<Widget> _ListWidget = nbs.data?.map((item) {
              return Container(
                child: GestureDetector(child: getItem(item),onTap: (){

                  switch(window.defaultRouteName){
                    case"main":
                      _appBloc.getMethodChannel().invokeListMethod(
                          'web', getWebBean(WebBean(item.link,item.title)));
                      break;
                    default:
                      pushWidget(context,WebPage(item.link,item.title));
                      break;
                  }


                },),
                padding: EdgeInsets.only(
                    top: getWidth(Dimens.dp15), bottom: getWidth(Dimens.dp15)),
                margin: EdgeInsets.only(
                    left: getWidth(Dimens.dp30), right: getWidth(Dimens.dp30)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colours.divider))),
              );
            }).toList();
            if (_ListWidget != null && _ListWidget.length > 10) {
              _ListWidget.add(Container(
                child:  LoadingMoreToast(_bloc.loadingStream),
              ));
            }

            return RefreshListView(_ListWidget, () async {
              await _onRefresh();
            }, (ii) async {
              if (_ListWidget.length > 10) {
                await _onLoading();
              }
            });
          }

          return _getHotKey();
        });
  }

  Widget _getHotKey() {
    return StreamBuilder<List<SeachHotKeyBean>>(
        stream: _bloc.hotStream,
        builder: (context, nbs) {
          return nbs.data == null
              ? Container()
              : Container(
                  child: _getHotItem(nbs.data),
                  color: Colors.white,
                );
        });
  }

  Widget _getTextField() {
    return new TextField(
      controller: _etControllerSearch,
      autocorrect: true,
      //是否自动更正
      autofocus: true,
      //是否自动对焦
      obscureText: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          //输入框decoration属性
          contentPadding: new EdgeInsets.only(left: 0.0),
          border: InputBorder.none,
          hintText: "请输入要搜索的关键字",
          hintStyle: new TextStyle(fontSize: 14, color: Colours.divider)),
      //文本对齐方式
      style: TextStyle(fontSize: getSp(Dimens.sp26), color: Colors.blue),
      //输入文本的样式
      onSubmitted: (text) {
          if(text.isNotEmpty){
            _keywords=text;
            _bloc.intiQueryData(_keywords, context);
          }
      },
    );
  }

  Widget _getHotItem(List<SeachHotKeyBean> list) {
    final List<Widget> chips = list.map<Widget>((SeachHotKeyBean _model) {
      return new GestureDetector(
        child: Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          key: ValueKey<String>(_model.name),
          backgroundColor:CommonUtil.getChaptersColor(list.indexOf(_model) % 6),
          label: Text(
            _model.name,
            style: new TextStyle(
                fontSize: getSp(Dimens.sp26), color: Colors.white),
          ),
        ),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _keywords=_model.name;
          _bloc.intiQueryData(_keywords, context);
        },
      );
    }).toList();
    return new ChipsTitle(
      label: "搜索热词",
      children: chips,
    );
  }

  Widget _getBorderText() {
    return Container(
      //修饰黑色背景与圆角
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0), //灰色的一层边框
        color: Colors.white,
        borderRadius: new BorderRadius.all(new Radius.circular(30.0)),
      ),
      alignment: Alignment.center,
      height: getHeight(Dimens.dp60),
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 10, 0),
      child: new Stack(
        children: <Widget>[
          new Container(
            child: new Center(
              child: new Icon(
                Icons.search,
                size: 20,
                color: Colors.blue,
              ),
            ),
            padding: EdgeInsets.only(left: 15),
            width: getWidth(Dimens.dp60),
          ),
          new Center(
              child: new Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: _getTextField(),
          ))
        ],
      ),
    );
  }

  Widget getItem(QueryDataBean bean) {
    return Row(
      children: <Widget>[
        Container(
            width: getWidth(Dimens.dp120),
            height: getHeight(Dimens.dp120),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: getWidth(Dimens.dp10), right: getWidth(Dimens.dp10)),
            child: Text(
              "${bean.chapterName}",
              style:
              TextStyle(color: Colors.white, fontSize: getSp(Dimens.sp26)),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //可以设置角度，BoxShape.circle直接圆形
              color: Colors.blue,
            )),
        Expanded(
            child: Container(
                margin: EdgeInsets.only(left: getWidth(Dimens.dp20)),
                height: getHeight(Dimens.dp120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Align(
                      child: new Text(
                        bean.title,
                        style: TextStyle(
                          color: Colours.text_dark,
                          fontWeight: FontWeight.bold,
                          fontSize: getSp(Dimens.sp26),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    Row(
                      children: <Widget>[
                        new Text(
                          "${bean.author}",
                          style: TextStyle(
                            color: Colours.text_normal,
                            fontSize: getSp(Dimens.sp24),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(child: new Text(
                          "${bean.niceDate}",
                          style: TextStyle(
                            color: Colours.text_normal,
                            fontSize: getSp(Dimens.sp24),
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ],
                )))
      ],
    );
  }

  _onRefresh() async {
    await _bloc.getQueryData(_keywords,1);
    return;
  }

  _onLoading() async {
    await _bloc.getQueryData(_keywords,2);
  }
}
