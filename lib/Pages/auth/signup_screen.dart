import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/Pages/auth/login_screen.dart';
import 'package:flutter_delivery_app/Service/auth_service.dart';
import 'package:flutter_delivery_app/Widgets/my_button.dart';
import 'package:flutter_delivery_app/Widgets/snack_bar.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _signUp() async {
    if (_isLoading) return;

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty) {
      showSnackBar(
        ScaffoldMessenger.of(context),
        "Please enter your email address.",
      );
      return;
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      showSnackBar(
        ScaffoldMessenger.of(context),
        "Please enter a valid email structure.",
      );
      return;
    }

    if (password.isEmpty) {
      showSnackBar(ScaffoldMessenger.of(context), "Please enter a password.");
      return;
    }

    if (password.length < 6) {
      showSnackBar(
        ScaffoldMessenger.of(context),
        "Password must be at least 6 characters long.",
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final error = await _authService.sigup(email, password);

      if (!mounted) return;
      if (error == null) {
        showSnackBar(ScaffoldMessenger.of(context), "Account created successfully!", isError: false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        showSnackBar(ScaffoldMessenger.of(context), error);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ฟังก์ชัน dispose() จะถูกเรียกใช้เมื่อหน้าจอนี้ (Widget) ถูกปิดหรือทำลายทิ้งไป
  // การเรียก .dispose() ที่ตัว Controller จะช่วยเคลียร์ Resource (หน่วยความจำ) ที่ Controller เหล่านั้นถือครองอยู่
  // หากไม่ทำขั้นตอนนี้ จะเกิดปัญหา "Memory Leak" (แรมรั่ว) คือแอปพลิเคชันจะกินพื้นที่หน่วยความจำสะสมไปเรื่อยๆ จนอาจทำให้แอปค้างหรือเด้งหลุดได้
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
                'assets/6343825.jpg',
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
                    "Create Account",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E212D),
                      letterSpacing: -1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Sign up to get started with your delivery journey.",
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
                      onTap: _signUp,
                      buttontext: "Sign Up",
                      isLoading: _isLoading,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Login Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
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
