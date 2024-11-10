import 'package:budget_wise/src/bloc/transactions/transactions_bloc.dart';
import 'package:budget_wise/src/bloc/transactions/transactions_event.dart';
import 'package:budget_wise/src/models/entity/budget_account_entity.dart';
import 'package:budget_wise/src/models/operation.dart';
import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:budget_wise/src/models/entity/transaction_entity.dart';
import 'package:budget_wise/src/presentation/ui/generic_input_field.dart';
import 'package:budget_wise/src/presentation/ui/generic_column.dart';
import 'package:budget_wise/src/presentation/ui/generic_btn.dart';
import 'package:budget_wise/src/presentation/ui/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/select_all_accounts/select_all_accounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransaction extends StatefulWidget {
  final OperationModel operation;

  const CreateTransaction({super.key, required this.operation});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _remarkController;
  late TextEditingController _dateController;
  late BudgetAccountEntity? _accountVisit;
  late PlanEntity? _planningVisit;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _remarkController = TextEditingController();
    _dateController = TextEditingController();
    _accountVisit = null;
    _planningVisit = null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _remarkController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void handleAccount(BudgetAccountEntity account) {
    setState(() {
      _accountVisit = account;
    });
  }

  void handlePlanning(PlanEntity planning) {
    setState(() {
      _planningVisit = planning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      color: const Color.fromRGBO(250, 250, 250, 1),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context)),
          title: const Text(
            "Transaction",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 35),
              GenericColumn(
                genericWidgets: [
                  GenericRow(
                    genericWidgets: [
                      GenericInputField(
                          labelText: "Title", controller: _titleController),
                      GenericInputField(
                          isDateField: true,
                          labelText: "Date",
                          suffixIcon: const Icon(Icons.date_range_outlined),
                          controller: _dateController)
                    ],
                    gapSize: 20,
                  ),
                  GenericRow(
                    genericWidgets: [
                      GenericInputField(
                          labelText: widget.operation.name,
                          disable: true,
                          prefix: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.operation.icon,
                              const SizedBox(width: 8),
                              Text(widget.operation.name),
                              const SizedBox(width: 12),
                            ],
                          ),
                          controller: _titleController),
                      GenericInputField(
                          isOnlyNumber: true,
                          labelText: "Amounts",
                          suffixText: "B",
                          controller: _amountController),
                    ],
                    gapSize: 20,
                  ),
                  GenericInputField(
                      hintText: "Enter your remark",
                      maxLines: 3,
                      minLines: 3,
                      controller: _remarkController),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 215, 213, 213),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(_planningVisit?.name ?? "planning")),
                    ),
                  ),
                  SelectAllAccounts(
                    accountVisit: _accountVisit,
                    onAccountSelected: handleAccount,
                  ),
                ],
                gapSize: 20,
              ),
              const Spacer(),
              GenericCreateBTN(
                  disable: false,
                  title: "Create Transaction",
                  onPressed: () => {
                        context.read<TransactionsBloc>().add(
                            CreateTransactionsEvent(TransactionEntity.create(
                                name: _titleController.text,
                                amount:
                                    double.tryParse(_amountController.text) ??
                                        0.0,
                                operation: widget.operation.name,
                                planId: _planningVisit?.planId ?? 0,
                                accountId: _accountVisit?.accountId ?? 0)))
                      }),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
