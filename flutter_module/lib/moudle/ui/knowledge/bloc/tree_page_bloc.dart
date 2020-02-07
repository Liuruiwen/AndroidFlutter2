import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ui/knowledge/bean/TreePageBean.dart';
import 'package:rxdart/subjects.dart';

import '../../../ApiConfirg.dart';

/**
 * Created by Amuser
 * Date:2020/1/6.
 * Desc:体系
 */
class TreePageBloc extends HttpBloc{


  BehaviorSubject<List<TreePageBean>> _treeList = BehaviorSubject<List<TreePageBean>>();
  Stream<List<TreePageBean>> get treeStream => _treeList.stream;
  BehaviorSubject<List<Children>> _childrenList = BehaviorSubject<List<Children>>();
  Stream<List<Children>> get childrenStream => _childrenList.stream;
  getTreeData() async {
    await getData<List<TreePageBean>>(
        ApiConfig.HTTP_TREE_LIST , (data) {
      List<TreePageBean> bean = data;
      if (bean != null && bean.length > 0) {
        addTreeList(bean);
      }
    });
    return;
  }

  addTreeList(List<TreePageBean> list){
    _treeList.add(list);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _treeList.close();
    _childrenList.close();

  }

  @override
  Future initData(BuildContext context) async{
    // TODO: implement initData
    showDialogs(context);
    await getTreeData();
    closeDialog(context);
  }

}