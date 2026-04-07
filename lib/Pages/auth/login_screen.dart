import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/Pages/Screen/onbording_screen.dart';
import 'package:flutter_delivery_app/Pages/auth/signup_screen.dart';
import 'package:flutter_delivery_app/Service/auth_service.dart';
import 'package:flutter_delivery_app/Widgets/my_button.dart';
import 'package:flutter_delivery_app/Widgets/snack_bar.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions to make responsive design
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image with slightly rounded bottom corners
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Image.asset(
                'assets/login.jpg',
                width: double.maxFinite,
                height: size.height * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E212D),
                      letterSpacing: -1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Login to your account to continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email Input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: Colors.black38),
                        prefixIcon: Icon(Iconsax.sms, color: Colors.blueAccent),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.black38),
                        prefixIcon: const Icon(
                          Iconsax.lock,
                          color: Colors.blueAccent,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                            color: Colors.black45,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    child: MyButton(
                      isLoading: _isLoading,
                      onTap: () async {
                        setState(() => _isLoading = true);
                        final navigator = Navigator.of(context);
                        final messenger = ScaffoldMessenger.of(context);
                        final error = await _authService.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );
                        if (!mounted) return;
                        if (error != null) {
                          showSnackBar(messenger, error);
                          setState(() => _isLoading = false);
                        } else {
                          navigator.pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => OnbordingScreen(),
                            ),
                          );
                        }
                      },
                      buttontext: "Sign In",
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => SignupScreen()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40), // Safe spacing at bottom
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
