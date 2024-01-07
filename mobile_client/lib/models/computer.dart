import 'dart:convert';

import 'package:mobile_client/models/gpu.dart';
import 'package:mobile_client/models/ram.dart';

List<Computer> computersFromJson(String str) => List<Computer>.from(json.decode(str).map((x) => Computer.fromJson(x)));

class Computer {
  final String name;
  final String type;
  final String enclosureName;
  final String cpuName;
  final Ram ram;
  final int hardDiskCapacity;
  final Gpu gpu;
  final int powerSupply;
  final int price;

  Computer({required this.name, required this.type, required this.enclosureName, required this.cpuName, required this.ram, required this.hardDiskCapacity, required this.gpu, required this.powerSupply, required this.price});

  factory Computer.fromJson(Map<String, dynamic> json) => Computer(
        name: json["name"],
        type: json["type"],
        enclosureName: json["enclosureName"],
        cpuName: json["cpuName"],
        ram: Ram.fromJson(json["ram"]),
        hardDiskCapacity: json["hardDiskCapacity"],
        gpu: Gpu.fromJson(json["gpu"]),
        powerSupply: json["powerSupply"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "enclosureName": enclosureName,
        "cpuName": cpuName,
        "ram": ram.toJson(),
        "hardDiskCapacity": hardDiskCapacity,
        "gpu": gpu.toJson(),
        "powerSupply": powerSupply,
        "price": price,
      };
}