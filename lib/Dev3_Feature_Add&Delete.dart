import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

//========== Add Expense ==========
Future<void> addExpense(Map<String, dynamic> userInfo) async {
  print("===== Add new item =====");
  stdout.write("Item: ");
  String? item = stdin.readLineSync()?.trim();
  stdout.write("Paid: ");
  String? paidStr = stdin.readLineSync()?.trim();

  if (item == null || item.isEmpty || paidStr == null || paidStr.isEmpty) {
    print("Invalid input. Please try again.");
    return;
  }

  try {
    int.parse(paidStr);

    final url = Uri.parse('http://localhost:3000/add-expense');
    final response = await http.post(
      url,
      body: {
        "user_id": userInfo['userId'].toString(),
        "item": item,
        "paid": paidStr,                           
      },
    );

    if (response.statusCode == 200) {
      print("Inserted!");
    } else {
      print("Failed to add expense: ${response.body}");
    }
  } catch (e) {
    print("Invalid amount. Please enter a number.");
  }
}

//========== Delete Expense ==========
Future<void> deleteExpense(Map<String, dynamic> userInfo) async {
  print("===== Delete an item =====");
  stdout.write("Item id: ");
  String? idStr = stdin.readLineSync()?.trim();

  if (idStr == null || idStr.isEmpty) {
    print("Invalid input. Please try again.");
    return;
  }

  try {
    int.parse(idStr);

    final token = userInfo['token'];
    if (token == null || token.toString().isEmpty) {
      print("No token. Please login again.");
      return;
    }

    final url = Uri.parse('http://localhost:3000/delete-expense/$idStr');
    final response = await http.delete(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print("Deleted!");
    } else {
      print("Failed to delete expense: ${response.body}");
    }
  } catch (e) {
    print("Invalid ID. Please enter a number.");
  }
}
