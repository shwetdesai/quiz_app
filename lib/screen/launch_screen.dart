import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/module/SizeConfig.dart';
import 'package:quiz_app/module/Strings.dart';
import 'package:quiz_app/module/Styles.dart';
import 'package:quiz_app/screen/select_option_screen.dart';




class LaunchScreen  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LaunchScreen();
  }

}

class _LaunchScreen extends State<LaunchScreen>{
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3),() =>   Navigator.push(context, SlideRightRoute(page: SelectOptionScreen( ))));
    super.initState();

  }


  Widget text1Container(){
    return new Container(

      height: SizeConfig.blockSizeVertical * 8,
      child: Text(
        Strings.labelQuizGame,
        style: Styles.textStyleLabel25,
      ),
    );
  }

  Widget text2Container(){
    return new Container(

      height: SizeConfig.blockSizeVertical * 8,
      child: Text(
        Strings.iconSmile,
        style: Styles.textStyleLabel22,
      ),
    );
  }


  Widget introductionTextContainer(){
    return new Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          text1Container(),
          text2Container(),
        ],
      ),
    );
  }


//  BuildContext buildContext;
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    SizeConfig().init(context);

    return Scaffold(
        key: key,
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Center(
                  child: new Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        introductionTextContainer(),
                      ],
                    ),
                  )
              ),
            );
  }

}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
  );
}