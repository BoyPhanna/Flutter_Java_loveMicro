import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_lm/controller/controller.dart';
import 'package:mobile_lm/screen/scanner_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:quickalert/quickalert.dart';

class MicrofinancePaymentPage extends StatefulWidget {
  const MicrofinancePaymentPage({super.key});

  @override
  State<MicrofinancePaymentPage> createState() =>
      _MicrofinancePaymentPageState();
}

class _MicrofinancePaymentPageState extends State<MicrofinancePaymentPage> {
  TextEditingController accountNumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  final FocusNode _focusAmount = FocusNode();
  final FocusNode _focusAcoountNumber = FocusNode();
  @override
  void initState() {
    accountNumber.text = qrControlller.accountId.value;
    amount.text = "0";
    _focusAmount.addListener(_onEditingComplete);
    // _focusAcoountNumber.addListener(_onEditingComplete);
    super.initState();
  }

  @override
  void dispose() {
    _focusAmount.removeListener(_onEditingComplete);
    _focusAcoountNumber.removeListener(_onEditingComplete2);
    _focusAcoountNumber.dispose();
    _focusAmount.dispose();
    super.dispose();
  }

  void _onEditingComplete() {
    if (!_focusAmount.hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  void _onEditingComplete2() {
    if (!_focusAcoountNumber.hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

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
          Positioned(
            top: 0.h,
            child: Container(
              width: Get.width,
              height: 70.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(160, 67, 240, 72),
                      Color.fromARGB(255, 67, 240, 72),
                    ]),
              ),
            ),
          ),
          Positioned(
            top: 10.h,
            left: 10.h,
            child: ZoomTapAnimation(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back,
                size: 50.h,
              ),
            ),
          ),
          Obx(
            () => Positioned(
              bottom: 0.h,
              child: Container(
                width: Get.width,
                height: Get.height * .8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.6),
                        Colors.green,
                      ]),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: FadeInUp(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200.h,
                        width: Get.width,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: 260.h,
                              height: 80.h,
                              child: TextFormField(
                                controller: accountNumber,
                                focusNode: _focusAcoountNumber,
                                onTap: () =>
                                    qrControlller.inputing.value = true,
                                onEditingComplete: () {
                                  qrControlller.inputing.value = false;
                                  _focusAcoountNumber.unfocus();
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'លេខគណនីយ',
                                ),
                              ),
                            ),
                          ),
                          ZoomTapAnimation(
                            onTap: () {
                              Get.back();
                              Get.to(() => ScannerScreen());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white,
                                      Colors.white,
                                      Color.fromARGB(255, 67, 240, 72),
                                    ]),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 4, 220, 198),
                                    blurRadius: 5,
                                    offset: Offset(5, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.qr_code_scanner_outlined,
                                size: 50.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Container(
                              width: 300.h,
                              height: 80.h,
                              child: TextFormField(
                                focusNode: _focusAmount,
                                onTap: () =>
                                    qrControlller.inputing.value = true,
                                onEditingComplete: () {
                                  qrControlller.inputing.value = false;
                                  _focusAmount.unfocus();
                                },
                                controller: amount,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'ចំនួនទឹកប្រាក់\$',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      qrControlller.inputing.value
                          ? SizedBox()
                          : FadeInRight(
                              child: ZoomTapAnimation(
                                onTap: () {
                                  qrControlller.accountId.value =
                                      accountNumber.text;
                                  qrControlller.amount.value =
                                      int.parse(amount.text);
                                  qrControlller.checkAccount();
                                },
                                child: Container(
                                  width: 150.h,
                                  height: 80.h,
                                  alignment: Alignment.center,
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
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 4, 220, 198),
                                        blurRadius: 5,
                                        offset: Offset(5, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "រួចរាល់",
                                    style: TextStyle(fontSize: 22.sp),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Positioned(
              child: FadeIn(
                child: qrControlller.showConfirm.value
                    ? Container(
                        padding: EdgeInsets.only(left: 10.h, right: 10.h),
                        width: Get.width,
                        height: Get.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.9),
                                Colors.green,
                                Colors.green,
                                Colors.green,
                              ]),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "សូមផ្ទៀងផ្ទាត់ព័ត៏មាន",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "ស្ថាប័នមីក្រូរិរញ្ញវត្ថុ Love microfinance",
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "លេខគណនីយ: ",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                Text(
                                  "${qrControlller.accountId.value}",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ឈ្មោះអតិថិជន : ",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                Text(
                                  "${qrControlller.name.value}",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ចំនួនទឹកប្រាក់ : ",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                Text(
                                  "${qrControlller.amount.value}",
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FadeInRight(
                                  child: ZoomTapAnimation(
                                    onTap: () {
                                      qrControlller.accountId.value = "";
                                      qrControlller.amount.value = 0;
                                      qrControlller.showConfirm.value = false;
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.warning,
                                        text: 'Cancel',
                                        autoCloseDuration:
                                            const Duration(seconds: 2),
                                        showConfirmBtn: false,
                                      );
                                      // Get.back();
                                    },
                                    child: Container(
                                      width: 150.h,
                                      height: 80.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white,
                                              Colors.white,
                                              Color.fromARGB(255, 241, 42, 3),
                                            ]),
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 4, 220, 198),
                                            blurRadius: 5,
                                            offset: Offset(5, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "បដិសេដ",
                                        style: TextStyle(fontSize: 22.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                FadeInRight(
                                  child: ZoomTapAnimation(
                                    onTap: () {
                                      qrControlller.accountId.value =
                                          accountNumber.text;
                                      qrControlller.amount.value =
                                          int.parse(amount.text);
                                      qrControlller.pay();
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.success,
                                        text:
                                            'Transaction Completed Successfully!',
                                        autoCloseDuration:
                                            const Duration(seconds: 2),
                                        showConfirmBtn: false,
                                      );
                                    },
                                    child: Container(
                                      width: 150.h,
                                      height: 80.h,
                                      alignment: Alignment.center,
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
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 4, 220, 198),
                                            blurRadius: 5,
                                            offset: Offset(5, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        "យល់ព្រម",
                                        style: TextStyle(fontSize: 22.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 150.h,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
