import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuWidget extends StatelessWidget {
  late String title;
  late String image;
  MenuWidget({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: Container(
        width: 150.h,
        height: 150.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.white,
                Color.fromARGB(255, 67, 240, 72),
              ]),
          borderRadius: BorderRadius.circular(25),
          border: BoxBorder.lerp(
              Border.all(color: const Color.fromARGB(255, 3, 87, 213)),
              Border.all(color: const Color.fromARGB(255, 3, 87, 213)),
              20),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 4, 220, 198),
              blurRadius: 5,
              offset: Offset(5, 2),
            ),
          ],
          image: DecorationImage(
            image: AssetImage("assets/${image}.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            width: 150.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 67, 240, 72),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Text(
              "${title}",
              style: TextStyle(fontSize: 22.sp),
            ),
          ),
        ]),
      ),
    );
  }
}
