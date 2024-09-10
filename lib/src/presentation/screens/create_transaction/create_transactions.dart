import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/data/models/operation.dart';
import 'package:budget_wise/src/mock/mock_accounts_data.dart';
import 'package:budget_wise/src/presentation/utils/generic_create_btn.dart';
import 'package:budget_wise/src/presentation/widgets/AccountCard/account_card.dart';
import 'package:budget_wise/src/presentation/utils/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/utils/generic_column.dart';
import 'package:budget_wise/src/presentation/utils/generic_row_generic.dart';
import 'package:flutter/material.dart';

class CreateTransaction extends StatefulWidget {
  final Operation operation;

  final TextEditingController _titleController;
  final TextEditingController _amountController;
  final TextEditingController _remarkController;
  final TextEditingController _dateController;

  CreateTransaction({super.key, required this.operation})
      : _amountController = TextEditingController(),
        _dateController = TextEditingController(),
        _titleController = TextEditingController(),
        _remarkController = TextEditingController();

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  Account? _account;

  void handleAccount(Account account) {
    setState(() {
      _account = account;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      color: const Color.fromRGBO(250, 250, 250, 1),
      child: Scaffold(
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
                          labelText: "Title",
                          controller: widget._titleController),
                      GenericInputField(
                          isDateFied: true,
                          labelText: "Date",
                          suffixIcon: const Icon(Icons.date_range_outlined),
                          controller: widget._dateController)
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
                          controller: widget._titleController),
                      GenericInputField(
                          isOnlyNumber: true,
                          labelText: "Amounts",
                          suffixText: "B",
                          controller: widget._amountController),
                    ],
                    gapSize: 20,
                  ),
                  GenericInputField(
                      hintText: "Enter your remark",
                      maxLines: 3,
                      minLines: 3,
                      controller: widget._remarkController),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (int index = 0;
                          index < Mocks.listAcount.length;
                          index++)
                        GestureDetector(
                          onTap: () {
                            handleAccount(Account(
                                Mocks.listAcount[index].accountName,
                                Mocks.listAcount[index].Balance,
                                Mocks.listAcount[index].lastOperated,
                                Mocks.listAcount[index].colorStart,
                                Mocks.listAcount[index].colorEnd));
                          },
                          child: AccountCard(
                              isSelected: this._account?.accountName ==
                                      Mocks.listAcount[index].accountName
                                  ? true
                                  : false,
                              account: Mocks.listAcount[index]),
                        ),
                    ]),
                  ),
                ],
                gapSize: 20,
              ),
              const Spacer(),
              GenericCreateBTN(
                  title: "Create Transaction",
                  onPressed: () => {
                        Navigator.pop(context),
                        // Handle transaction creation here
                        print("xxxxxxxxx"),
                        print(widget._titleController.text),
                        print(widget._dateController.text),
                        print(widget._remarkController.text),
                        print(widget._amountController.text),
                        print(_account?.accountName),
                      }),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
