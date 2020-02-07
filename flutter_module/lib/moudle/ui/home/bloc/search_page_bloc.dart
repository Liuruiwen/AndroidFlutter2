import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ui/home/bean/QueryListBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/SeachHotKeyBean.dart';
import 'package:rxdart/subjects.dart';

import '../../../ApiConfirg.dart';

/**
 * Created by Amuser
 * Date:2020/1/4.
 * Desc:
 */
class SearchPageBloc extends HttpBloc{


  BehaviorSubject<List<SeachHotKeyBean>> _searchList = BehaviorSubject<List<SeachHotKeyBean>>();
  Stream<List<SeachHotKeyBean>> get hotStream => _searchList.stream;
  getHotKeyData() async {
    await getData<List<SeachHotKeyBean>>(
        ApiConfig.HTTP_SEARCH_HOT_KEY , (data) {
      List<SeachHotKeyBean> bean = data;
      if (bean != null && bean.length > 0) {
        _searchList.add(bean);
      }
    });
    return;
  }


  List<QueryDataBean> _listBean = new List();
  int _page = 1;
  bool isResult = true;
  BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();
  Stream<bool> get loadingStream => _isLoading.stream;
  BehaviorSubject<List<QueryDataBean>> _queryList = BehaviorSubject<List<QueryDataBean>>();
  Stream<List<QueryDataBean>> get queryStream => _queryList.stream;
  getQueryData(String key,int type) async {
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
    await  postData<QueryListBean>(ApiConfig.HTTP_SEARCH_LIST+"${_page}/json", {
      "k": key,
    }, (data){
      if (data != null) {
        QueryListBean bean = data;
        if (bean.datas != null) {
          if(bean.datas.length>0){
            isResult = true;
            _listBean.addAll(bean.datas);
            _queryList.add(_listBean);
          }else{
            _isLoading.add(true);
            isResult = false;
          }
        }
      } else {
        isResult = false;
      }
    });
    return;
  }

  intiQueryData(String key,BuildContext context) async{
    showDialogs(context);
    await getQueryData(key, 1);
    closeDialog(context);
  }

  @override
  Future initData(BuildContext context)async {
    // TODO: implement initData
    showDialogs(context);
    await  getHotKeyData();
    closeDialog(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchList.close();
    _isLoading.close();
  }

}