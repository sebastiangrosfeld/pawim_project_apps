import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:mobile_client/app_state.dart';
import 'package:mobile_client/locator.dart';
import 'package:mobile_client/models/computer.dart';
import 'package:mobile_client/models/gpu.dart';
import 'package:mobile_client/models/ram.dart';
import 'package:mobile_client/views/scanner.dart';
import 'package:mobile_client/views/computer_form.dart';
import 'package:mobile_client/views/computer_list.dart';
import 'package:mobile_client/views/gpu_form.dart';
import 'package:mobile_client/views/gpu_list.dart';
import 'package:mobile_client/views/login.dart';
import 'package:mobile_client/views/new_password.dart';
import 'package:mobile_client/views/ram_form.dart';
import 'package:mobile_client/views/ram_list.dart';
import 'package:mobile_client/views/register.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  final appState = AppState();
  await appState.loadSettings();

  runApp(ChangeNotifierProvider.value(
    value: appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) => MaterialApp(
        title: 'Mobile Client',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(227, 242, 253, 1)),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: appState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('pl'),
        ],
        localizationsDelegates: const <LocalizationsDelegate>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          Intl.defaultLocale = appState.locale.toLanguageTag();
          return appState.locale;
        },
        locale: appState.locale,
        routes: {
          '/': (context) => const Login(),
          '/computers':(context) => const ComputerList(),
          '/computer-form':(context) {
            var computer = ModalRoute.of(context)!.settings.arguments as Computer?;
            return ComputerForm(computer: computer);
          },
          '/rams':(context) => const RamList(),
          '/ram-form':(context) {
            var ram = ModalRoute.of(context)!.settings.arguments as Ram?;
            return RamForm(ram: ram);
          },
          '/gpus':(context) => const GpuList(),
          '/gpu-form':(context) {
            var gpu = ModalRoute.of(context)!.settings.arguments as Gpu?;
            return GpuForm(gpu: gpu);
          },
          '/change-password':(context) => NewPassword(),
          '/login': (context) => const Login(),
          '/register': (context) => const Register(),
          '/scanner': (context) => const Scanner(),
        },
      ),
    );
  }
}
