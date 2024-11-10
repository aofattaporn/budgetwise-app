import 'package:budget_wise/src/bloc/transactions/transactions_event.dart';
import 'package:budget_wise/src/bloc/transactions/transactions_state.dart';
import 'package:budget_wise/src/models/entity/transaction_entity.dart';
import 'package:budget_wise/src/repositories/transactions_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionsRepository _transactionsRepository =
      TransactionsRepository();

  // Constructor to initialize the PlansBloc with a repository
  TransactionsBloc() : super(InitialState()) {
    // Event handler for fetching all transactions
    on<GetTransactionsEvent>((event, emit) async {
      emit(GetTransactionsLoading());
      try {
        final List<TransactionEntity> ts =
            await _transactionsRepository.getTransactions();
        emit(GetTransactionsSuccess(ts));
      } catch (error) {
        emit(GetTransactionsFailed(error.toString()));
      }
    });

    on<CreateTransactionsEvent>((event, emit) async {
      emit(GetTransactionsLoading());
      try {
        final List<TransactionEntity> ts =
            await _transactionsRepository.createTransactions(event.transaction);
        emit(GetTransactionsSuccess(ts));
      } catch (error) {
        emit(GetTransactionsFailed(error.toString()));
      }
    });
  }
}
