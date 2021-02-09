import 'dart:io';

import 'package:flutter/material.dart';

import 'SizeConfig.dart';
import 'Styles.dart';


class CustomDialogs{
  static showLoaderDialog(BuildContext context,String message,){
    SizeConfig().init(context);
    AlertDialog alert=AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeConfig.roundedCornerRadius))),
      content: Container( height: SizeConfig.blockSizeVertical * 10, alignment: Alignment.center,child:Text(message,style: Styles.textStyleLabel15, )),
    );
    showDialog(
      // barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup(
          'google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
        return true;
      else
        return false;
    }on SocketException catch (_) {
      return false;
    }
  }

  static nothing(){}



}

