import 'package:budget_wise/src/bloc/transactions/transactions_bloc.dart';
import 'package:budget_wise/src/bloc/transactions/transactions_event.dart';
import 'package:budget_wise/src/bloc/transactions/transactions_state.dart';
import 'package:budget_wise/src/presentation/widgets/transaction_item/transacction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTodayTransactionHomepage extends StatelessWidget {
  const ShowTodayTransactionHomepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Dispatch the GetAllAccountsEvent when the widget is built
    context.read<TransactionsBloc>().add(GetTransactionsEvent());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today Transactions"),
        SizedBox(height: 16),

        // TODO : handler height of list item
        BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (BuildContext context, TransactionsState state) {
            if (state is GetTransactionsSuccess) {
              return SizedBox(
                height: 400,
                child: ListView.builder(
                    itemCount: state.transactions.length,
                    itemBuilder: (context, index) =>
                        TransactionItem(state.transactions[index])),
              );
            } else {
              return Center(child: Text("data"));
            }
          },
        ),
      ],
    );
  }
}
