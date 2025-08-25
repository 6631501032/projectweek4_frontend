import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

//========== Future Search ==========
Future<void> searchExpense(int? userId) async {
  stdout.write("Item to search: ");
  String keyword = (stdin.readLineSync() ?? "").toLowerCase();
  final uri = Uri.parse('http://localhost:3000/expenses/$userId');
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  final matches = (jsonDecode(response.body) as List).where(
    (e) => (e['item'] ?? '').toString().toLowerCase().contains(keyword),
  );
  matches.isEmpty
      ? print("No item: $keyword")
      : matches.forEach(
          (e) =>
              print("${e['id']}. ${e['item']} : ${e['paid']}฿ : ${e['date']}"),
        );
}
