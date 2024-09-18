import 'package:budget_wise/src/data/models/salary.dart';

sealed class UsersState {}

// Initial state when nothing has happened yet
final class InitialState extends UsersState {}

// state : get salary
final class GetSalaryAndDateResetSuccess extends UsersState {
  final Salary data;
  GetSalaryAndDateResetSuccess(this.data);
}

final class GetSalaryAndDateResetLoading extends UsersState {
  GetSalaryAndDateResetLoading();
}

final class GetSalaryAndDateResetFailure extends UsersState {
  final String error;
  GetSalaryAndDateResetFailure(this.error);
}
