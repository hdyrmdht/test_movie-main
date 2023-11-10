import 'package:flutter/cupertino.dart';

extension PaddingToWidget on Widget {


  Widget setPadding(BuildContext context,
      {bool enableMediaQuery = true, double vertical = 0,double horizontal = 0,}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: enableMediaQuery
              ? MediaQuery.of(context).size.height * vertical
              : vertical,
          horizontal: enableMediaQuery
              ? MediaQuery.of(context).size.width * horizontal
              : horizontal),
      child: this,
    );
  }

  Widget setOnlyPadding(BuildContext context,
      { double bottom = 0,double left = 0,double right = 0,double top = 0,bool enableMediaQuery = true}) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: enableMediaQuery
            ? MediaQuery.of(context).size.height * bottom
            : bottom,
          left: enableMediaQuery
              ? MediaQuery.of(context).size.height * left
              : left,
          right: enableMediaQuery
              ? MediaQuery.of(context).size.height * right
              : right,
          top: enableMediaQuery
              ? MediaQuery.of(context).size.height * top
              : top,),
      child: this,
    );
  }
}
