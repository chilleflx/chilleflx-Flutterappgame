import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    final response = await http.get(Uri.parse('https://opentdb.com/api.php?amount=10&category=18&difficulty=medium&type=multiple'));
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Correct!')));
    } else {
      // Incorrect answer logic
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect!')));
    }
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Quiz')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    var question = questions[currentQuestionIndex];
    var answers = List<String>.from(question['incorrect_answers']);
    answers.add(question['correct_answer']);
    answers.shuffle();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple,
          title: const Text('Quiz') ,centerTitle: true,
      ),
        body: Stack(
          children: [
            Column(
              children: [
                Image.asset('./images/freepik__candid-image-photography-natural-textures-highly-r__87836.jpeg'),
              ],
            ),
            Positioned(
              child: Container(
              alignment: Alignment.lerp(Alignment.center, Alignment.topCenter, 0.5),
                child:  Text(
                  questions.isNotEmpty ? questions[currentQuestionIndex]['question'] : 'Loading...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: answers.map((answer) => ElevatedButton(
                  onPressed: () => checkAnswer(answer),
                  child: Text(answer),
                )).toList(),
              ),
            ),
          ],
        )
    );
  }
}
