import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/features/transaction/domain/usecases/transaction_usecase.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionUsecase transactionUsecase;
  TransactionBloc(this.transactionUsecase) : super(TransactionInitial()) {
    on<FetchAllTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await transactionUsecase.getAllTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to load transactions"));
      }
    });

    on<FetchTransactionsByDateRange>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await transactionUsecase
            .getTransactionsByDateRange(event.start, event.end);
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to load transactions by date range"));
      }
    });

    on<CreateTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await transactionUsecase.createTransaction(event.dto);
        final transactions = await transactionUsecase.getAllTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to create transaction"));
      }
    });

    on<UpdateTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await transactionUsecase.updateTransaction(event.dto);
        final transactions = await transactionUsecase.getAllTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to update transaction"));
      }
    });

    on<DeleteTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await transactionUsecase.deleteTransaction(event.id);
        final transactions = await transactionUsecase.getAllTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to delete transaction"));
      }
    });
  }
}
