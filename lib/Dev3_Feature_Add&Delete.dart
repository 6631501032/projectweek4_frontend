//========== Add Expense ==========
Future<void> addExpense(Map<String, dynamic> userInfo) async {
  print("===== Add new item =====");
  stdout.write("Item: ");
  String? item = stdin.readLineSync()?.trim();
  stdout.write("Paid: ");
  String? paidStr = stdin.readLineSync()?.trim();

  // Basic validation
  if (item == null || paidStr == null) {
    print("Invalid input. Please try again.");
    return;
  }

  try {
    final int paid = int.parse(paidStr);
    final body = {
      "user_id": userInfo['user_id'].toString(),
      "item": item,
      "paid": paid.toString(),
    };
    final url = Uri.parse('http://localhost:3000/add-expense');
    final response = await http.post(url, body: body);

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

  if (idStr == null) {
    print("Invalid input. Please try again.");
    return;
  }

  try {
    final int id = int.parse(idStr);
    final url = Uri.parse('http://localhost:3000/delete-expense/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print("Deleted!");
    } else {
      print("Failed to delete expense: ${response.body}");
    }
  } catch (e) {
    print("Invalid ID. Please enter a number.");
  }
}