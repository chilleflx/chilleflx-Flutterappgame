import 'package:appgame/core/theme/theme.dart';
import 'package:appgame/features/auth/auth_gate.dart';
import 'package:appgame/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:appgame/features/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: AuthGate(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  String userName = ''; // Store the user's name

  @override
  void initState() {
    super.initState();
    fetchUserEmail();
  }

  void fetchUserEmail() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null && user.email != null) {
      // Extract the name from the email
      setState(() {
        userName = user.email!.split('@')[0];
      });
    }
  }

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('WISDOM GAME'),
          actions: [IconButton(onPressed: logout, icon: const Icon(Icons.logout))],
      ),
      body: Column(
        children: [
          if (userName.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome, $userName!',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const Expanded(child: HomePage()),
        ],
      ),
    );
  }
}
