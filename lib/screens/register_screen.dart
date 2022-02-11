import 'package:flutter/material.dart';
import 'package:role_based_auth/components/widgets/input_field.dart';
import 'package:role_based_auth/components/widgets/submit_button.dart';
import 'package:role_based_auth/methods/auth_methods.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Register',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                controller: _passwordController,
                isPassword: true,
                hintText: 'Password',
              ),
              const SizedBox(
                height: 40,
              ),
              SubmitButton(
                title: 'Register',
                onSubmit: () {
                  AuthMethods().regsiterUser(
                    _emailController.text,
                    _passwordController.text,
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('OR'),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
