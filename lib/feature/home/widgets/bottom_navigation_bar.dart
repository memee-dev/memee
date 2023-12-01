import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int index;
  final ValueChanged<int>? onTap;

  const HomeBottomNavigation({
    Key? key,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            12.r,
          ),
          topRight: Radius.circular(
            12.r,
          ),
        ),
      ),
      child: NavigationBar(
        onDestinationSelected: onTap,
        indicatorColor: Theme.of(context).colorScheme.primary,
        selectedIndex: index,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10.r,
          ),
        ),
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart_checkout),
            label: 'Cart',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
