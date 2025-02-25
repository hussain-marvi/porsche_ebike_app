import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:porsche_ebike_app/core/theme_manager.dart';
import 'package:porsche_ebike_app/core/utils/helpers.dart';
import 'package:porsche_ebike_app/core/utils/theme.dart';
import 'package:porsche_ebike_app/features/e-bike/data/services/dependency_injection.dart';
import 'package:porsche_ebike_app/features/e-bike/presentation/views/main_screen.dart';
import 'package:provider/provider.dart' as provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await DependencyInjection().setup();

  requestMacOSPermissions(); // Request BLE & USB permissions
  runApp(ProviderScope(
    // Wrap with ProviderScope (for Riverpod)
    child: provider.MultiProvider(
      // MultiProvider (for ChangeNotifier)
      providers: [
        provider.ChangeNotifierProvider(create: (_) => ThemeManager()),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Porsche E-Bike Diagnostics',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: context.watch<ThemeManager>().isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light, // Listen to ThemeManager for theme mode
      home: const MainScreen(),
    );
  }
}
