sealed class UsersEvent {}

// event: get oney infomation
final class GetSalaryEvent extends UsersEvent {
  GetSalaryEvent();
}

// event: get amount data state
final class GetData extends UsersEvent {
  GetData();
}
