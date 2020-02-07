import 'DataJson.dart';
/**
 * Created by Amuser
 * Date:2019/12/10.
 * Desc:
 */
class BaseBean<T> {
  int errorCode;
  String errorMsg;
  T data;

  BaseBean(this.errorCode, this.errorMsg, this.data);

  BaseBean.fromJson(Map<String, dynamic> json){
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    data = json['data']==null?null:DataJson.getDataJson(json['data']);
  }
}