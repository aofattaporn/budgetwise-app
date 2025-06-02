import 'package:budget_wise/features/transaction/domain/usecases/create_transaction_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/get_all_transactions_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/get_transactions_by_date_range_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/get_transaction_by_id_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:budget_wise/features/transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetAllTransactionsUsecase getAllTransactionsUsecase;
  final GetTransactionsByDateRangeUsecase getTransactionsByDateRangeUsecase;
  final GetTransactionByIdUsecase getTransactionByIdUsecase;
  final CreateTransactionUsecase createTransactionUsecase;
  final UpdateTransactionUsecase updateTransactionUsecase;
  final DeleteTransactionUsecase deleteTransactionUsecase;

  TransactionBloc({
    required this.getAllTransactionsUsecase,
    required this.getTransactionsByDateRangeUsecase,
    required this.getTransactionByIdUsecase,
    required this.createTransactionUsecase,
    required this.updateTransactionUsecase,
    required this.deleteTransactionUsecase,
  }) : super(TransactionInitial()) {
    on<FetchAllTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await getAllTransactionsUsecase();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to load transactions"));
      }
    });

    on<FetchTransactionsByDateRange>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions =
            await getTransactionsByDateRangeUsecase(event.start, event.end);
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to load transactions by date range"));
      }
    });

    on<CreateTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await createTransactionUsecase.call(event.dto);
        final transactions = await getAllTransactionsUsecase();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to create transaction"));
      }
    });

    on<UpdateTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await updateTransactionUsecase(event.dto);
        final transactions = await getAllTransactionsUsecase();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to update transaction"));
      }
    });

    on<DeleteTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await deleteTransactionUsecase(event.id);
        final transactions = await getAllTransactionsUsecase();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError("Failed to delete transaction"));
      }
    });
  }
}
