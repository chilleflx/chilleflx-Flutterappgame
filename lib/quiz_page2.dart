import 'package:appgame/Methods.dart';
import 'package:flutter/material.dart';

class QuizPage2 extends StatefulWidget {
  const QuizPage2({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage2> {
  final Methods methodes = Methods();
  String url = 'https://opentdb.com/api.php?amount=10&category=24&difficulty=medium&type=multiple';

  @override
  void initState() {
    super.initState();
    methodes.fetchQuestions(url, setState);
  }

  @override
  Widget build(BuildContext context) {
    if (methodes.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Political quiz')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    var question = methodes.questions[methodes.currentQuestionIndex];
    var answers = List<String>.from(question['incorrect_answers']);
    answers.add(question['correct_answer']);
    answers.shuffle();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC4D0CE),
        title: const Text('Political quiz'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              './images/political_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Text(
              'Question ${methodes.currentQuestionIndex + 1} of ${methodes.questions.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Correct Answers: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${methodes.correctAnswers}',
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
                    methodes.questions.isNotEmpty
                        ? methodes.questions[methodes.currentQuestionIndex]['question']
                        : 'Loading...',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF008080),
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
                        width: MediaQuery.of(context).size.width / 2 - 16, // Adjust width of each button
                        child: ElevatedButton(
                          onPressed: () => methodes.checkAnswer(answer, context, setState),
                          child: Text(answer),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}