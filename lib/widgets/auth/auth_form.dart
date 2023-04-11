import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext auth_form_context,
  ) submitFn;
  const AuthForm(this.submitFn);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  void _trySubmit() {
    final isValid =
        _formKey.currentState!.validate(); // triggers all validators in a Form

    // Before we save - close the soft keyboard
    FocusScope.of(context).unfocus();
    if (isValid) {
      // if all validators return null => True
      _formKey.currentState!.save(); // triggers onsave and stores form values
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                // column will not take as much height as possible bu only as much as needed
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value != null && !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // will only run if validation is is true
                      _userEmail = value as String;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Adress',
                    ),
                  ), // email
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('username'),
                      validator: (value) {
                        if ((value != null && value.isEmpty) ||
                            (value != null && value.length < 4)) {
                          return 'Username must have at least 4 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // will only run if validation is is true
                        _userName = value as String;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                    ), // username

                  TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if ((value != null && value.isEmpty) ||
                          (value != null && value.length < 8)) {
                        return 'Password must have at least 8 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // will only run if validation is is true
                      _userPassword = value as String;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(_isLogin ? 'Login' : 'Sign up'),
                  ), // password
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create an account'
                        : 'I already have an account'),
                  ), // password
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
