import 'package:flutter/cupertino.dart';

class Apputile {
  static Widget widgetText({
    String? text,
    FontWeight? fontWeight,
    double? fontSize,
    Color? textColor,


    TextAlign? textAlign,
    int? maxline,
    double? textHight,
    TextOverflow? textOverflow,
    TextDecoration? textDecoration,
    FontStyle? fontStyle,
    dynamic? fontFamily,
    double? letterSpacing,
  }) {
    return Text(
      text ?? "",
      maxLines: maxline,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: textHight,
        decoration: textDecoration,
        fontFamily: fontFamily is String
            ? fontFamily
            : (fontFamily is TextStyle ? fontFamily.fontFamily : null),
      ),
    );
  }
}
