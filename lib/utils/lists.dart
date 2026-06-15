import 'package:flutter/cupertino.dart';
import 'package:onebite_user_app/screens/custom_navbar/cart/cart_screen.dart';
import 'package:onebite_user_app/screens/custom_navbar/favorite/favorite_screen.dart';
import 'package:onebite_user_app/screens/custom_navbar/home/home_screen.dart';
import 'package:onebite_user_app/screens/custom_navbar/orders/order_screen.dart';
import 'package:onebite_user_app/screens/custom_navbar/profile/profile_screen.dart';

List<Widget> screens = [
  HomeScreen(),
  OrdersScreen(),
  CartScreen(),
  FavoriteScreen(),
  ProfileScreen(),
];
