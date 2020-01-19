/**
 * Created by Amuser
 * Date:2020/1/18.
 * Desc:
 */
class TXBean {
  String headImage;
  String name;
  String openid;

  TXBean({this.headImage, this.name});

  TXBean.fromJson(Map<String, dynamic> json) {
    headImage = json['headImage'];
    name = json['name'];
    openid = json['openid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headImage'] = this.headImage;
    data['name'] = this.name;
    data['openid'] = this.openid;
    return data;
  }
}