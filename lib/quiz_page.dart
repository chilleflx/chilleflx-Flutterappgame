import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


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
      Fluttertoast.showToast(
        msg: 'Correct',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        backgroundColor: Colors.green, // Set to green for correct answers
        textColor: Colors.white,
      );
    } else {
      // Incorrect answer logic
      Fluttertoast.showToast(
        msg: 'Incorrect',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        backgroundColor: Colors.grey, // Set to red for incorrect answers
        textColor: Colors.red,
      );
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
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Quiz'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              './images/im1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    questions.isNotEmpty ? questions[currentQuestionIndex]['question'] : 'Loading...',
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
                    children: answers.map((answer) =>
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2 - 16, // Adjust width of each button
                          child: ElevatedButton(
                            onPressed: () => checkAnswer(answer),
                            child: Text(answer),
                          ),
                        ),
                    ).toList(),
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