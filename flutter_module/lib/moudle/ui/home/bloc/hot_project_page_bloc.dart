import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectBean.dart';
import 'package:rxdart/subjects.dart';

import '../../../ApiConfirg.dart';

/**
 * Created by Amuser
 * Date:2019/12/16.
 * Desc:
 */
class HotProjectPageBloc extends HttpBloc{


  BehaviorSubject<List<HotProjectBean>>  _project=BehaviorSubject<List<HotProjectBean>>();
  Stream<List<HotProjectBean>> get  projectStream=>_project.stream;
  getProjectMenu()async{
    await getData<List<HotProjectBean>>(ApiConfig.HTTP_HOT_PROJECT_MENU, (data){
      _project.add(data);
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _project.close();
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  Future initData(BuildContext context) {
    // TODO: implement initData
    return null;
  }

}