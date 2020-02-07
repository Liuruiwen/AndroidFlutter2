import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectBean.dart';
import 'package:flutter_module/moudle/ui/home/bloc/hot_project_page_bloc.dart';
import 'package:flutter_module/moudle/ui/home/project_body_page.dart';

import 'bloc/project_body_page_bloc.dart';

/**
 * Created by Amuser
 * Date:2019/12/18.
 * Desc:
 */
class HotProjectPage extends BaseFulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotProjectPage();
  }
}

class _HotProjectPage extends BaseStateWidget<HotProjectPage>
    with SingleTickerProviderStateMixin {
  HotProjectPageBloc _bloc;
  TabController _tabController = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bloc = BlocProvider.of<HotProjectPageBloc>(context);
    _bloc.getProjectMenu();
  }

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return _getBody();
  }

  Widget _getBody() {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: new Align(
            alignment: Alignment.center,
            child: new Icon(Icons.keyboard_arrow_left, size: 30),
          ),
          onTap: () {
            closeWidget();
          },
        ),
        title: Text("热门项目"),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<List<HotProjectBean>>(
            stream: _bloc.projectStream,
            builder: (context, nbs) {
              if (nbs.data != null) {
                if (_tabController == null) {
                  _tabController =
                      new TabController(length: nbs.data.length, vsync: this);
                }
                List<Widget> _list = nbs.data?.map((item) {
                  return new Tab(
                    child: Text(item.name),
                  );
                })?.toList();

                List<Widget> _listBody = nbs.data?.map((item) {
                  return BlocProvider(
                      child: ProjectBodyWidget(item.id, context),
                      bloc: ProjectBodyPageBloc());
                })?.toList();
                return Column(
                  children: <Widget>[
                    Container(
                      color: Colors.blue,
                      child: new TabBar(
                          controller: _tabController,
                          tabs: _list,
                          unselectedLabelColor: Colors.white30,
                          isScrollable: true,
                          labelColor: Colors.white,
                          labelStyle: TextStyle(fontSize: 18),
                          unselectedLabelStyle: TextStyle(fontSize: 15),
                          indicatorColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.label),
                    ),
                    Container(
                      height: 1,
                      color: Colors.blue,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Expanded(
                        child: TabBarView(
                            controller: _tabController, children: _listBody)),
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }
}
