import 'package:appgame/quiz_page.dart';
import 'package:appgame/quiz_page1.dart';
import 'package:appgame/quiz_page2.dart';
import 'package:flutter/material.dart';

class ListGame extends StatelessWidget {
  const ListGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Games'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizPage(),
                  ),
                );
              },
              child: const Text('Start Computer science quiz'),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizPage1(),
                  ),
                );
              },
              child: const Text('Start sport quiz'),
            ),
          ),
          ListTile(
            title: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuizPage2(),
                  ),
                );
              },
              child: const Text('Start political quiz'),
            ),
          ),
        ],
      ),
    );
  }
}
