import 'package:budget_wise/src/data/models/GeneralError.dart';
import 'package:budget_wise/src/data/models/userFin.dart';

sealed class UsersFinState {}

// Initial state when nothing has happened yet
final class InitialState extends UsersFinState {}

final class ErrorState extends UsersFinState {}

// state : get salary ans month year
final class GetSalaryAndMontYearSuccess extends UsersFinState {
  final UserFin data;
  GetSalaryAndMontYearSuccess(this.data);
}

final class GetSalaryAndMontYearLoading extends UsersFinState {
  GetSalaryAndMontYearLoading();
}

final class GetSalaryAndMontYearFailure extends UsersFinState {
  final GeneralError error;
  GetSalaryAndMontYearFailure(this.error);
}
