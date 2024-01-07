import 'dart:convert';

List<Gpu> gpusFromJson(String str) => List<Gpu>.from(json.decode(str).map((x) => Gpu.fromJson(x)));

class Gpu {
  final String name;
  final int videoRamCapacity;

  Gpu({required this.name, required this.videoRamCapacity});

  factory Gpu.fromJson(Map<String, dynamic> json) => Gpu(
        name: json["name"],
        videoRamCapacity: json["videoRamCapacity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "videoRamCapacity": videoRamCapacity,
      };
}