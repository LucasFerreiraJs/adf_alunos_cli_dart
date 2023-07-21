import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';

abstract class IProductRepository {
  Future<Course> findByName(String name);
}

class ProductRepository extends IProductRepository {
  @override
  Future<Course> findByName(String name) async {
    print('name recebido $name');
    final response = await http.get(Uri.parse('http://localhost:8080/products?name=$name'));

    if (response.statusCode != 200) {
      throw Exception();
    }

    final responseData = jsonDecode(response.body);
    // responseData['isStudent'] = false;
    print('response ${responseData}');
    if (responseData.isEmpty) {
      throw Exception('Product não encontrado');
    }

    return Course.fromMap(responseData.first);
  }
}
