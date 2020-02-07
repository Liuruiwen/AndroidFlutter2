
import 'package:flutter_module/moudle/ui/home/bean/BannerBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/ChaptersBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectListBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/QueryListBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/SeachHotKeyBean.dart';
import 'package:flutter_module/moudle/ui/home/bean/WxPublicListBean.dart';
import 'package:flutter_module/moudle/ui/knowledge/bean/NaiBean.dart';
import 'package:flutter_module/moudle/ui/knowledge/bean/TreeListPageBean.dart';
import 'package:flutter_module/moudle/ui/knowledge/bean/TreePageBean.dart';
import 'package:flutter_module/moudle/ui/login/bean/LoginPageBean.dart';
/**
 * Created by Amuser
 * Date:2019/12/10.
 * Desc:
 */
 class DataJson{
  static T getDataJson<T>(data){
    switch(T.toString()){
      case "List<BannerBean>":
        List<BannerBean> list=new List();
        data.forEach((v){
          list.add(BannerBean.fromJson(v));
        });
       return   list as T;
      case "List<ChaptersBean>":
        List<ChaptersBean> list=new List();
        data.forEach((v){
          list.add(ChaptersBean.fromJson(v));
        });
        return list as T;
      case "List<HotProjectBean>":
        List<HotProjectBean> list=new List();
        data.forEach((v){
          list.add(HotProjectBean.fromJson(v));
        });
        return list as T;
      case "List<SeachHotKeyBean>":
        List<SeachHotKeyBean> list=new List();
        data.forEach((v){
          list.add(SeachHotKeyBean.fromJson(v));
        });
        return list as T;
      case "List<NaiBean>":
        List<NaiBean> list=new List();
        data.forEach((v){
          list.add(NaiBean.fromJson(v));
        });
        return list as T;
      case "List<TreePageBean>":
        List<TreePageBean> list=new List();
        data.forEach((v){
          list.add(TreePageBean.fromJson(v));
        });
        return list as T;
      case "HotProjectListBean":
        return HotProjectListBean.fromJson(data) as T;
      case "WxPublicListBean":
        return WxPublicListBean.fromJson(data) as T;
      case "QueryListBean":
        return QueryListBean.fromJson(data) as T;
      case "LoginPageBean":
        return LoginPageBean.fromJson(data) as T;
      case "TreeListPageBean":
        return TreeListPageBean.fromJson(data) as T;
    }
  }
 }