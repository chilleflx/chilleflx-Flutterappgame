import 'package:appgame/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
 }
 class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RootPage(),
    );
  }
 }

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}
  class _RootPageState extends State<RootPage> {
    int currentPage=0;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.cyan,
          title: const Text('WISDOM GAME'),
        ),
        body: const HomePage(),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          child: const Icon(Icons.play_arrow),
        ),
        bottomNavigationBar: NavigationBar(destinations:
        [NavigationDestination(icon: Icon(Icons.home), label: 'home'),
        NavigationDestination(icon: Icon(Icons.search), label: 'search'),

        ],)
      );
    }
  }
