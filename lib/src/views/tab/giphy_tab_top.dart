import 'package:flutter/material.dart';
import 'package:giphy_get/src/theme/giphy_tab_top_style.dart';

class GiphyTabTop extends StatefulWidget {
  GiphyTabTop({Key? key}) : super(key: key);

  @override
  State<GiphyTabTop> createState() => _GiphyTabTopState();
}

class _GiphyTabTopState extends State<GiphyTabTop> {
  @override
  Widget build(BuildContext context) {
    final GiphyTabTopStyle? overrideStyle =
        Theme.of(context).extension<GiphyTabTopStyle>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: 50,
      height: 2,
      color: overrideStyle?.lineColor ??
          Theme.of(context).textTheme.bodyText1!.color!,
    );
  }
}
