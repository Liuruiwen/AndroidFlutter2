import 'package:flutter/material.dart';
import 'package:flutter_module/res/Colours.dart';
import 'package:flutter_module/res/styles.dart';
/**
 * Created by Amuser
 * Date:2019/12/20.
 * Desc:
 */
class ChipsTitle extends StatelessWidget {
  const ChipsTitle({
    Key key,
    this.label,
    this.children,
  }) : super(key: key);

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> cardChildren = <Widget>[
      new Text(
        label,
        style: TextStyles.listTitle,
      ),
      Gaps.vGap10
    ];
    cardChildren.add(Wrap(
        children: children.map((Widget chip) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: chip,
          );
        }).toList()));

    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
      decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
              bottom: new BorderSide(width: 0.33, color: Colours.divider))),
    );
  }
}


