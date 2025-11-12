import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _fullName = '';
  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredConfirmPassword = '';

  final _formKey = GlobalKey<FormState>();

  void _onSave() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      maxLength: 50,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        counterText: '',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the blank';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _fullName = newValue!;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLength: 50,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        counterText: '',
                      ),
                      validator: (value) {
                        final regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        );
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email.';
                        }
                        if (!regex.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLength: 50,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        counterText: '',
                        helperText:
                            'Enter a valid email (e.g : name@example.com)',
                      ),
                      validator: (value) {
                        final regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        );
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        if (!regex.hasMatch(value)) {
                          return 'Password is not strong enough!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLength: 50,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm password',
                        counterText: '',
                      ),
                      validator: (value) {
                        final regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                        );
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        if (!regex.hasMatch(value)) {
                          return 'Password is not strong enough!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _onSave,
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(letterSpacing: 1.5),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Alreay have an account?'),
                        const SizedBox(width: 8),
                        Text(
                          'log in',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
