import 'dart:convert';
import 'package:get/get.dart';
import 'package:task_management/models/dash_procastination.dart';
import 'package:http/http.dart' as http;
import 'package:task_management/utils/endpoint.dart';

class ProcastinationController extends GetxController {
  RxList<DashProcastination> dataProkastinasi = RxList();
  RxList<DashProcastination> dataProduktivitas = RxList();

  Future<void> getData() async {
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/dashprocrastination/'));

    if (response.statusCode != 200) return;

    Iterable it = jsonDecode(response.body);
    dataProkastinasi.value = it.map((e) => DashProcastination.fromJson(e)).toList();
  }

  Future<void> getDataProductivity() async {
    final response = await http.get(Uri.parse('${Endpoint.baseUrl}/dashboard/dashproductivity/'));

    if (response.statusCode != 200) return;

    Iterable it = jsonDecode(response.body);
    dataProduktivitas.value = it.map((e) => DashProcastination.fromJson(e)).toList();
  }
}
