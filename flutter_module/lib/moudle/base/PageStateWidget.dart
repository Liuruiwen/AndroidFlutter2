import 'package:flutter/material.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';

import 'BaseFulWidget.dart';

/**
 * Created by Amuser
 * Date:2019/12/14.
 * Desc:
 */
class  PageStateWidget<T extends BaseFulWidget> extends BaseStateWidget<T> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screen(context);
    return Scaffold(
      body:setBodyWidget(context),
    );
  }



  Widget setBodyWidget(BuildContext context){
    return Center(child: Text("你还没有写widget"),);
  }

}