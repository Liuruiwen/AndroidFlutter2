import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bloc/AppBloc.dart';
import 'bloc/BlocBase.dart';
import 'moudle/ui/main_page.dart';

void main() => runApp(BlocProvider(child: MyApp(), bloc: AppBloc()));

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }

}

class _MyApp extends State<MyApp>{
  AppBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc=BlocProvider.of<AppBloc>(context);
    _bloc.initData(context);
    _bloc.getMethodChannel().setMethodCallHandler(_handler);
  }

  ////接收android监听
  Future<dynamic> _handler(MethodCall call){
    switch (call.method) {
      default:
        setState(() {});
        _bloc.addMethodCall(call);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<AppCode>(
        stream: _bloc.themeStream,
        initialData: _bloc.getAppCode(),
        builder: (context,nab){
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: nab.data.appThemeColor,
            ),
            home: _getHomeWidget(window.defaultRouteName),
          );
        });

  }

  Widget _getHomeWidget(String route){
    switch (route){
      case "main":
        return MainPage();
      default:
        return MainPage();
    }
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
}

//class MyApps extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    AppBloc _bloc=BlocProvider.of<AppBloc>(context);
//    _bloc.initData(context);
//    return StreamBuilder<AppCode>(
//        stream: _bloc.themeStream,
//        initialData: _bloc.getAppCode(),
//        builder: (context,nab){
//          return MaterialApp(
//            title: 'Flutter Demo',
//            theme: ThemeData(
//              primarySwatch: nab.data.appThemeColor,
//            ),
//            home: _getHomeWidget(window.defaultRouteName),
//          );
//        });
//
//  }
//
//  Widget _getHomeWidget(String route){
//    switch (route){
//      case "main":
//        return MainPage();
//      default:
//        return MainPage();
//    }
//  }
//}

class  StateError extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("没有找到界面哦"),
      ),
    );
  }

}

