import 'package:flutter/material.dart';
import 'package:forum_app/components/input_widget.dart';
import 'package:forum_app/controllers/authentication.dart';
import 'package:forum_app/screens/register_screen.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Login Page',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 30),
            InputWidget(
                hintText: "Username",
                controller: _usernameController,
                obscureText: false),
            const SizedBox(height: 20),
            InputWidget(
              hintText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
              ),
              onPressed: () async {
                await _authController.login(
                  username: _usernameController.text.trim(),
                  password: _passwordController.text.trim(),
                );
              },
              child: Obx(() {
                return _authController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Login',
                        style: TextStyle(
                          fontSize: 17,
                        ));
              }),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[350],
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              ),
              onPressed: () {
                Get.to(() => const RegisterScreen());
              },
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
