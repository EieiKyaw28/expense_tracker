import 'package:equatable/equatable.dart';

class ExpenseFamilyModel extends Equatable {
  final int month;
  final int year;

  const ExpenseFamilyModel({
    required this.month,
    required this.year,
  });

  @override
  List<Object> get props => [month, year];
}
