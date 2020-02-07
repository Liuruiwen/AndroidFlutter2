import 'package:flutter/material.dart';
import 'package:flutter_module/moudle/base/widget/EmptyPageWidget.dart';

/**
 * Created by Amuser
 * Date:2019/12/22.
 * Desc:
 */
typedef void onRefrsh();
typedef Future onLoading(double maxScrollExtent);
class RefreshListView extends StatefulWidget{
  List<Widget> _listWidget;
  onRefrsh _refrsh;
  onLoading _loading;


  RefreshListView(this._listWidget, this._refrsh, this._loading);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RefreshListView();
  }

}

class _RefreshListView extends State<RefreshListView>{
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refresh = new GlobalKey<
      RefreshIndicatorState>(); 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget._loading(_scrollController.position.pixels);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
       key: _refresh,
      onRefresh: widget._refrsh,
      child:widget._listWidget.length>0? ListView(
        controller: _scrollController,
        children: widget._listWidget,
      ):EmptyPageWidget(),
    );
  }

}