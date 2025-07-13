import 'package:expense_tracker/constant/my_image.dart';
import 'package:flutter/material.dart';

class CommonExpenseModel {
  final String title;
  final String image;
  final String slug;

  CommonExpenseModel({
    required this.title,
    required this.image,
    required this.slug,
  });
}

List<CommonExpenseModel> commonExpenseList = [
  CommonExpenseModel(
    title: "Food",
    image: MyImage.food,
    slug: 'food',
  ),
  CommonExpenseModel(
    title: "Bills",
    image: MyImage.bill,
    slug: 'bill',
  ),
  CommonExpenseModel(
    title: "Health Care",
    image: MyImage.health,
    slug: 'health',
  ),
  CommonExpenseModel(
    title: "Eudcation",
    image: MyImage.education,
    slug: 'education',
  ),
  CommonExpenseModel(
    title: "Entertainment",
    image: MyImage.entertainment,
    slug: 'entertainment',
  ),
  CommonExpenseModel(
    title: "Transporation",
    image: MyImage.transporation,
    slug: 'transporation',
  ),
  CommonExpenseModel(
    title: "Shopping",
    image: MyImage.shopping,
    slug: 'shopping',
  ),
  CommonExpenseModel(
    title: "Other",
    image: MyImage.expenseIcon,
    slug: 'other',
  ),
];

String searchExpenseIconBySlug(String slug) {
  switch (slug) {
    case 'food':
      return MyImage.food;
    case 'bill':
      return MyImage.bill;
    case 'health':
      return MyImage.health;

    case 'education':
      return MyImage.education;

    case 'entertainment':
      return MyImage.entertainment;

    case 'transporation':
      return MyImage.transporation;
    case 'shopping':
      return MyImage.shopping;
    case 'other':
      return MyImage.expenseIcon;

    default:
      return MyImage.expenseIcon;
  }
}
