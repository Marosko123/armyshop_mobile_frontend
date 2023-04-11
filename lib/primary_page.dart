import 'package:armyshop_mobile_frontend/screens/user_account.dart';
import 'package:armyshop_mobile_frontend/screens/user_home.dart';
import 'package:armyshop_mobile_frontend/screens/user_liked_list.dart';
import 'package:armyshop_mobile_frontend/screens/user_search.dart';
import 'package:armyshop_mobile_frontend/screens/user_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({Key? key}) : super(key: key);
  static const routeName = '/products-screen';

  @override
  PrimaryPageState createState() => PrimaryPageState();
}

class PrimaryPageState extends State<PrimaryPage> {
  int _selectedIndex = 0;

  void _navigateToBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const UserHome(),
    const UserLikedList(),
    const UserSearch(),
    const UserShoppingCart(),
    const UserAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Header
              Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BackButton(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          _selectedIndex == 0
                              ? 'Home'
                              : _selectedIndex == 1
                                  ? 'Likes'
                                  : _selectedIndex == 2
                                      ? 'Search'
                                      : _selectedIndex == 3
                                          ? 'Cart'
                                          : 'Account',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),

              // space between login and switch
              const SizedBox(height: 10),
              _pages[_selectedIndex],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: _navigateToBottomBar,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: 'Home',
                padding: EdgeInsets.all(10),
              ),
              GButton(
                icon: Icons.favorite_border,
                text: 'Likes',
                padding: EdgeInsets.all(10),
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
                padding: EdgeInsets.all(10),
              ),
              GButton(
                icon: Icons.shopping_bag_outlined,
                text: 'Cart',
                padding: EdgeInsets.all(10),
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Account',
                padding: EdgeInsets.all(10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
