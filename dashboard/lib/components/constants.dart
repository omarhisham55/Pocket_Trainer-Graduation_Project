


import 'package:flutter/material.dart';

double width(context, double? newWidth){
  return MediaQuery.of(context).size.width * newWidth!;
}
double height(context, double? newHeight){
  return MediaQuery.of(context).size.height * newHeight!;
}

