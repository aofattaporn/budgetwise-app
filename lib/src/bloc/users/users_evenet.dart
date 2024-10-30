sealed class UsersEvent {}

// event: get oney infomation
final class GetSalaryEvent extends UsersEvent {
  final String monthYear;
  GetSalaryEvent({required this.monthYear});
}

// event: get oney infomation
final class AddSalaryByMonthEvent extends UsersEvent {
  final double balance;
  AddSalaryByMonthEvent({required this.balance});
}

// event: get amount data state
final class GetData extends UsersEvent {
  GetData();
}
