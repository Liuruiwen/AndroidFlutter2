import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/ui/home/bloc/home_page_bloc.dart';
import 'package:flutter_module/moudle/ui/home/home_page.dart';
import 'package:flutter_module/moudle/ui/knowledge/bloc/tree_page_bloc.dart';
import 'package:flutter_module/moudle/ui/knowledge/knowledge_page.dart';
import 'package:flutter_module/moudle/ui/person/person_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'knowledge/bloc/knowledge_page_bloc.dart';
import 'knowledge/tree_page.dart';


/**
 * Created by Amuser
 * Date:2019/12/13.
 * Desc:首页
 */

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }
  
}

class _MainPage extends State<MainPage> with WidgetsBindingObserver{
  int _currentIndex;
  PageController _controller;
  bool isShow=false;
  AppBloc _appBloc;
  DateTime lastPopTime; //上次点击时间
  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _controller = PageController(initialPage: _currentIndex);
    WidgetsBinding.instance.addObserver(this);
    _appBloc = BlocProvider.of<AppBloc>(context);
  }

 
  void showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white);
  }




  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    isMainWidget(false);
    print("当前状态是======flase");
  }

  void isMainWidget(bool isMain){
    _appBloc.getMethodChannel().invokeListMethod(
        'bool_main', isMain);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
      print("我在前台了哦===========");
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        print("现在退到了后台哦===========");
        break;
      case AppLifecycleState.detached:
        break;
    }

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context){
    return getBackWidget( Scaffold(
      body:_getPageView(context),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: getItems(),
        currentIndex: _currentIndex,
        onTap: onTap,
      ),
    ));

  }

  Widget getBackWidget(Widget widget){
    return WillPopScope(
        onWillPop: ()  async{
          // 点击返回键的操作
          if(lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)){
            lastPopTime = DateTime.now();
            showToast("再按一次退出");
          }else{
            lastPopTime = DateTime.now();
            // 退出app
            isMainWidget(true);
          }
    },child: widget );
  }



  Widget _getPageView(BuildContext context){
    return new PageView(
      physics: NeverScrollableScrollPhysics(),//viewPage禁止左右滑动
      onPageChanged: _pageChange,
      controller: _controller,
      children: <Widget>[
         Offstage(
          offstage: _currentIndex != 0,
          child:  TickerMode(
            enabled: _currentIndex == 0,
            child:  MaterialApp(
              home: BlocProvider(child:  HomePage(context), bloc: HomePageBloc()),
            ),
          ),
        ),
         Offstage(
          offstage: _currentIndex != 1,
          child:  TickerMode(
            enabled: _currentIndex == 1,
            child:  MaterialApp(
              home:  BlocProvider(child: KnowledgePage(context), bloc: KnowledgePageBloc()),
            ),
          ),
        ),
        Offstage(
          offstage: _currentIndex != 2,
          child:  TickerMode(
            enabled: _currentIndex ==2,
            child:  MaterialApp(
              home:  BlocProvider(child: TreePage(context), bloc: TreePageBloc()),
            ),
          ),
        ),
         Offstage(
          offstage: _currentIndex != 3,
          child:  TickerMode(
            enabled: _currentIndex == 3,
            child:  MaterialApp(
              home:  PersonPage(context),
//              home:  LoginPage(),
            ),
          ),
        ),
      ],);
  }
  List<BottomNavigationBarItem> getItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
      BottomNavigationBarItem(icon: Icon(Icons.school), title: Text("学识")),
      BottomNavigationBarItem(icon: Icon(Icons.book), title: Text("体系")),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
    ];
  }


  Widget _getItemWidget(Widget widget){
    return MaterialApp(
      home: widget,
    );
  }

  void onTap(int index) {
    _controller.jumpToPage(index);
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
//        print("==="+index.toString());
        _currentIndex = index;
      });
    }
  }
}