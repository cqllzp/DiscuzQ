import 'package:discuzq/ui/ui.dart';
import 'package:flutter/material.dart';

class DiscuzFormContainer extends StatelessWidget {
  final Widget child;

  DiscuzFormContainer({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: DiscuzApp.themeOf(context).backgroundColor),

      /// SingleChildScrollView 防止设备不同的情况下，overflow渲染错误
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
