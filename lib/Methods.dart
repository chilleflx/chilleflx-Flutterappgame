// lib/quiz_helper.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class Methods {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;
  int correctAnswersCount = 0;


  Future<void> fetchQuestions(String url, Function setState) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        questions = json.decode(response.body)['results'];
      });
    } else {
      throw Exception('Failed to load questions');
    }
  }

  void checkAnswer(String selectedAnswer, BuildContext context, Function setState) {
    String correctAnswer = questions[currentQuestionIndex]['correct_answer'];
    if (selectedAnswer == correctAnswer) {
      Fluttertoast.showToast(
        msg: 'Correct',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      correctAnswersCount++;
    } else {
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
  // Getter to access the value

  int get correctAnswers{
    return correctAnswersCount;
  }
}