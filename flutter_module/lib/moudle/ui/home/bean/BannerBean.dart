import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Amuser
 * Date:2019/12/15.
 * Desc:
 */
@JsonSerializable()
class BannerBean  {

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'imagePath')
  String imagePath;

  @JsonKey(name: 'isVisible')
  int isVisible;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'type')
  int type;

  @JsonKey(name: 'url')
  String url;

  BannerBean(this.desc,this.id,this.imagePath,this.isVisible,this.order,this.title,this.type,this.url,);

  factory BannerBean.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

}

//BannerBean _$BannerBeanFromJson(Map<String, dynamic> json) {
//  return BannerBean(
//      (json['data'] as List)
//          .map((e) => Data.fromJson(e as Map<String, dynamic>))
//          .toList(),
//      json['errorCode'] as int,
//      json['errorMsg'] as String);
//}
//
//Map<String, dynamic> _$TestBeanToJson(BannerBean instance) => <String, dynamic>{
//  'data': instance.data,
//  'errorCode': instance.errorCode,
//  'errorMsg': instance.errorMsg
//};

BannerBean _$DataFromJson(Map<String, dynamic> json) {
  return BannerBean(
      json['desc'] as String,
      json['id'] as int,
      json['imagePath'] as String,
      json['isVisible'] as int,
      json['order'] as int,
      json['title'] as String,
      json['type'] as int,
      json['url'] as String);
}

Map<String, dynamic> _$DataToJson(BannerBean instance) => <String, dynamic>{
  'desc': instance.desc,
  'id': instance.id,
  'imagePath': instance.imagePath,
  'isVisible': instance.isVisible,
  'order': instance.order,
  'title': instance.title,
  'type': instance.type,
  'url': instance.url
};

