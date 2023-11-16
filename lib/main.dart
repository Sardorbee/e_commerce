import 'package:e_commerce/db_bloc/db_bloc.dart';
import 'package:e_commerce/ui/splash_page/splash.dart';
// import 'package:flutter/material.dart';

// void main() async {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({
//     super.key,
//   });

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   APiProvider aPiProvider = APiProvider();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // onGenerateRoute: AppRoutes.generateRoute(settings),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(255, 133, 94, 199),
//         ),
//       ),
//       home: SplashPage(),
//       // Tabscreen(apiProvider: aPiProvider)
//       // ,
//     );
//   }
// }

import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/ui/tab_page/tab_page.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => DbBloc(),
    )
  ], child: const MyApp()));

  await GetStorage.init();
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          background: AppColors.mainBg,
          seedColor: AppColors.mainBg,
        ),
      ),
      home: Builder(
        builder: (context) {
          return Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) =>
                    // LoginPage()
                    Tabscreen(apiProvider: aPiProvider),
              );
            },
          );
        },
      ),
    );
  }
}
