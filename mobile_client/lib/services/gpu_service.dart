import 'dart:convert';

import 'package:mobile_client/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_client/models/gpu.dart';
import 'package:mobile_client/services/http_headers.dart';

class GpuService {
  const GpuService();

  Future<List<Gpu>> fetchGpus() async {
    final uri = Uri.parse(gpusUrl);
    final response = await http.get(uri, headers: createHttpHeaders());
    return gpusFromJson(response.body);
  }

  Future<void> createGpu(Gpu gpu) async {
    final uri = Uri.parse(gpusUrl);
    await http.post(uri, body: json.encode(gpu.toJson()), headers: createHttpHeaders());
  }

  Future<void> updateGpu(String name, Gpu gpu) async {
    final uri = Uri.parse('$gpusUrl/$name');
    await http.put(uri, body: json.encode(gpu.toJson()), headers: createHttpHeaders());
  }

  Future<void> deleteGpu(Gpu gpu) async {
    final uri = Uri.parse('$gpusUrl/${gpu.name}');
    await http.delete(uri, headers: createHttpHeaders());
  }

  Future<void> deleteAllGpus() async {
    final uri = Uri.parse('$gpusUrl/all');
    await http.delete(uri, headers: createHttpHeaders());
  }
}