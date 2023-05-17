import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_management/models/dash_procastination.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/utils/endpoint.dart';

class ProcastinationController extends GetxController {
  RxList<DashProcastination> dataProkastinasi = RxList();

  Future<void> getData() async {
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/'));

    if (response.statusCode != 200) return;

    Iterable it = jsonDecode(response.body);
    dataProkastinasi.value = it.map((e) => DashProcastination.fromJson(e)).toList();
  }
}
