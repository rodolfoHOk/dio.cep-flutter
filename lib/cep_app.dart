import 'package:cep_flutter/pages/main_page.dart';
import 'package:flutter/material.dart';

class CepApp extends StatelessWidget {
  const CepApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CEP App',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.green,
          onPrimary: Colors.white,
          surface: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'CEP App'),
    );
  }
}
