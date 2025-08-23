import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()async {
// ----------------- login -----------------
    int? userId = await login();
// ----------------- Choose Choice -----------------

}

//========== Future login ==========
Future<int?> login() async {
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
    print("Welcome ${data['username']}!");
    return data['userId'];
  } else {
    print(response.body);
    return null;
  }
}
