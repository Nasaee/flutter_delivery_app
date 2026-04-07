import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/Service/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => AuthService().logout(context),
              child: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}
