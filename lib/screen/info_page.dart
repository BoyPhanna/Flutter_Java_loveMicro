import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class InfomationPage extends StatefulWidget {
  const InfomationPage({super.key});

  @override
  State<InfomationPage> createState() => _InfomationPageState();
}

class _InfomationPageState extends State<InfomationPage> {
  late double titleSize = 15.h;
  late double paragraph = 15.h;
  final List<String> items = [
    'កុក ប្រុសតូច',
    'ហេង ស្រីតូច',
    'ចឺម សីហា',
    'ឆោម វិច្ឆ័យ',
    'គីម ផាន់ណា',
    'ឈាន ផានុន',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.white,
          ),
          Positioned(
            left: 10.h,
            top: 10.h,
            child: ZoomTapAnimation(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          Positioned(
            top: 30.h,
            child: Column(
              children: [
                FadeInRight(
                  child: Image.asset(
                    "assets/Rupp_logo.png",
                    width: 100.h,
                    height: 100.h,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Dance(
                  infinite: true,
                  child: FadeInUp(
                    child: Text(
                      "សាកលវិទ្យាល័យភូមិន្ទភ្នំពេញ",
                      style: TextStyle(fontSize: titleSize),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 200.h,
            child: Column(
              children: [
                FadeInUp(
                  child: Text(
                    "ក្រុមទី ៦B",
                    style: TextStyle(
                      fontSize: titleSize,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                FadeInRight(
                  child: SizedBox(
                    width: 200.h,
                    height: 300.h,
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text('${index + 1}.'),
                          title: Text(items[index]),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 10.h,
                    right: 10.h,
                  ),
                  width: Get.width,
                  child: FadeInLeft(
                    child: Text(
                      "      នេះគឺជាកម្មវិធីទូរស័ព្ទដៃសម្រាប់ធ្វើប្រតិបត្ដិការបង់ប្រាក់ប្រចាំខែឲ្យអតិថិជនរបស់ Love Microfinance. ដែលវាគឺជាកម្មវិធីបន្ថែមនៅក្នុង Project Love Microfinance របស់មុខវិជ្ជា Java Programing with Spring Boot.\n\nធ្វើនៅថ្ងៃទី 08 កក្កដា 2024",
                      style: TextStyle(fontSize: paragraph),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
