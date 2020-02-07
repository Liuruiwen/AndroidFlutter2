import 'package:json_annotation/json_annotation.dart';
/**
 * Created by Amuser
 * Date:2019/12/15.
 * Desc:
 */
@JsonSerializable()
class ChaptersBean {

  @JsonKey(name: 'children')
  List<dynamic> children;

  @JsonKey(name: 'courseId')
  int courseId;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'parentChapterId')
  int parentChapterId;

  @JsonKey(name: 'userControlSetTop')
  bool userControlSetTop;

  @JsonKey(name: 'visible')
  int visible;

  ChaptersBean(this.children,this.courseId,this.id,this.name,this.order,this.parentChapterId,this.userControlSetTop,this.visible,);

  factory ChaptersBean.fromJson(Map<String, dynamic> srcJson) => _$ChaptersDataFromJson(srcJson);

}



ChaptersBean _$ChaptersDataFromJson(Map<String, dynamic> json) {
  return ChaptersBean(
      json['children'] as List,
      json['courseId'] as int,
      json['id'] as int,
      json['name'] as String,
      json['order'] as int,
      json['parentChapterId'] as int,
      json['userControlSetTop'] as bool,
      json['visible'] as int);
}

Map<String, dynamic> _$DataToJson(ChaptersBean instance) => <String, dynamic>{
  'children': instance.children,
  'courseId': instance.courseId,
  'id': instance.id,
  'name': instance.name,
  'order': instance.order,
  'parentChapterId': instance.parentChapterId,
  'userControlSetTop': instance.userControlSetTop,
  'visible': instance.visible
};
