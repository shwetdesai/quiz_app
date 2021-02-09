import 'package:flutter/material.dart';
import 'package:quiz_app/module/SizeConfig.dart';
import 'package:quiz_app/module/Strings.dart';
import 'package:quiz_app/module/Styles.dart';
import 'package:quiz_app/screen/life_mode_screen.dart';
import 'package:quiz_app/screen/point_mode_screen.dart';




class SelectOptionScreen  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectOptionScreen();
  }

}

class _SelectOptionScreen extends State<SelectOptionScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  Widget text1Container(){
    return new Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15),
      height: SizeConfig.blockSizeVertical * 8,
      child: Text(
        Strings.labelSelectAnOption,
        style: Styles.textStyleLabel25,
      ),
    );
  }

  Widget buttonContainer0(){
    return new Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 15),
      width: SizeConfig.blockSizeHorizontal * 80,
      height: SizeConfig.blockSizeVertical * 15,
      child:  RaisedButton(
          elevation: SizeConfig.blockSizeVertical * 0.5,
          child: Text(Strings.labelSelectAnOption,style: Styles.textStyleLabel13,),
          onPressed: (){

          },
          color: Styles.colorGrey,
          shape: Styles.buttonShape
      ),
    );
  }

  Widget buttonContainer1(){
    return new Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 40),
      width: SizeConfig.blockSizeHorizontal * 50,
      height: SizeConfig.blockSizeVertical * 7,
      child:  RaisedButton(
          splashColor: Colors.pinkAccent[100],
          elevation: SizeConfig.blockSizeVertical * 2,
          child: Text(Strings.labelOptionLife,style: Styles.textStyleLabel15Life,),
          onPressed: (){
            Navigator.push(context, SlideRightRoute(page: LifeModeScreen()));
          },
          color: Styles.colorGrey,
          shape: Styles.buttonShape
      ),
    );
  }

  Widget buttonContainer2(){
    return new Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 60),
      width: SizeConfig.blockSizeHorizontal * 50,
      height: SizeConfig.blockSizeVertical * 7,

      child: RaisedButton(
          splashColor: Colors.blueAccent[100],
          elevation: SizeConfig.blockSizeVertical * 2,
          child: Text(Strings.labelOptionPoint,style: Styles.textStyleLabel15Point,),
          onPressed: (){
            Navigator.push(context, SlideRightRoute(page: PointModeScreen()));
          },
          color: Colors.white,
          shape: Styles.buttonShape
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
        // backgroundColor: SizeConfig.backgroundColor,
        resizeToAvoidBottomPadding: false,
        body: Center(
                  child: new Container(
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        buttonContainer0(),
                        buttonContainer1(),
                        buttonContainer2(),
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