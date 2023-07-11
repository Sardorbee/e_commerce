import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/ui/tab_page/tab_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  APiProvider aPiProvider = APiProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // onGenerateRoute: AppRoutes.generateRoute(settings),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 133, 94, 199),
        ),
      ),
      home: Tabscreen(apiProvider: aPiProvider),
    );
  }
}
