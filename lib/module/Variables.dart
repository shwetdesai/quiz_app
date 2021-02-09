class Answer {
    String answer;
    int points;

    Answer(String answer,int points){
      this.answer = answer;
      this.points = points;
    }
}

class Question {
   String question;
   List<Answer> answers = new List();

   Question(String question, List<Answer> answers){
     this.question = question;
     for(int i = 0;i <answers.length; i++)
        this.answers.add(answers[i]);
   }
}