import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class QuizPage1 extends StatefulWidget {
  const QuizPage1({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage1> {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswersCount = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=21&difficulty=medium&type=multiple'));
    if (response.statusCode == 200) {
      setState(() {
        questions = json.decode(response.body)['results'];
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }
  void checkAnswer(String selectedAnswer) {
    String correctAnswer = questions[currentQuestionIndex]['correct_answer'];
    if (selectedAnswer == correctAnswer) {
      // Correct answer logic
      Fluttertoast.showToast(
        msg: 'Correct',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      correctAnswersCount++;
    } else {
      // Incorrect answer logic
      Fluttertoast.showToast(
        msg: 'Incorrect',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
    setState(() {
      currentQuestionIndex++;
      if (currentQuestionIndex >= questions.length) {
        showResultDialog(correctAnswersCount, context);
        currentQuestionIndex = 0;
      }
    });
  }

  void showResultDialog(int correctAnswersCount, BuildContext context) {
    if (correctAnswersCount >= 5) {
      // Success widget
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        title: 'Quiz Result',
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Congratulations!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'You passed the quiz.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
      )..show();
    } else {
      // Failure widget
      AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.warning,
        title: 'Quiz Result',
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sorry!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'You failed the quiz.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        btnOkOnPress: () {
          Navigator.of(context).pop();
        },
      )..show();
    }
  }



  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Sport quiz')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    var question = questions[currentQuestionIndex];
    var answers = List<String>.from(question['incorrect_answers']);
    answers.add(question['correct_answer']);
    answers.shuffle();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Sport quiz'),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              './images/sports_composition_512x512.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(0.6),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Correct Answers: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: '$correctAnswersCount',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Container(
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    questions.isNotEmpty
                        ? questions[currentQuestionIndex]['question']
                        : 'Loading...',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF008080),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Question ${currentQuestionIndex + 1} of ${questions.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Wrap(
                    spacing: 8.0, // Horizontal space between buttons
                    runSpacing: 8.0, // Vertical space between rows
                    alignment: WrapAlignment.center,
                    children: answers
                        .map(
                          (answer) => SizedBox(
                        width: MediaQuery.of(context).size.width / 2 -
                            16, // Adjust width of each button
                        child: ElevatedButton(
                          onPressed: () => checkAnswer(answer),
                          child: Text(answer),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}