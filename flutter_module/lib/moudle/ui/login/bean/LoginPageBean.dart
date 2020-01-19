/**
 * Created by Amuser
 * Date:2020/1/10.
 * Desc:
 */
class LoginPageBean {
  bool admin;
  List<Null> chapterTops;
  List<int> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;
  String headImage;
  String openid;

  LoginPageBean(
      {this.admin,
        this.chapterTops,
        this.collectIds,
        this.email,
        this.icon,
        this.id,
        this.nickname,
        this.password,
        this.publicName,
        this.token,
        this.type,
        this.username,
        this.headImage,
        this.openid
      });

  LoginPageBean.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
//    if (json['chapterTops'] != null) {
//      chapterTops = new List<Null>();
//      json['chapterTops'].forEach((v) {
//        chapterTops.add(new Null.fromJson(v));
//      });
//    }
    collectIds = json['collectIds'].cast<int>();
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
    headImage = json['headImage'];
    openid = json['openid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
//    if (this.chapterTops != null) {
//      data['chapterTops'] = this.chapterTops.map((v) => v.toJson()).toList();
//    }
    data['collectIds'] = this.collectIds;
    data['email'] = this.email;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['publicName'] = this.publicName;
    data['token'] = this.token;
    data['type'] = this.type;
    data['username'] = this.username;
    data['headImage'] = this.headImage;
    data['openid'] = this.openid;
    return data;
  }
}