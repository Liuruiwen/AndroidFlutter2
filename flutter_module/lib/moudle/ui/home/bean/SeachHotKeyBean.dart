/**
 * Created by Amuser
 * Date:2019/12/18.
 * Desc:
 */
class SeachHotKeyBean {
  int id;
  String link;
  String name;
  int order;
  int visible;

  SeachHotKeyBean({this.id, this.link, this.name, this.order, this.visible});

  SeachHotKeyBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['order'] = this.order;
    data['visible'] = this.visible;
    return data;
  }
}