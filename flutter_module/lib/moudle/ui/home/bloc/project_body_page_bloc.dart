import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectListBean.dart';
import 'package:rxdart/subjects.dart';

import '../../../ApiConfirg.dart';

/**
 * Created by Amuser
 * Date:2019/12/16.
 * Desc:
 */
class ProjectBodyPageBloc extends HttpBloc {

  List<NewListDataBean> _listBean = new List();
  int _page = 1;
  bool isResult = true;

  BehaviorSubject<List<NewListDataBean>> _projectList =
      BehaviorSubject<List<NewListDataBean>>();

  Stream<List<NewListDataBean>> get projectStream => _projectList.stream;

  BehaviorSubject<bool> _isLoading = BehaviorSubject<bool>();

  Stream<bool> get loadingStream => _isLoading.stream;

  getHotProject(int type, int id) async {
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
    await getData<HotProjectListBean>(
        ApiConfig.HTTP_HOT_PROJECT_LIST +
            "/" +
            _page.toString() +
            "/json?cid=$id", (data) {
      if (data != null) {
        HotProjectListBean bean = data;
        if (bean.datas != null) {
          if(bean.datas.length>0){
            isResult = true;
            _listBean.addAll(bean.datas);
            _projectList.add(_listBean);
          }else{
            _isLoading.add(true);
            isResult = false;
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
    _projectList.close();
    _isLoading.close();
  }


  @override
 initData(BuildContext context) {
    // TODO: implement initData
  }

  onRefresh(BuildContext context,int cid) async{
    showDialogs(context);
    await getHotProject(1, cid);
    closeDialog(context);
    return;
  }

}
