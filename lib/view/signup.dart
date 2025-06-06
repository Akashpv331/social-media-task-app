import 'package:flutter/material.dart';
import 'package:social_media_task_app/view/customer_screen.dart';
import 'package:social_media_task_app/view/login.dart';
import 'package:social_media_task_app/view/user_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = false;
  String selectedRole = "User";

  String? emailError;
  String? passwordError;
//validate function
  void validateInputData() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    setState(() {
      emailError = null;
      passwordError = null;
//validate email
      if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
        emailError = 'Enter a valid email';
      }
// validate password
      if (password.length < 6) {
        passwordError = 'Password must be at least 6 characters';
      }
// user  navigation
      if (emailError == null && passwordError == null) {
        if (selectedRole == 'User') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserHomeScreen()),
          );
        }

// customer navigation
        else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: const Text('Register Your Account'))),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // email
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'abc@gmail.com',
                border: const OutlineInputBorder(),
                errorText: emailError,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              //password
              controller: passwordController,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: '6+ characters',
                border: const OutlineInputBorder(),
                errorText: passwordError,
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "Select Role:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'User',
                      groupValue: selectedRole,
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                    ),
                    const Text('User'),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Customer',
                      groupValue: selectedRole,
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value!;
                        });
                      },
                    ),
                    const Text('Customer'),
                  ],
                ),
              ],
            ),

            ElevatedButton(
              // signup button
              onPressed: validateInputData,
              child: const Text(
                "Signup",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Loginpage(),
                    ));
              },
              child: const Text("Already have an account? Login here"),
            ),
          ]),
        ));
  }
}
