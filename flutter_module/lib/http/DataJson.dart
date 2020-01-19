
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
 * Date:2019/10/21.
 * Desc:获得json解析实体
 */
 class DataJson{
  static T getDataJson<T>(data){
    switch(T.toString()){
      case "List<BannerBean>"://轮播图
        List<BannerBean> list=new List();
        data.forEach((v){
          list.add(BannerBean.fromJson(v));
        });
       return   list as T;
      case "List<ChaptersBean>"://公众号达人
        List<ChaptersBean> list=new List();
        data.forEach((v){
          list.add(ChaptersBean.fromJson(v));
        });
        return list as T;
      case "List<HotProjectBean>"://热门项目menu
        List<HotProjectBean> list=new List();
        data.forEach((v){
          list.add(HotProjectBean.fromJson(v));
        });
        return list as T;
      case "List<SeachHotKeyBean>"://搜索热词
        List<SeachHotKeyBean> list=new List();
        data.forEach((v){
          list.add(SeachHotKeyBean.fromJson(v));
        });
        return list as T;
      case "List<NaiBean>"://导航数据
        List<NaiBean> list=new List();
        data.forEach((v){
          list.add(NaiBean.fromJson(v));
        });
        return list as T;
      case "List<TreePageBean>"://体系数据
        List<TreePageBean> list=new List();
        data.forEach((v){
          list.add(TreePageBean.fromJson(v));
        });
        return list as T;
      case "HotProjectListBean"://热门项目列表
        return HotProjectListBean.fromJson(data) as T;
      case "WxPublicListBean"://微信公众号列表
        return WxPublicListBean.fromJson(data) as T;
      case "QueryListBean"://搜索列表
        return QueryListBean.fromJson(data) as T;
      case "LoginPageBean"://登录
        return LoginPageBean.fromJson(data) as T;
      case "TreeListPageBean"://体系文章列表
        return TreeListPageBean.fromJson(data) as T;
//      case "ChaptersData":
//        return ChaptersData.fromJson(data) as T;
    }
  }
 }