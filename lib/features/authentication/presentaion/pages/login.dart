import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../components/my_buttun.dart';
import '../components/my_textField.dart';
import '../cubits/auth_cubit/auth_cubit.dart';
class LoginPage extends StatefulWidget {
  final VoidCallback togglePages;

  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final PassController = TextEditingController();

  void login() {
    final String email = emailController.text.trim();
    final String password = PassController.text.trim();

    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.loginWithEmailAndPw(email, password);
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Please enter both email and password",
        ),
      );
    }
  }

  @override
  void dispose() {
    PassController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_open_rounded, size: 80, color: Colors.green[700]),
                const SizedBox(height: 50),
                Text(
                  "Welcome Back, You Have Been Missed!",
                  style: TextStyle(color: Colors.green[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                MyTextField(controller: emailController, hintText: "Email", obscureText: false),
                const SizedBox(height: 12),
                MyTextField(controller: PassController, hintText: "Password", obscureText: true),
                const SizedBox(height: 25),
                MyButton(onTap: login, text: "Login"),
                const SizedBox(height: 25),
                RichText(
                  text: TextSpan(
                    text: "Not a member? ",
                    style: TextStyle(color: Colors.grey[700]),
                    children: [
                      TextSpan(
                        text: "Register now",
                        style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = widget.togglePages,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
