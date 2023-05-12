import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firestore/providers/auth_provider.dart';
import 'package:todo_firestore/providers/selector_provider.dart';
import 'package:todo_firestore/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthServiceProvider().getUserState();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SelectorProvider()),
    ChangeNotifierProvider(create: (_) => AuthServiceProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 1,
          backgroundColor: Colors.pink.shade900,
        ),
        scaffoldBackgroundColor: Colors.purple.shade700,
      ),
      home: HomeScreen(),
    );
  }
}
