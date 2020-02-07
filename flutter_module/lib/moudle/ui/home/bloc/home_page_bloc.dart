import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/http/HttpBloc.dart';
import 'package:flutter_module/moudle/ApiConfirg.dart';
import 'package:flutter_module/moudle/ui/home/bean/BannerBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/ChaptersBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectListBean.dart';
import 'package:rxdart/subjects.dart';
/**
 * Created by Amuser
 * Date:2019/12/16.
 * Desc:
 */
class HomePageBloc extends HttpBloc {
  BehaviorSubject<List<BannerBean>> _banner =
      BehaviorSubject<List<BannerBean>>();

  Stream<List<BannerBean>> get bannerStream => _banner.stream;

  getBanner() async {
    await getData<List<BannerBean>>(ApiConfig.HTTP_BANNER, (data) {
      _banner.add(data);
    });

    return;
  }

  BehaviorSubject<List<ChaptersBean>> _chapter =
      BehaviorSubject<List<ChaptersBean>>();

  Stream<List<ChaptersBean>> get chapterStream => _chapter.stream;

  getChapter() async {
    await getData<List<ChaptersBean>>(ApiConfig.HTTP_WX_PUBLIC_LIST, (data) {
      _chapter.add(data);
    });
    return;
  }

  BehaviorSubject<List<NewListDataBean>> _projectList =
      BehaviorSubject<List<NewListDataBean>>();

  Stream<List<NewListDataBean>> get projectStream => _projectList.stream;

  getHotProject() async {
    await getData<HotProjectListBean>(
        ApiConfig.HTTP_HOT_PROJECT_LIST + "/1/json?cid=294", (data) {
          if(data!=null){
            HotProjectListBean bean = data;
            if (bean.datas != null && bean.datas.length > 0) {
              _projectList.add(bean.datas);
            }
          }

    });
    return;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _banner.close();
    _chapter.close();
    _projectList.close();

  }

  @override
  initData(BuildContext context) async {
    // TODO: implement initData
    showDialogs(context);
    await getBanner();
    await getChapter();
    await getHotProject();
    closeDialog(context);
  }
}
