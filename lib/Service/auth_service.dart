import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/Pages/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  Future<String?> sigup(String email, String password) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null) {
        // Empty identities means the email is already registered
        if (response.user!.identities?.isEmpty ?? true) {
          return 'This email is already registered';
        }
        return null;
      }
      return 'An unknow error eccurred';
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        return null;
      }
      return 'An unknow error eccurred';
    } catch (error) {
      debugPrint(error.toString());
      return error.toString();
    }
  }

  Future<String?> logout(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      if (!context.mounted) return null;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return error.toString();
    }
  }
}
