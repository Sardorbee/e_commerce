import 'dart:async';

import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/ui/tab_page/tab_page.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key, required this.aPiProvider}) : super(key: key);
  final APiProvider aPiProvider;
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    // Delay for 4 seconds and navigate to the desired page
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => Tabscreen(
                apiProvider: widget
                    .aPiProvider)), // Replace "YourPage" with the page you want to navigate to
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainBg,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/splash.png",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(19),
            child: const Align(
              alignment: Alignment.bottomLeft,
              child: Flexible(
                child: Text(
                  "Shop Now",
                  style: TextStyle(
                      color: AppColors.primaryButton,
                      fontSize: 95,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
