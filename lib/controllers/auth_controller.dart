import 'dart:convert';

import 'package:get/get.dart';
import 'package:task_management/models/user_login.dart';
import 'package:task_management/utils/endpoint.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {

  // RxInt => int
  // RxString => String
  // RxBool => bool
  // RxList = List || []

  // Rxn = state yang ada listener nya
  Rxn<UserLogin> currentUser = Rxn();

  Future<bool> login({required String nip, required String password}) async {
    final response = await http.post(
      Uri.parse('${Endpoint.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nip': nip, 'password': password}),
    );

    if (response.statusCode != 200) return false;

    final json = jsonDecode(response.body);
    currentUser.value = UserLogin.fromJson(json);

    return true;
  }
}
