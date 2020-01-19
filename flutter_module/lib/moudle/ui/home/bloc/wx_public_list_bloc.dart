import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectListBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/WxPublicListBean.dart';
import 'package:rxdart/subjects.dart';

import '../../../ApiConfirg.dart';

/**
 * Created by Amuser
 * Date:2019/12/22.
 * Desc:公众号列表
 */
class WxPublicListBloc extends HttpBloc {


  List<WxPublicItemBean> _listBean = new List();
  int _page = 1;
  bool isResult = true;

  //====================热门项目================
  ///数据存储
  BehaviorSubject<List<WxPublicItemBean>> _publicList = BehaviorSubject<List<WxPublicItemBean>>();
  Stream<List<WxPublicItemBean>> get publicStream => _publicList.stream;
  ///是否加载完成
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
    await getData<WxPublicListBean>(
        ApiConfig.HTTP_WX_PUBLIC_ITEM_LIST +
            "/$id/$_page/json", (data) {
      if (data != null) {
        WxPublicListBean bean = data;
        if (bean.datas != null && bean.datas.length > 0) {
          isResult = true;
          _listBean.addAll(bean.datas);
          _publicList.add(_listBean);
        } else {
          _isLoading.add(true);
          isResult = false;
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
    _publicList.close();
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
