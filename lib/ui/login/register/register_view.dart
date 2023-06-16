// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text('Register'),
    );
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(
              hintText: 'ENTER YOUR EMAIL',
            ),
          ),
          TextField(
            controller: _password,
            decoration: InputDecoration(
              hintText: 'ENTER YOUR EMAIL',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: email, password: password);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('weak password');
                } else if (e.code == 'email-already-in-use') {
                  print('email already in use');
                }
              }
            },
            child: Text('REGISTER'),
          ),
        ],
      ),
    );
  }
}
