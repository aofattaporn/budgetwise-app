import 'package:flutter/material.dart';

class IconUtil {
  IconUtil._();

  static Map<String, IconData> allIcons = {
    'home': Icons.home,
    'shopping_cart': Icons.shopping_cart,
    'fastfood': Icons.fastfood,
    'car': Icons.directions_car,
    'savings': Icons.savings,
    'pets': Icons.pets,
    'favorite': Icons.favorite,
    'grocery': Icons.local_grocery_store,
    'gift': Icons.card_giftcard,
    'iphone': Icons.phone_iphone,
    'airplane': Icons.airplanemode_active,
    'fitness': Icons.fitness_center,
    'school': Icons.school,
    'work': Icons.work,
    'cafe': Icons.local_cafe,
  };

  static IconData getIconByName(String name) {
    return allIcons[name] ?? Icons.help_outline;
  }
}
