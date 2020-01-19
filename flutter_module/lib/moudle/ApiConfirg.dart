/**
 * Created by Amuser
 * Date:2019/10/19.
 * Desc:api管理
 */
class ApiConfig {
  static String HTTP_BANNER = "banner/json"; //首页banner图
  static String HTTP_WX_PUBLIC_LIST = "wxarticle/chapters/json"; //微信公众号达人
  static String HTTP_HOT_PROJECT_MENU = "project/tree/json"; //热门项目菜单
  static String HTTP_HOT_PROJECT_LIST = "project/list"; //项目列表数据
  static String HTTP_WX_PUBLIC_ITEM_LIST="wxarticle/list";//公众号列表
  static String HTTP_SEARCH_HOT_KEY="/hotkey/json";//搜索热词
  static String HTTP_SEARCH_LIST="article/query/";//搜索关键字
  static String HTTP_NAI_LIST="navi/json";//导航数据
  static String HTTP_LOGIN="user/login";//登录
  static String HTTP_REGISTER="user/register";//注册
  static String HTTP_LOGIN_LOGIN_OUT="user/logout/json";//退出登录
  static String HTTP_TREE_LIST="tree/json";//体系
  static String HTTP_TREE_ARTICLE="article/list/";//体系下的文章
}
