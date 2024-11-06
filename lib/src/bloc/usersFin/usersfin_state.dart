import 'package:budget_wise/src/models/internal/general_error.dart';
import 'package:budget_wise/src/models/entity/user_budget_info_entity.dart';

sealed class UsersFinState {}

// Initial state when nothing has happened yet
final class InitialState extends UsersFinState {}

final class ErrorState extends UsersFinState {}

// state : get salary ans month year
final class GetSalaryAndMontYearSuccess extends UsersFinState {
  final UserBudgetInfoEntity data;
  GetSalaryAndMontYearSuccess(this.data);
}

final class GetSalaryAndMontYearLoading extends UsersFinState {
  GetSalaryAndMontYearLoading();
}

final class GetSalaryAndMontYearFailure extends UsersFinState {
  final GeneralError error;
  GetSalaryAndMontYearFailure(this.error);
}
