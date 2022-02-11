import 'package:flutter/material.dart';
import 'package:role_based_auth/components/widgets/input_field.dart';
import 'package:role_based_auth/components/widgets/submit_button.dart';
import 'package:role_based_auth/methods/auth_methods.dart';
import 'package:role_based_auth/screens/admin/admin_home.dart';
import 'package:role_based_auth/screens/register_screen.dart';
import 'package:role_based_auth/screens/user/user_home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                'Log In',
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
                title: 'Log In',
                onSubmit: () async {
                  String res = await AuthMethods().loginUser(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (res == 'success') {
                    bool isAdmin = await AuthMethods().checkAdmin();
                    if (isAdmin) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminHome(),
                        ),
                      );
                    } else if (!isAdmin) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UserHome(),
                        ),
                      );
                    } 
                  }
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Register',
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
