import 'package:flutter/material.dart';
import 'package:flutter_module/res/Dimens.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Created by Amuser
 * Date:2019/12/22.
 * Desc:
 */
class LoadingMoreToast extends  StatelessWidget{
  Stream<bool> _isLoading;
  LoadingMoreToast(this._isLoading);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
      return StreamBuilder<bool>(
        stream:_isLoading,
        builder: (context, nbs) {
          return nbs.data == false
              ? getBodyWidget()
              : Container(
            alignment: Alignment.center,
            height: ScreenUtil.getInstance().setHeight(Dimens.dp80),
            child: Text("没有更多数据了"),
          );
        });;
  }


  Widget getBodyWidget(){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            )
          ],
        ),
      ),
    );
  }

}