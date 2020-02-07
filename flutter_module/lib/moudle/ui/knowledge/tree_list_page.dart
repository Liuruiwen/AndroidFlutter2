import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/LoadingMoreToast.dart';
import 'package:flutter_module/moudle/base/widget/RefreshWidget.dart';
import 'package:flutter_module/moudle/base/widget/WebPage.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/Dimens.dart';

import 'bean/TreeListPageBean.dart';
import 'bloc/tree_list_page_bloc.dart';



/**
 * Created by Amuser
 * Date:2019/12/30.
 * Desc:体系文章列表
 */
class TreeListPage extends BaseFulWidget {
  final String _title;
  final int _id;
  final Color _color;

  TreeListPage(this._title, this._id, this._color);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TreeListPage();
  }
}

class _TreeListPage extends BaseStateWidget<TreeListPage> {
  TreeListPageBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<TreeListPageBloc>(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.onRefresh(context, widget._id));
  }

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: new Align(
            alignment: Alignment.center,
            child: new Icon(Icons.keyboard_arrow_left, size: 30),
          ),
          onTap: () {
            closeWidget();
          },
        ),
        title: new Text(widget._title),
        centerTitle: true,
        backgroundColor: widget._color,
      ),
      body: setBodyWidget(context),
    );
  }

  Widget setBodyWidget(BuildContext buildContext) {
    return StreamBuilder<List<TreeListPageData>>(
        stream: _bloc.treeStream,
        builder: (context, nbs) {
          if (nbs.data != null) {
            List<Widget> _ListWidget = nbs.data?.map((item) {
              return Container(
                child:GestureDetector(
                  child:  getItem(item),
                  onTap: (){
                    pushWidget(context,WebPage(item.link,item.title));
                  },
                ),
                padding: EdgeInsets.only(
                    top: getWidth(Dimens.dp15), bottom: getWidth(Dimens.dp15)),
                margin: EdgeInsets.only(
                    left: getWidth(Dimens.dp30), right: getWidth(Dimens.dp30)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colours.divider))),
              );
            }).toList();
            if (_ListWidget != null&& nbs.data.length>=10) {
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

          return Container();
        });
  }

  @override
  String getTitle() {
    // TODO: implement getTitle
    return widget._title;
  }

  Widget getItem(TreeListPageData bean) {
    return Row(
      children: <Widget>[
        Container(
            width: getWidth(Dimens.dp120),
            height: getHeight(Dimens.dp120),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: getWidth(Dimens.dp10), right: getWidth(Dimens.dp10)),
            child: Text(
              "${bean.superChapterName}",
              style:
              TextStyle(color: Colors.white, fontSize: getSp(Dimens.sp26)),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //可以设置角度，BoxShape.circle直接圆形
              color: widget._color,
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
                    Container(height: getHeight(Dimens.dp20),),
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
    await _bloc.getWxPublic(1, widget._id);
    return;
  }

  _onLoading() async {
    await _bloc.getWxPublic(2, widget._id);
  }
}
