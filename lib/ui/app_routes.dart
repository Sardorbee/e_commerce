// import 'package:e_commerce/ui/cart_page/cart_page.dart';
// import 'package:e_commerce/ui/favorite_page/favourite_page.dart';
// import 'package:e_commerce/ui/home_page/home_page.dart';
// import 'package:e_commerce/ui/login_page/login_page.dart';
// import 'package:e_commerce/ui/profile_page/profile_page.dart';
// import 'package:flutter/material.dart';

// class RouteNames {
//   static const String home = "/";
//   static const String profile = "/profile";
//   static const String favourite = "/favourite";
//   static const String details = "/details";
//   static const String login = "/login";
//   static const String cartpage = "/cartpage";
//   // static const String favourite = "/product_details";
// }

// class AppRoutes {
//   static Route generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case RouteNames.home:
//         return MaterialPageRoute(builder: (context) => const HomePage());
//       case RouteNames.profile:
//         return MaterialPageRoute(builder: (context) => const ProfilePage());

//       // Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;

//       // return ProductsScreen(
//       //   prodcuts: map["products"],
//       //   number: map["number"],
//       // );

//       case RouteNames.favourite:
//         return MaterialPageRoute(builder: (context) => const FavouritePage());
//       case RouteNames.details:
//         // return MaterialPageRoute(builder: (context) =>  DetailsPage());
//       case RouteNames.login:
//         return MaterialPageRoute(builder: (context) => LoginPage());
//       case RouteNames.cartpage:
//         return MaterialPageRoute(builder: (context) => const CartPage());
//       default:
//         return MaterialPageRoute(
//           builder: (context) => const Scaffold(
//             body: Center(
//               child: Text("Route mavjud emas"),
//             ),
//           ),
//         );
//     }
//   }
// }
