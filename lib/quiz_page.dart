import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
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
                child: const Text(
                  'Question 1: What is the capital of Nigeria?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
