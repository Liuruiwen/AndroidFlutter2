import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/http/dialog/DialogWidget.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';
import 'package:flutter_module/moudle/base/PageStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/LoadingMoreToast.dart';
import 'package:flutter_module/moudle/base/widget/RefreshWidget.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectListBean.dart';
import 'package:flutter_module/moudle/ui/home/bloc/project_body_page_bloc.dart';
import 'package:flutter_module/moudle/ui/home/widget/hot_project_widget.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/Dimens.dart';

/**
 * Created by Amuser
 * Date:2019/12/24.
 * Desc:
 */
class ProjectBodyWidget extends BaseFulWidget {
  final int _cid;
  BuildContext _context;
  ProjectBodyWidget(this._cid,this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProjectBodyWidget();
  }
}

class _ProjectBodyWidget extends PageStateWidget<ProjectBodyWidget> {
  ProjectBodyPageBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<ProjectBodyPageBloc>(context);
    WidgetsBinding.instance
        .addPostFrameCallback((_) =>   _bloc.onRefresh(context,widget._cid));
  }


  @override
  Widget setBodyWidget(BuildContext context) {
    // TODO: implement setBodyWidget
    return _getProjectWidget();
  }


  Widget _getProjectWidget() {
    return StreamBuilder<List<NewListDataBean>>(
        stream: _bloc.projectStream,
        builder: (context, nbs) {
          if (nbs.data != null) {
            List<Widget> _ListWidget=nbs.data?.map((item){
              return _itemWidget(item);
            }).toList();
            if(_ListWidget.length>10){
              _ListWidget.add(LoadingMoreToast(_bloc.loadingStream));
            }

            return RefreshListView(_ListWidget,()async{
             await _onRefresh();
            },(ii)async{
              if(_ListWidget.length>10){
               await  _onLoading();
              }
            });
          }
          return  Container();
        });
  }

  Widget _itemWidget(NewListDataBean bean) {
    return Container(
      child: GestureDetector(
        child: HotProjectWidget(bean,context),
        onTap: (){

        },
      ),
      padding: EdgeInsets.only(
          top: getWidth(Dimens.dp15), bottom: getWidth(Dimens.dp15)),
      margin: EdgeInsets.only(
          left: getWidth(Dimens.dp30), right: getWidth(Dimens.dp30)),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colours.divider))),
    );
  }



  _onRefresh() async{
     await _bloc.getHotProject(1, widget._cid);
     return;
  }
  _onLoading() async{
    await _bloc.getHotProject(2, widget._cid);
  }
}


