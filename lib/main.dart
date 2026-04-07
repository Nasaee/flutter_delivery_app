import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/Pages/Screen/home_screen.dart';
import 'package:flutter_delivery_app/Pages/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://eohzxnhhvswyogimdizv.supabase.co',
    anonKey: 'sb_publishable__fgYD6fh22-k7cm1K611yQ_BfrXtMda',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    return StreamBuilder(
      stream: supabase.auth.onAuthStateChange,

      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;
        if (session != null) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
