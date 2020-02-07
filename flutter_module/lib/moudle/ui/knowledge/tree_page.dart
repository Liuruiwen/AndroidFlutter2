import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_module/Common.dart';
import 'package:flutter_module/bloc/BlocBase.dart';

import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/PageStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/scroll_header/widgets/sliver_sticky_header.dart';
import 'package:flutter_module/moudle/ui/knowledge/bloc/tree_list_page_bloc.dart';
import 'package:flutter_module/moudle/ui/knowledge/bloc/tree_page_bloc.dart';
import 'package:flutter_module/moudle/ui/knowledge/tree_list_page.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/util/CommonUtil.dart';

import 'bean/TreePageBean.dart';

/**
 * Created by Amuser
 * Date:2020/1/13.
 * Desc:体系
 */
class TreePage extends BaseFulWidget {
  BuildContext _context;

  TreePage(this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TreePage();
  }


}

class _TreePage extends PageStateWidget<TreePage> {
  TreePageBloc _bloc;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<TreePageBloc>(context);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.initData(widget._context));
  }

  @override
  Widget setBodyWidget(context) {
    // TODO: implement setBodyWidget
    return StreamBuilder<List<TreePageBean>>(
        stream: _bloc.treeStream,
        builder: (context,nbs){
          return nbs.data==null?Container():
          new CustomScrollView(
            slivers: _buildSlivers(nbs.data),
          );
        });
  }


  List<Widget> _buildSlivers(List<TreePageBean> list) {
    List<Widget> slivers = new List<Widget>();
    slivers.add( SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: _SliverAppBarDelegate (
          minHeight:  MediaQueryData.fromWindow(window).padding.top, //收起的高度
          maxHeight:  MediaQueryData.fromWindow(window).padding.top, //展开的最大高度
          child: getStateWidget(),
    )));
    slivers.addAll(_buildHeaderBuilderLists(list));
    return slivers;
  }





  List<Widget> _buildHeaderBuilderLists(List<TreePageBean> list) {
    return list?.map((item) {
         return SliverStickyHeaderBuilder(
           builder: (context,state)=>_buildAnimatedHeader(list.indexOf(item),item.name),
           sliver: new SliverList(
             delegate: new SliverChildBuilderDelegate(
                   (context, i) {
                     Color _color=CommonUtil.getChaptersColor(list.indexOf(item)%6);
                 return   GestureDetector(
                      child: Container(
                        child: Text(item.children[i].name,style: TextStyle(color: _color),),
                        decoration: BoxDecoration(
                            border:Border(bottom:BorderSide(width: 1,color:  Colours.gray_line) )
                        ),
                        padding: EdgeInsets.only(top:getWidth(30),bottom:getWidth(30)),
                        margin: EdgeInsets.only(left:getWidth(50),right: getWidth(30) ),
                      ),
                      onTap: (){
                        pushWidget(widget._context, BlocProvider(child: TreeListPage(item.children[i].name,item.children[i].id,Colors.blue), bloc: TreeListPageBloc()));
                      },
                    );},
               childCount:item.children.length,
             ),
           ),
         );
    }).toList();
  }
  Widget _buildAnimatedHeader(int count, String name) {
    return  new Container(
        height: 60.0,
        color: CommonUtil.getChaptersColor(count%6),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        alignment: Alignment.centerLeft,
        child: new Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
    );
  }

}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}