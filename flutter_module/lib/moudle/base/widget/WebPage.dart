import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/bloc/AppBloc.dart';
import 'package:flutter_module/bloc/BlocBase.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:convert' as convert;
/**
 * Created by Amuser
 * Date:2020/1/7.
 * Desc:
 */

class WebPage extends BaseFulWidget{
  String _url;
  String _tilte;
  WebPage(this._url,this._tilte);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WebPage();
  }

}

class _WebPage extends BaseStateWidget<WebPage>{
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  String _title="";
  StreamSubscription<WebViewStateChanged> onStateChanged;
  AppBloc _appBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appBloc=BlocProvider.of<AppBloc>(context);
    onStateChanged = flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state){
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
      switch (state.type) {
        case WebViewState.shouldStart:// 准备加载

          break;
        case WebViewState.startLoad:// 开始加载
          break;
        case WebViewState.finishLoad:// 加载完成
             flutterWebViewPlugin.evalJavascript("document.title").then((result){
               setState(() {
                 if(result!='""'){
                   _title = result.substring(1,result.length-1);
                 }else{
                   _title=widget._tilte;
                 }

               });
             });
          break;
        case WebViewState.abortLoad:
          // TODO: Handle this case.
          break;
      }
    });
  }

  final Set<JavascriptChannel> jsChannels = [
    JavascriptChannel(
        name: 'Print',
        onMessageReceived: (JavascriptMessage message) {
          print(message.message);
        }),
  ].toSet();

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return WebviewScaffold(
        url: widget._url,
        javascriptChannels: jsChannels,
        mediaPlaybackRequiresUserGesture: false,
        appBar: AppBar(
        title:  Text(_title),
          centerTitle: true,
          actions: <Widget>[
           GestureDetector(
             child:  Container(
               alignment: Alignment.center,
                 padding: EdgeInsets.all(getWidth(Dimens.dp20)),
                 child: Text("分享",style: TextStyle(color: Colors.white),)
             ),
             onTap: (){
               ShareBean bean=ShareBean(title:_title,content:"Flutter 调原生分享",
                   image:"https://avatars3.githubusercontent.com/u/38060954?s=460&v=4",
                   link:widget._url);
               _appBloc.getMethodChannel().invokeMethod("share",convert.jsonEncode(bean.toJson()));
             },
           )
          ],
    ),
    withZoom: true,
    withLocalStorage: true,
    hidden: true,
    initialChild:Container(
      alignment: Alignment.center,
    height: MediaQuery.of(context).size.height,
    child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中... ',
              style: TextStyle(fontSize: getSp(Dimens.sp26)),
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            )
          ],
        ),
      ),
    );
  }

}

class ShareBean {
  String title;
  String content;
  String image;
  String link;


  ShareBean({this.title, this.content,this.image,this.link});

  ShareBean.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}