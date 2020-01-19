import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_module/moudle/base/BaseFulWidget.dart';
import 'package:flutter_module/moudle/base/BaseStateWidget.dart';
import 'package:flutter_module/moudle/base/widget/WebPage.dart';
import 'package:flutter_module/moudle/ui/home/bean/HotProjectListBean.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/Dimens.dart';

/**
 * Created by Amuser
 * Date:2019/12/24.
 * Desc:热门项目widget
 */
class HotProjectWidget extends BaseFulWidget{
  NewListDataBean _dataBean;
  BuildContext _context;
  HotProjectWidget(this._dataBean,this._context);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HotProjectWidget();
  }

}

class _HotProjectWidget extends BaseStateWidget<HotProjectWidget>{

  @override
  Widget getBuildWidget(BuildContext buildContext) {
    // TODO: implement getBuildWidget
    return GestureDetector(
      child: _getProjectItem(widget._dataBean),
      onTap: (){
        pushWidget(widget._context,
            WebPage(widget._dataBean.envelopePic,widget._dataBean.title));
      },
    ) ;
  }


  Widget _getProjectItem(NewListDataBean bean) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
              height: getHeight(Dimens.dp260),
              child: Column(
                children: <Widget>[
                  new Align(
                    child: new Text(
                      bean.title,
                      style: TextStyle(
                        color: Colours.text_dark,
                        fontWeight: FontWeight.bold,
                        fontSize: getSp(Dimens.sp30),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: getHeight(Dimens.dp12)),
                        alignment: Alignment.topLeft,
                        child: new Text(
                          bean.desc,
                          style: TextStyle(
                            color: Colours.text_normal,
                            fontSize: getSp(Dimens.sp26),
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: getWidth(Dimens.dp12),
                            right: getWidth(Dimens.dp12)),
                        child: Text(bean.author,
                            style: TextStyle(
                              color: Colours.text_gray,
                              fontSize: getSp(Dimens.sp26),
                            )),
                      ),
                      Text(bean.niceDate,
                          style: TextStyle(
                            color: Colours.text_gray,
                            fontSize: getSp(Dimens.sp26),
                          )),
                    ],
                  ),
                ],
              ),
            )),
        new Image(
          image: new NetworkImage(bean.envelopePic),
          width: getWidth(Dimens.dp150),
          height: getHeight(Dimens.dp260),
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}