import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String numberFormatter(String number) {
  final formatter = NumberFormat('#,##0.${"#" * 2}');
  return formatter.format(double.tryParse(number) ?? 0);
}

String accountFormatter(String number) {
  // Remove any existing spaces, dashes, or other special characters from the account number
  String cleanedAccountNumber = number.replaceAll(RegExp(r'[^\d]'), '');

  // Create a number format instance for formatting the account number
  StringBuffer formattedAccountNumber = StringBuffer();

  // Format the cleaned account number using the number format instance
  // Insert dashes after every four digits from the end of the number

  int remainingDigits = cleanedAccountNumber.length % 4;
  if (remainingDigits > 0) {
    formattedAccountNumber
        .write(cleanedAccountNumber.substring(0, remainingDigits));
    if (cleanedAccountNumber.length > remainingDigits) {
      formattedAccountNumber.write('-');
    }
  }
  for (int i = remainingDigits; i < cleanedAccountNumber.length; i += 4) {
    int endIndex = i + 4;
    formattedAccountNumber.write(cleanedAccountNumber.substring(i, endIndex));
    if (endIndex < cleanedAccountNumber.length) {
      formattedAccountNumber.write('-');
    }
  }

  return formattedAccountNumber.toString();
}
