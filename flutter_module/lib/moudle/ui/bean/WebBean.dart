/**
 * Created by Amuser
 * Date:2020/4/12.
 * Desc:
 */
class WebBean{
  String url;
  String title;

  WebBean(this.url, this.title);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}