import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/PageStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/WebPage.dart';
import 'package:flutter_module/moudle/ui/bean/WebBean.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_module/util/CommonUtil.dart';
import 'package:flutter_module/widget/LineWidget.dart';

import 'bean/NaiBean.dart';
import 'bloc/knowledge_page_bloc.dart';

/**
 * Created by Amuser
 * Date:2019/12/19.
 * Desc:
 */
class KnowledgePage extends BaseFulWidget {
  BuildContext _context;

  KnowledgePage(this._context);

  @override
  _KnowledgePage createState() {
    // TODO: implement createState
    return _KnowledgePage();
  }
}

class _KnowledgePage extends PageStateWidget<KnowledgePage> {
  KnowledgePageBloc _bloc;
  int _beforePosition = -1;
  List<Articles> _listChildren;
  AppBloc _appBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listChildren = new List();
    _appBloc = BlocProvider.of<AppBloc>(context);
    _bloc = BlocProvider.of<KnowledgePageBloc>(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.initData(widget._context));
  }

  @override
  Widget setBodyWidget(context) {
    // TODO: implement setBodyWidget
    return Column(
      children: <Widget>[
        getStateWidget(),
        Expanded(
          child: Row(
            children: <Widget>[
              _getBodyWidget(),
              Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder<List<Articles>>(
                        stream: _bloc.articlesStream,
                        builder: (context, nab) {
                          if (nab.data != null && nab.data.length > 0) {
                            return _getNaiList(nab.data);
                          }
                          return Container();
                        }),
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget _getBodyWidget() {
    return StreamBuilder<List<NaiBean>>(
        stream: _bloc.naiStream,
        builder: (context, nbs) {
          if (nbs.data != null) {
            return Container(
              width: getWidth(Dimens.dp160),
              child: _getListView(nbs.data),
            );
          }
          return Container();
        });
  }

  Widget _getListView(List<NaiBean> list) {
    return new ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: list.length,
      itemBuilder: (buildContext, position) {
        return new Column(
          children: <Widget>[
            new GestureDetector(
              child: new Container(
                child: new Center(
                  child: new Text(
                    list[position].name,
                    style: TextStyle(
                        color: list[position].selectType == 1
                            ? Colors.white
                            : Colours.text_normal),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                height: 60,
                decoration: BoxDecoration(
                  color: list[position].selectType == 1
                      ? Colors.blue
                      : Colors.white,
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  if (_beforePosition != position) {
                    _beforePosition =
                        _beforePosition == -1 ? 0 : _beforePosition;
                    list[_beforePosition].selectType = 0;
                    list[position].selectType = 1;
                    _beforePosition = position;
                    _bloc.getArticlesList(list[position].articles);
                  }
                });
              },
            ),
            new LineWidget(),
          ],
        );
      },
    );
  }

  Widget _getNaiList(List<Articles> list) {
    final List<Widget> chips = list.map<Widget>((Articles _model) {
      return new GestureDetector(
        child: Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          key: ValueKey<String>(_model.title),
          backgroundColor:
              CommonUtil.getChaptersColor(list.indexOf(_model) % 6),
          label: Text(
            _model.title,
            style: new TextStyle(
                fontSize: getSp(Dimens.sp26), color: Colors.white),
          ),
        ),
        behavior: HitTestBehavior.opaque,
        onTap: () {
          switch(window.defaultRouteName){
            case"main":
              _appBloc.getMethodChannel().invokeListMethod(
                  'web', getWebBean(WebBean(_model.link,_model.title)));
              break;
            default:
              pushWidget(widget._context,WebPage(_model.link,_model.title));
              break;
          }

        },
      );
    }).toList();
    return SingleChildScrollView(
      child: Wrap(
          children: chips.map((Widget chip) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(5,6,5,6),
          child: chip,
        );
      }).toList()),
    );
  }
}
