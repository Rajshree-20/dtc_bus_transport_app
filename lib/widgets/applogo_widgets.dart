import 'package:dtc/consts/consts.dart';
import 'package:flutter/material.dart';

Widget applogoWidget(){
  return Image.asset(appLogo).box.white.size(77,77).padding(const EdgeInsets.all(8.0)).rounded.shadow5xl.make();
}