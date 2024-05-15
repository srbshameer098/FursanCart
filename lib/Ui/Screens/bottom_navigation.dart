import 'package:flutter/material.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Account/account_page.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Cart/cart_page.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Category/category_page.dart';

import 'Bottom_Navigation_Screens/Home/main_home.dart';


class Bottom_Navigation extends StatefulWidget {
  const Bottom_Navigation({super.key});

  @override
  State<Bottom_Navigation> createState() => _Bottom_NavigationState();
}

class _Bottom_NavigationState extends State<Bottom_Navigation> {
  final screens = [const Home_page(), const Category_page(), const Cart_Page(), const Account_page()];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(showUnselectedLabels: true,showSelectedLabels: true,
        selectedItemColor: const Color(0xff000000),unselectedItemColor: const Color(0xff000000),
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items:  [
           BottomNavigationBarItem(icon:Icon(currentindex==0?Icons.home:Icons.home_outlined,color: const Color(0xff264050),) ,label:'Home'),
          BottomNavigationBarItem(
           icon: Icon(currentindex==1?Icons.category:Icons.category_outlined,color:const Color(0xff264050)),label: 'Category'
          ),
          BottomNavigationBarItem(
            icon: Icon(currentindex==2?Icons.shopping_cart:Icons.shopping_cart_outlined,color: const Color(0xff264050),),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(currentindex==3?Icons.account_circle:Icons.account_circle_outlined,color: const Color(0xff264050),),
            label: 'Account',
          ),
        ],
      ),
      body: screens[currentindex],
    );
  }
}
