// ignore: file_names
sealed class UsersEvent {}

// event: get oney infomation
final class GetSalaryEvent extends UsersEvent {
  final String monthYear;
  GetSalaryEvent({required this.monthYear});
}

// event: get oney infomation
final class AddSalaryByMonthEvent extends UsersEvent {
  final double balance;
  final DateTime monthYear;
  AddSalaryByMonthEvent({required this.balance, required this.monthYear});
}

// event: get amount data state
final class GetData extends UsersEvent {
  GetData();
}
