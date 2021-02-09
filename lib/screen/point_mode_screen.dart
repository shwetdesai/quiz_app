import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/module/SizeConfig.dart';
import 'package:quiz_app/module/Strings.dart';
import 'package:quiz_app/module/Styles.dart';
import 'package:quiz_app/module/Variables.dart';
import 'package:quiz_app/module/custom_dialogs.dart';
import 'package:quiz_app/screen/select_option_screen.dart';




class PointModeScreen  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PointModeScreen();
  }

}

class _PointModeScreen extends State<PointModeScreen>{

  String question;
  List<Question> questions;
  int indexQuestion = -1,lengthQuestion = 0,showIndexQuestion = 1;
  bool isLoading = true;
  List<Color> backgroundColor;
  List<TextStyle> textStyle;
  int points = 0;
  static bool isClickable = true;

  @override
  void initState() {
    // TODO: implement initState
    setQuestion("Question");
    checkInternet();
    super.initState();
  }

  checkInternet(){
    CustomDialogs.checkInternet().then((value) => {
      if(value){
        getAPIQuestions()
      }else{
        CustomDialogs.showLoaderDialog(context, 'Check Internet')
      }
    });
  }

  buttonClick(Answer answer){
    isClickable = false;
    checkAnswer(answer,context);
  }

  getAPIQuestions(){
    getAllQuestions();
    setAllQuestions();

  }

  setAllQuestions(){
    backgroundColor = new List();
    backgroundColor.add(Colors.white);
    backgroundColor.add(Colors.white);
    backgroundColor.add(Colors.white);
    backgroundColor.add(Colors.white);


    textStyle = new List();
    textStyle.add(Styles.textStyleLabel13);
    textStyle.add(Styles.textStyleLabel13);
    textStyle.add(Styles.textStyleLabel13);
    textStyle.add(Styles.textStyleLabel13);
  }

  setNewQuestion(int questionsIndex){
    indexQuestion = questionsIndex;
    isLoading = false;
    setQuestion(questions[questionsIndex].question);

  }

  nextQuestion(){
    setState(() {
      isClickable = true;
      setAllQuestions();
      indexQuestion++;
      showIndexQuestion++;
      if(indexQuestion < questions.length){
        setNewQuestion(indexQuestion);
      }
    });
  }

  moveBack(bool isTrue){
    if(isTrue)
      Navigator.pop(context);
    Navigator.push(context, SlideRightRoute(page: SelectOptionScreen()));
  }

  checkAnswer(Answer answer,BuildContext context){

    setState(() {
      backgroundColor.clear();
      textStyle.clear();
      if(answer.points == 10){
        points += 10;
        for(int i = 0; i < 4; i++){
          if(answer == questions[indexQuestion].answers[i]){
            backgroundColor.add(Colors.greenAccent);
            textStyle.add(Styles.textStyleLabel13White);
          }else{
            backgroundColor.add(Colors.white);
            textStyle.add(Styles.textStyleLabel13);
          }
        }
      }else{
        points -= 1;
        for(int i = 0; i < 4; i++){
          if(answer == questions[indexQuestion].answers[i]){
            backgroundColor.add(Colors.redAccent);
            textStyle.add(Styles.textStyleLabel13White);
          }else if(questions[indexQuestion].answers[i].points == 10){
            backgroundColor.add(Colors.greenAccent);
            textStyle.add(Styles.textStyleLabel13White);
          }else{
            backgroundColor.add(Colors.white);
            textStyle.add(Styles.textStyleLabel13);
          }
        }
      }});

    if(indexQuestion != questions.length && points >= 0)
      Timer(Duration(seconds: 3),() =>   nextQuestion());
    else{
      CustomDialogs.showLoaderDialog(context, 'Game Over');
      Timer(Duration(seconds: 3),() =>   moveBack(true));
    }

  }


  getAllQuestions(){
    getQuestions().then((value) => {setNewQuestion(value)});
  }

  Future<int> getQuestions() async{
    try {
      final databaseReference = FirebaseFirestore.instance;
      CollectionReference ref = databaseReference.collection('question');
      QuerySnapshot eventsQuery = await ref.get();


      questions = new List();
      List<Answer> answers = new List();


      if(eventsQuery.docs.isNotEmpty) {
        for (int i = 0; i < eventsQuery.docs.length; i++) {
          answers.add(new Answer(eventsQuery.docs[i].get('answer1')[0],
              eventsQuery.docs[i].get('answer1')[1]));
          answers.add(new Answer(eventsQuery.docs[i].get('answer2')[0],
              eventsQuery.docs[i].get('answer2')[1]));
          answers.add(new Answer(eventsQuery.docs[i].get('answer3')[0],
              eventsQuery.docs[i].get('answer3')[1]));
          answers.add(new Answer(eventsQuery.docs[i].get('answer4')[0],
              eventsQuery.docs[i].get('answer4')[1]));
          questions.add(
              new Question(eventsQuery.docs[i].get('Question'), answers));
          answers.clear();



        }
      }
      return 0;

    }catch (e){
      print(e);
      return -1;
    }
  }

  setQuestion(String question){
    print('Question $question');
    setState(() {
      this.question = question;
    });
  }
  Widget closeContainer(){
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
      width: SizeConfig.blockSizeHorizontal * 80,
      height: SizeConfig.blockSizeVertical * 10,
      alignment: Alignment.centerLeft,
      child: IconButton(icon: Icon(Icons.close),onPressed: (){moveBack(false);},),
    );
  }

  Widget questionContainer(){
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 80,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 10),
      child: Text(question,style: Styles.textStyleLabel13,),
    );
  }

  Widget answersContainer(){
    return Container(
      height: SizeConfig.blockSizeVertical * 30,
      width: SizeConfig.blockSizeHorizontal * 80,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
      child: Column(
        children: [
          buttonContainer(this.questions[indexQuestion].answers[0],backgroundColor[0],textStyle[0]),
          buttonContainer(this.questions[indexQuestion].answers[1],backgroundColor[1],textStyle[1]),
          buttonContainer(this.questions[indexQuestion].answers[2],backgroundColor[2],textStyle[2]),
          buttonContainer(this.questions[indexQuestion].answers[3],backgroundColor[3],textStyle[3]),
        ],
      ),

    );
  }

  Widget buttonContainer(Answer answer,Color backgroundColor,TextStyle textStyle){
    return Container(
      width: SizeConfig.blockSizeHorizontal * 70,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
      child: RaisedButton(
        elevation: SizeConfig.blockSizeVertical * 0.5,
        child: Text(answer.answer,style: textStyle,),
        onPressed: (){
          if(isClickable) {
            CustomDialogs.checkInternet().then((value) => {
              if(value)
                buttonClick(answer)
              else CustomDialogs.showLoaderDialog(context, 'No Internet')
            });
          }
        },
        color: backgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeConfig.roundedCornerRadius),
            side: BorderSide(color: backgroundColor)
        ),
      ),
    );
  }

  Widget mainContainer(){
    return isLoading ? new Container(margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 20),width: SizeConfig.blockSizeHorizontal * 10,height: SizeConfig.blockSizeHorizontal * 10, child:CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),)) : Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
      child:  Material(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(SizeConfig.roundedCornerRadius),
            bottomRight: Radius.circular(SizeConfig.roundedCornerRadius),
            topLeft: Radius.circular(SizeConfig.roundedCornerRadius),
            bottomLeft: Radius.circular(SizeConfig.roundedCornerRadius)),
        elevation: SizeConfig.blockSizeVertical * 2,
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 80,
          height: SizeConfig.blockSizeVertical * 60,
          child: Column(
            children: [
              noQuestionContainer(),
              questionContainer(),
              answersContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget noQuestionContainer(){
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
      width: SizeConfig.blockSizeHorizontal * 70,
      child: Row(
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal * 30,
            alignment: Alignment.centerLeft,
            child: Text(
              "$showIndexQuestion / ${questions.length}",
              style: Styles.textStyleLabel13,
            ),
          ),
          Container(
            width: SizeConfig.blockSizeHorizontal * 40,
            alignment: Alignment.centerRight,
            child: Container(
              height: SizeConfig.blockSizeVertical * 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Total Score",
                    style: Styles.textStyleLabel13,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                    child: Text(
                      "$points",
                      style: Styles.textStyleLabel13Point,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }



  Future<bool> _onBackPressed() async {
    // Your back press code here...
    return false;
  }

//  BuildContext buildContext;
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    SizeConfig().init(context);
    return WillPopScope(child: Scaffold(
      key: key,
      // backgroundColor: SizeConfig.backgroundColor,
      resizeToAvoidBottomPadding: false,
      body: Center(
          child: new Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(

              children: <Widget>[
                closeContainer(),
                mainContainer(),
              ],
            ),
          )
      ),
    ), onWillPop: _onBackPressed);

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