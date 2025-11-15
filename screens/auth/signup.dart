import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/models/user.dart';
import 'package:money_tracker/providers/users.dart';
import 'package:money_tracker/screens/auth/login.dart';

class Signup extends ConsumerStatefulWidget {
  const Signup({super.key});

  @override
  ConsumerState<Signup> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  String _fullName = '';
  String _enteredEmail = '';
  String _enteredPassword = '';

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newUser = User(
        fullName: _fullName,
        email: _enteredEmail,
        password: _enteredPassword,
      );
      ref.read(usersProvider.notifier).addUser(newUser);
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Well done🎉"),
          content: Text("You have successfully signed up!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const Login()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersProvider);
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
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
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
                        if (users.any((user) => user.email == value)) {
                          return 'This email already has been registered.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _enteredEmail = newValue!;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      maxLength: 50,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        counterText: '',
                        // helperMaxLines: 2,
                        helper: Row(
                          children: [
                            Icon(Icons.info, size: 20, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'At least 8 chars, incl. upper, lower, number & symbol.',
                                style: TextStyle(fontSize: 12, height: 1.1),
                              ),
                            ),
                          ],
                        ),
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
                      onSaved: (newValue) {
                        _enteredPassword = newValue!;
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
                        if (value == null || value.isEmpty) {
                          return 'Enter your password again.';
                        }
                        if (value != _passwordController.text) {
                          return 'Confirm password doesn\'t match with password';
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => const Login(),
                              ),
                            );
                          },
                          child: Text(
                            'log in',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
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
