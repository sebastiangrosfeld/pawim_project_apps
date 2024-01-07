import 'dart:convert';

import 'package:mobile_client/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_client/models/computer.dart';
import 'package:mobile_client/services/http_headers.dart';

class ComputerService {
  const ComputerService();

  Future<List<Computer>> fetchComputers() async {
    final uri = Uri.parse(computersUrl);
    final response = await http.get(uri, headers: createHttpHeaders());
    return computersFromJson(response.body);
  }

  Future<void> createComputer(Computer computer) async {
    final uri = Uri.parse(computersUrl);
    await http.post(uri, body: json.encode(computer.toJson()), headers: createHttpHeaders());
  }

  Future<void> updateComputer(String name, Computer computer) async {
    final uri = Uri.parse('$computersUrl/$name');
    await http.put(uri, body: json.encode(computer.toJson()), headers: createHttpHeaders());
  }

  Future<void> deleteComputer(Computer computer) async {
    final uri = Uri.parse('$computersUrl/${computer.name}');
    await http.delete(uri, headers: createHttpHeaders());
  }

  Future<void> deleteAllComputers() async {
    final uri = Uri.parse('$computersUrl/all');
    await http.delete(uri, headers: createHttpHeaders());
  }
}