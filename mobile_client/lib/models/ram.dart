import 'dart:convert';

List<Ram> ramsFromJson(String str) => List<Ram>.from(json.decode(str).map((x) => Ram.fromJson(x)));

class Ram {
  final String name;
  final int ramCapacity;
  final int memoryRate;

  Ram({required this.name, required this.ramCapacity, required this.memoryRate});

  factory Ram.fromJson(Map<String, dynamic> json) => Ram(
        name: json["name"],
        ramCapacity: json["ramCapacity"],
        memoryRate: json["memoryRate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "ramCapacity": ramCapacity,
        "memoryRate": memoryRate,
      };
}