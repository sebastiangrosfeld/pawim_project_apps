import 'dart:convert';

import 'package:mobile_client/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_client/models/ram.dart';
import 'package:mobile_client/services/http_headers.dart';

class RamService {
  const RamService();

  Future<List<Ram>> fetchRams() async {
    final uri = Uri.parse(ramsUrl);
    final response = await http.get(uri, headers: createHttpHeaders());
    return ramsFromJson(response.body);
  }

  Future<void> createRam(Ram ram) async {
    final uri = Uri.parse(ramsUrl);
    await http.post(uri, body: json.encode(ram.toJson()), headers: createHttpHeaders());
  }

  Future<void> updateRam(String name, Ram ram) async {
    final uri = Uri.parse('$ramsUrl/$name');
    await http.put(uri, body: json.encode(ram.toJson()), headers: createHttpHeaders());
  }

  Future<void> deleteRam(Ram ram) async {
    final uri = Uri.parse('$ramsUrl/${ram.name}');
    await http.delete(uri, headers: createHttpHeaders());
  }

  Future<void> deleteAllRams() async {
    final uri = Uri.parse('$ramsUrl/all');
    await http.delete(uri, headers: createHttpHeaders());
  }
}