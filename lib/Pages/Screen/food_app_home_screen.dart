import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/Core/Utils/consts.dart';

class FoodAppHomeScreen extends StatefulWidget {
  const FoodAppHomeScreen({super.key});

  @override
  State<FoodAppHomeScreen> createState() => _FoodAppHomeScreenState();
}

class _FoodAppHomeScreenState extends State<FoodAppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          SizedBox(width: 25),
          Container(
            height: 45,
            width: 45,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: grey1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset('assets/food-delivery/icon/dash.png'),
          ),
          Spacer(),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 18, color: red),
              SizedBox(width: 5),
              Text(
                'Bangkok, Thailand',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 5),
              Icon(Icons.keyboard_arrow_down, size: 18, color: orange),
            ],
          ),
          Spacer(),
          Container(
            height: 45,
            width: 45,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: grey1,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset('assets/food-delivery/profile.png'),
          ),
          SizedBox(width: 25),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
