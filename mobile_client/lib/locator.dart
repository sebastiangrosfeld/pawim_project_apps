import 'package:get_it/get_it.dart';
import 'package:mobile_client/services/auth_service.dart';
import 'package:mobile_client/services/computer_service.dart';
import 'package:mobile_client/services/gpu_service.dart';
import 'package:mobile_client/services/ram_service.dart';

final locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<AuthService>(const AuthService());
  locator.registerSingleton<ComputerService>(const ComputerService());
  locator.registerSingleton<RamService>(const RamService());
  locator.registerSingleton<GpuService>(const GpuService());
}
