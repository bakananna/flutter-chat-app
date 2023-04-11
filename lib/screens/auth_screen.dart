import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext authFormContext,
  ) async {
    UserCredential authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({username: username, email: email});
    } on PlatformException catch (err) {
      var errMsg = 'An error occurred, please check your email and password.';
      if (err.message != null) {
        errMsg = err.message as String;
      }

      Scaffold.of(authFormContext).showBottomSheet((context) => SnackBar(
            content: Text(errMsg),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
    } catch (err) {
      Scaffold.of(authFormContext).showBottomSheet((context) => SnackBar(
            content: Text(err.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ));
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
