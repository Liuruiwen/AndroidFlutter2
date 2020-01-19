import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ui/knowledge/bean/NaiBean.dart';
import 'package:rxdart/subjects.dart';

import '../../../ApiConfirg.dart';

/**
 * Created by Amuser
 * Date:2020/1/6.
 * Desc:
 */
class KnowledgePageBloc extends HttpBloc{


  //====================导航数据================
  ///数据存储
  BehaviorSubject<List<NaiBean>> _naiList = BehaviorSubject<List<NaiBean>>();
  Stream<List<NaiBean>> get naiStream => _naiList.stream;
  ///导航数据列表
  BehaviorSubject<List<Articles>> _articlesList = BehaviorSubject<List<Articles>>();
  Stream<List<Articles>> get articlesStream => _articlesList.stream;
  getNaiData() async {
    await getData<List<NaiBean>>(
        ApiConfig.HTTP_NAI_LIST , (data) {
      List<NaiBean> bean = data;
      if (bean != null && bean.length > 0) {
        bean[0].selectType=1;
        getArticlesList(bean[0].articles);
        _naiList.add(bean);
      }
    });
    return;
  }

  getArticlesList(List<Articles> list){
    _articlesList.add(list);
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  Future initData(BuildContext context) async{
    // TODO: implement initData
    showDialogs(context);
    await getNaiData();
    closeDialog(context);
  }

}