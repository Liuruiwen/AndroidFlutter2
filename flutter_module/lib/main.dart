import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bloc/AppBloc.dart';
import 'bloc/BlocBase.dart';
import 'moudle/ui/main_page.dart';

void main() => runApp(getMainWidget(window.defaultRouteName));

Widget getMainWidget(String route){
  switch (route){
    case "main":
      return BlocProvider(child: MainApp(), bloc: AppBloc());
    default:
      return MyApp();
  }
}
class MainApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainApp();
  }

}

class _MainApp extends State<MainApp>{
  AppBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc=BlocProvider.of<AppBloc>(context);
    _bloc.initData(context);
    _bloc.getMethodChannel().setMethodCallHandler(_handler);
  }

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
            home:MainPage(),
          );
        });

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


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(child: Text("测试"),),
    );
  }


}

