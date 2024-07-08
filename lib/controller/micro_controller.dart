import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MicroController extends GetxController {
  RxString accountId = "".obs;
  RxInt amount = 0.obs;
  RxInt balance = 2000.obs;
  RxString name = "aaa".obs;
  RxBool showConfirm = false.obs;
  RxBool inputing = false.obs;

  Future<void> pay() async {
    if (amount.value > 0 && accountId.value.length > 2) {
      try {
        final response = await http.post(
            Uri.parse('http://192.168.48.1:8080/account/pay'),
            headers: <String, String>{
              "Content-Type": "application/json",
            },
            body: jsonEncode(<String, dynamic>{
              "accountId": int.parse(accountId.value),
              "amount": amount.value
            }));
        showConfirm.value = false;
        // print("Check 1");
        // print(response.statusCode);
        if (response.statusCode == 200) {
          // print(response.body);
          // print("Check 2");
          balance.value -= amount.value;
          // print("Amount ${amount.value}");
          // print("Balance ${balance.value}");
        } else {
          throw Exception('Failed to create data');
        }
      } catch (error) {
        print(error);
      }
    }
  }

  Future<void> checkAccount() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.48.1:8080/account/checkbeforepay/${accountId.value}'));

      if (response.statusCode == 200) {
        showConfirm.value = true;
        // Convert bytes to string
        String jsonString = utf8.decode(response.bodyBytes);

        // Decode JSON
        Map<String, dynamic> jsonData = jsonDecode(jsonString);
        name.value = jsonData['name'];

        print(jsonData);
      } else {
        print("ID : " + accountId.value.toString());
        print("Amount : " + amount.value.toString());
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
    }
  }
}
