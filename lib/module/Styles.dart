import 'package:flutter/material.dart';
import 'SizeConfig.dart';


class Styles{
  static final String fontFamily = 'Montserrat';
  static final Color fontColor = HexColor("#707070");
  static final Color amberColor = HexColor("#FB990A");
  static final Color purpleColor = HexColor("#7B1FA2");
  static final Color colorGrey = Colors.white;

  static final TextStyle textStyleLabel = TextStyle( color: Colors.black, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 12);

  static final TextStyle textStyleLabel25 = TextStyle( color: fontColor, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 25);
  static final TextStyle textStyleLabel25White = TextStyle( color: Colors.white, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 25);
  static final TextStyle textStyleLabel22 = TextStyle( color: fontColor, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 22);
  static final TextStyle textStyleLabel22White = TextStyle( color: Colors.white, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 22);
  static final TextStyle textStyleLabel13White = TextStyle( color: Colors.white, fontWeight: FontWeight.w500, fontFamily: fontFamily, fontSize: 13);
  static final TextStyle textStyleLabel13 = TextStyle( color: fontColor, fontWeight: FontWeight.w500, fontFamily: fontFamily, fontSize: 13);
  static final TextStyle textStyleLabel13Life = TextStyle( color: Colors.pinkAccent, fontWeight: FontWeight.w500, fontFamily: fontFamily, fontSize: 13);
  static final TextStyle textStyleLabel13Point = TextStyle( color: Colors.blueAccent, fontWeight: FontWeight.w500, fontFamily: fontFamily, fontSize: 13);
  static final TextStyle textStyleLabel18 = TextStyle( color: fontColor, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 18);
  static final TextStyle textStyleLabel15 = TextStyle( color: fontColor, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 15);
  static final TextStyle textStyleLabel15Purple = TextStyle( color: Styles.purpleColor, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 18);

  static final TextStyle textStyleLabel15Life = TextStyle( color: Colors.pinkAccent, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 15);
  static final TextStyle textStyleLabel15Point = TextStyle( color: Colors.lightBlueAccent, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 15);



  static final TextStyle buttonTextStyle = TextStyle( color: Colors.white, fontWeight: FontWeight.w600, fontFamily: fontFamily, fontSize: 15);

  static final ShapeBorder buttonShape =  RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(SizeConfig.roundedCornerRadius),
  side: BorderSide(color: colorGrey)
  );

}