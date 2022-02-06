import 'package:flutter/material.dart';
import 'package:recipe_memo/utilities/color.dart';

const kWidthDoubleInfinity = double.infinity;

const kAppBarTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
);

const kContentsTitle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

const kContentsTitleBorder = Border(
  bottom: BorderSide(color: Color(lightThemeColor), width: 3),
);

const kContentsTitlePadding = EdgeInsets.only(bottom: 8);

const kOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  borderSide: BorderSide(
    color: Color(0xFFD6E4EC),
  ),
);

const kBtnText = TextStyle(
  color: Color(0xFFFFFFFF),
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
