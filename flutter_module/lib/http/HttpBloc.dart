import 'package:flutter/material.dart';
import 'package:flutter_module/bloc/BlocBase.dart';

import 'dialog/DialogWidget.dart';
import 'dio/HttpHelp.dart';

/**
 * Created by Amuser
 * Date:2019/12/10.
 * Desc:
 */
abstract class HttpBloc extends BlocBase {
  BuildContext mContext;

  getData<T>(String url, callBack(t),[bool isToast=false]) async {
    return await HttpHelp.getInstance().get<T>(url, null, (t) {
      callBack(t);
    }, (e) {
      callBack(null);
    },isToast);
  }

  postData<T>(String url, Map<String, dynamic> params, callBack(t),[bool isToast=false]) async {
    return await HttpHelp.getInstance().post<T>(url, params, (t) {
      callBack(t);
    }, (e) {
      callBack(null);
    },isToast);
  }

  postJsonData() {}

  @override
  void buildWidget(BuildContext context) {
    // TODO: implement buildWidget
    this.mContext = context;
  }

  showDialogs(BuildContext context) async {
    await showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new DialogWidget(text: "正在加载...");
        });
  }

  closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
