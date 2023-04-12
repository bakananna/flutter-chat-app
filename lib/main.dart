import 'package:flutter/material.dart';
import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    final fireBaseApp = await Firebase.initializeApp();
  } catch (error) {
    print(error);
  }
  runApp(const MyApp());
}

final _auth = FirebaseAuth.instance;

var test = _auth.authStateChanges().listen((event) {
  if (event != null) {
    print('user is logged out');
  } else {
    print('userisloggedin');
  }
});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Chat',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color.fromRGBO(71, 199, 252, 1),
            onPrimary: Colors.black,
            secondary: Color.fromRGBO(71, 199, 252, 1),
            onSecondary: Colors.black,
            error: Colors.red,
            onError: Colors.black,
            background: Color.fromRGBO(255, 128, 0, 1),
            onBackground: Colors.black,
            surface: Color.fromRGBO(71, 199, 252, 1),
            onSurface: Colors.black,
          ),
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.hasData) {
              return ChatScreen();
            }
            return AuthScreen();
          },
        ));
  }
}
