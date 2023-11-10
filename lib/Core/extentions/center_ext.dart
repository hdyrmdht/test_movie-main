import 'package:flutter/cupertino.dart';

extension CenterToWidget on Widget{
  Widget setCenter(){
    return Center(
      child: this,
    );
  }
}