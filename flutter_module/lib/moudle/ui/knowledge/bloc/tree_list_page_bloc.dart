import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ui/knowledge/bean/TreeListPageBean.dart';
import 'package:rxdart/rxdart.dart';

import '../../../ApiConfirg.dart';

/**
 * Created by Amuser
 * Date:2020/1/15.
 * Desc:
 */
class TreeListPageBloc extends HttpBloc{

  List<TreeListPageData> _listBean = new List();
  int _page = 1;
  bool isResult = true;

  BehaviorSubject<List<TreeListPageData>> _treeList = BehaviorSubject<List<TreeListPageData>>();
  Stream<List<TreeListPageData>> get treeStream => _treeList.stream;
  BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();
  Stream<bool> get loadingStream => _isLoading.stream;

  getWxPublic(int type, int id) async {
    switch (type) {
      case 1:
        _isLoading.add(false);
        _page = 1;
        _listBean.clear();
        break;
      case 2:
        isResult == true ? _page++ : _page;
        break;
    }
    await getData<TreeListPageBean>(
        ApiConfig.HTTP_TREE_ARTICLE +
            "$_page/json?cid=$id", (data) {
      if (data != null) {
        TreeListPageBean bean = data;
        if (bean.datas != null) {
          if(bean.datas.length>0){
            isResult = true;
            _isLoading.add(false);
            _listBean.addAll(bean.datas);
            _treeList.add(_listBean);
          }else{
            isResult = false;
            _isLoading.add(true);
            _treeList.add(_listBean);
          }
        }
      } else {
        isResult = false;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_listBean != null) {
      _listBean.clear();
    }
    _treeList.close();
    _isLoading.close();
  }


  @override
  initData(BuildContext context) {
    // TODO: implement initData
  }

  onRefresh(BuildContext context,int cid) async{
    showDialogs(context);
    await getWxPublic(1, cid);
    closeDialog(context);
    return;
  }
}