import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

//========== Future Get All Expenses ==========
Future<void> getAllExpenses(int? userId) async {
  final uri = Uri.parse('http://localhost:3000/expenses/$userId');
  final response = await http.get(uri);

  if (response.statusCode != 200) {
    print("Failed to retrieve expenses!");
    return;
  }

  final expenses = jsonDecode(response.body) as List;
  if (expenses.isEmpty) {
    print("No expenses found.");
    return;
  }

  print("===== All Expenses =====");
  for (var e in expenses) {
    print("${e['id']}. ${e['item']} : ${e['paid']}฿ : ${e['date']}");
  }
}