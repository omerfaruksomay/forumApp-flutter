import 'package:flutter/material.dart';
import 'package:forum_app/components/input_widget.dart';
import 'package:forum_app/controllers/authentication.dart';
import 'package:forum_app/screens/login_screen.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register Page',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 30),
            InputWidget(
                hintText: "Name",
                controller: _nameController,
                obscureText: false),
            const SizedBox(height: 20),
            InputWidget(
                hintText: "User Name",
                controller: _usernameController,
                obscureText: false),
            const SizedBox(height: 20),
            InputWidget(
                hintText: "Email",
                controller: _emailController,
                obscureText: false),
            const SizedBox(height: 20),
            InputWidget(
              hintText: "Password",
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Obx(() {
              return _authController.isLoading.value
                  ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 15),
                      ),
                      onPressed: () async {
                        await _authController.register(
                          name: _nameController.text.trim(),
                          username: _usernameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      },
                      child: const Text('Register',
                          style: TextStyle(
                            fontSize: 17,
                          )),
                    );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[350],
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
              ),
              onPressed: () {
                Get.to(() => const LoginScreen());
              },
              child: const Text(
                "Login",
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
