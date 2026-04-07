import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/Core/Utils/consts.dart';
import 'package:flutter_delivery_app/models/on_bording_model.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // for image background
          Container(
            height: size.height,
            width: size.width,
            color: imageBackground,
            child: Image.asset(
              "assets/food-delivery/food_pattern.png",
              color: imageBackground2,
              repeat: ImageRepeat.repeatY,
            ),
          ),
          Positioned(
            top: -80,
            right: 0,
            left: 0,
            child: Image.asset("assets/food-delivery/chef.png"),
          ),
          Positioned(
            top: 139,
            right: 50,
            child: Image.asset("assets/food-delivery/leaf.png", width: 80),
          ),
          Positioned(
            top: 390,
            right: 40,
            child: Image.asset("assets/food-delivery/chili.png", width: 80),
          ),
          Positioned(
            top: 230,
            left: -20,
            child: Image.asset(
              "assets/food-delivery/ginger.png",
              height: 90,
              width: 90,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CustomClip(),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 180,
                      // วิดเจ็ตที่ยอมให้ผู้ใช้ใช้นิ้ว  "ปัดซ้าย-ขวา"
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: data.length,
                        onPageChanged: (index) {
                          setState(() => _currentPage = index);
                        },
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: data[index]['title1'],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: data[index]['title2'],
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                data[index]['description']!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        data.length,
                        (index) => AnimatedContainer(
                          duration: Duration(microseconds: 300),
                          width: _currentPage == index ? 20 : 10,
                          height: 10,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.orange
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.red,
                      height: 65,
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Get started',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // เริ่มต้นที่มุมซ้ายบน (0, 0)
    Path path = Path();

    // ลงมา 30px ตามขอบซ้าย → (0, 30)
    path.lineTo(0, 30);

    // ลงต่อจนถึงมุมซ้ายล่าง → (0, height)
    path.lineTo(0, size.height);

    // ปาดขวาไปมุมขวาล่าง → (width, height)
    path.lineTo(size.width, size.height);

    // ขึ้นมาตามขอบขวา หยุดที่ 30px จากบน → (width, 30)
    path.lineTo(size.width, 30);

    // วาดเส้นโค้งจากขวา → ซ้าย ให้ส่วนบนโค้งนูนขึ้น (เหมือนโค้งสะพาน)
    // control point อยู่กลางจอ แต่ลอยเหนือขอบบน 30px (-30) เพื่อให้โค้งนูน
    path.quadraticBezierTo(
      size.width / 2,
      -30, // control point: กึ่งกลาง(x) , เหนือขอบบน(y -30) เหมือนแม่เหล็กดึงดูดให้โค้งนูนขึ้น
      0,
      30, // end point: กลับมาจุดเริ่มต้น (0, 30)
    );

    // ปิด path เพื่อสร้างรูปทรงที่สมบูรณ์
    path.close();
    return path;
  }

  @override
  // รูปทรงนี้ไม่เปลี่ยนแปลง จึงไม่จำเป็นต้อง clip ใหม่
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
