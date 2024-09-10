// events.dart
sealed class AccountsEvent {}

// Define your specific event(s)
final class CreateAccountEvent extends AccountsEvent {}

final class GetAllAccountsEvent extends AccountsEvent {}
