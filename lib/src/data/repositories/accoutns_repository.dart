import 'package:budget_wise/src/data/providers/accounts_provider.dart';
import 'package:budget_wise/src/data/models/account.dart';

class AccountsRepository {
  final AccountsProvider accountsProvider;

  AccountsRepository({required this.accountsProvider});

  Future<List<Account>> getAllDataThatMeetsRequirements() async {
    try {
      final List<Account> accounts = await accountsProvider.findAllAccounts();
      return accounts;
    } catch (e) {
      throw Exception('Failed to fetch or process accounts: $e');
    }
  }
}
