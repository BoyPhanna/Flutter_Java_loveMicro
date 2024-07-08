import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_lm/controller/controller.dart';
import 'package:mobile_lm/screen/info_page.dart';
import 'package:mobile_lm/screen/microfinance_payment.dart';
import 'package:mobile_lm/screen/scanner_screen.dart';
import 'package:mobile_lm/wigets/menu_wiget.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            )),
          ),
          //Balance
          Positioned(
            top: 60.h,
            child: Container(
              width: 350.h,
              height: 200.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  image: DecorationImage(
                    image: AssetImage("assets/cardBG.jpg"),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Positioned(
            top: 60.h,
            child: Container(
              width: 350.h,
              height: 200.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(160, 67, 240, 72),
                      Color.fromARGB(255, 67, 240, 72),
                    ]),
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(72, 4, 220, 198),
                    blurRadius: 5,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 20.h, left: 8.h, right: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "សមតុល្យទឹកប្រាក់",
                          style: TextStyle(fontSize: 25.sp),
                        ),
                        Obx(
                          () => Text(
                            "${qrControlller.balance.value} USD",
                            style: TextStyle(fontSize: 25.sp),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          //Menu
          Positioned(
            top: 300.h,
            child: Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ZoomTapAnimation(
                        onTap: () => Get.to(() => MicrofinancePaymentPage()),
                        child: MenuWidget(
                          image: "report",
                          title: "បង់អង្គការ",
                        ),
                      ),
                      ZoomTapAnimation(
                        child: MenuWidget(
                          image: "money-bag",
                          title: "លុយផឹកស្រា",
                        ),
                      ),
                      ZoomTapAnimation(
                        child: MenuWidget(
                          image: "line-chart",
                          title: "ភាគហ៊ុន",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ZoomTapAnimation(
                        child: MenuWidget(
                          image: "payment",
                          title: "វេរ​និងដកលុយ",
                        ),
                      ),
                      ZoomTapAnimation(
                        child: MenuWidget(
                          image: "shopping-cart",
                          title: "ទិញឥវ៉ាន់",
                        ),
                      ),
                      ZoomTapAnimation(
                        child: MenuWidget(
                          image: "computer",
                          title: "កុំព្យូទ័រ",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Image.asset(
                    "assets/ceo.jpg",
                    width: Get.width,
                    height: 180.h,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),

          //tapbar
          Positioned(
              bottom: 0.h,
              child: Container(
                width: Get.width,
                height: 80.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(160, 67, 240, 72),
                        Color.fromARGB(255, 67, 240, 72),
                      ]),
                ),
              )),
          Positioned(
              bottom: 0.h,
              child: Container(
                width: Get.width,
                height: 100.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 40.h,
                    ),
                    ZoomTapAnimation(
                      onTap: () => Get.to(() => ScannerScreen()),
                      child: Container(
                        width: 100.h,
                        height: 100.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.9),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 13, 235, 61),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ]),
                        child: Icon(
                          Icons.qr_code_scanner_outlined,
                          size: 80.h,
                        ),
                      ),
                    ),
                    ZoomTapAnimation(
                      onTap: () => Get.to(
                        () => InfomationPage(),
                      ),
                      child: Icon(
                        Icons.info,
                        size: 40.h,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
