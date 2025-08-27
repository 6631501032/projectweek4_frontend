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
Future<void> deleteExpense(int? userId) async {
  print("===== Delete an item =====");
  stdout.write("Item id: ");
  String? idStr = stdin.readLineSync()?.trim();

  if (idStr == null || idStr.isEmpty) {
    print("Invalid input. Please try again.");
    return;
  }

  try {
    final int id = int.parse(idStr);
    final url = Uri.parse('http://localhost:3000/delete-expense/$id');

    final response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId, 
      }),
    );

    Map<String, dynamic>? responseBody;
    try {
      responseBody = jsonDecode(response.body);
    } catch (_) {
      responseBody = null;
    }

    if (response.statusCode == 200) {
      print(responseBody?["message"] ?? "Deleted!");
    } else if (response.statusCode == 404) {
      print(responseBody?["error"] ?? "Expense not found.");
    } else if (response.statusCode == 400) {
      print(responseBody?["error"] ?? "Invalid request.");
    } else {
      print("Failed to delete expense: ${response.body}");
    }
  } catch (e) {
    print("Invalid ID. Please enter a number.");
  }
}
