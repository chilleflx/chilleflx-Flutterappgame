import 'package:appgame/list_game.dart';
import 'package:appgame/quiz_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: ListView(
        children: [
          Positioned.fill(child: Image.asset('./images/6975312.jpg', fit: BoxFit.cover)),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'WISDOM GAME',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Welcome to the Wisdom Game!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Press the button below to start the game!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListGame(),
                  ),
                );
              },
              child: const Text('Start Game'),
            ),
          ),
        ],
      ),
    );
    }
  }
