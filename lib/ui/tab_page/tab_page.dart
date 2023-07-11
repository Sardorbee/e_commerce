import 'package:e_commerce/services/apis/all_products.dart';
import 'package:e_commerce/ui/cart_page/cart_page.dart';
import 'package:e_commerce/ui/favorite_page/favourite_page.dart';
import 'package:e_commerce/ui/home_page/home_page.dart';
import 'package:e_commerce/ui/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

class Tabscreen extends StatefulWidget {
  const Tabscreen({super.key,required this.apiProvider});
  final APiProvider apiProvider;

  @override
  State<Tabscreen> createState() => _TabscreenState();
}

class _TabscreenState extends State<Tabscreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    _pages.add( HomePage(apiProvider: widget.apiProvider,));
    _pages.add(const FavouritePage());
    _pages.add(const CartPage());
    _pages.add( ProfilePage(apiProvider: widget.apiProvider,));
    super.initState();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
