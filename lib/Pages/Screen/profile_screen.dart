import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/Service/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
