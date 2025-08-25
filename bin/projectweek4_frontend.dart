import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projectweek4_frontend/Export_Feature_to_Main.dart';

void main() async {
  // ----------------- login -----------------
  final userInfo = await login();
  // ----------------- Choose Choice -----------------
  if (userInfo != null) {
    await menu(userInfo);
  }
}

//========== Future login ==========
Future<Map<String, dynamic>?> login() async {
  print("===== Login =====");
  stdout.write("Username: ");
  String? username = stdin.readLineSync()?.trim();
  stdout.write("Password: ");
  String? password = stdin.readLineSync()?.trim();

  if (username == null || password == null) return null;

  final body = {"username": username, "password": password};
  final url = Uri.parse('http://localhost:3000/login');
  final response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    print(response.body);
    return null;
  }
}

//========== Future Menu ==========
Future<void> menu(Map<String, dynamic> userInfo) async {
  while (true) {
    print("===================== Expenses Tracking App =====================");
    print("Welcome ${userInfo['username']}");
    print("1. All expenses");
    print("2. Today's expense");
    print("3. Search expense");
    print("4. Add expense");
    print("5. Delete an expense");
    print("6. Exit");
    stdout.write("Choose...");
    String? choice = stdin.readLineSync()?.trim();
    if (choice == "1") {
      // get all expenses
    } else if (choice == "2") {
      // get Today expenses
    } else if (choice == "3") {
      // searching expenses
    } else if (choice == "4") {
      // add expenses
    } else if (choice == "5") {
      // delete expenses
    } else if (choice == "6") {
      print("Exiting menu...");
      break;
    } else {
      print("Invalid choice");
    }
  }
}
