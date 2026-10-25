import 'package:flutter/material.dart';

class CategoryItem {
  final String name;
  final IconData icon;
  const CategoryItem(this.name, this.icon);
}

const List<CategoryItem> kCategories = [
  CategoryItem('Makanan Utama', Icons.rice_bowl),
  CategoryItem('Sup', Icons.soup_kitchen),
  CategoryItem('Bakar', Icons.local_fire_department),
  CategoryItem('Camilan', Icons.cookie),
  CategoryItem('Minuman', Icons.local_cafe),
];