import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/data/models/operation.dart';
import 'package:budget_wise/src/mock/mock_accounts_data.dart';
import 'package:budget_wise/src/presentation/utils/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/utils/generic_column.dart';
import 'package:budget_wise/src/presentation/utils/generic_create_btn.dart';
import 'package:budget_wise/src/presentation/utils/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:flutter/material.dart';

class CreateTransaction extends StatefulWidget {
  final Operation operation;

  const CreateTransaction({super.key, required this.operation});

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _remarkController;
  late TextEditingController _dateController;

  Account? _account;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _remarkController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _remarkController.dispose();
    _dateController.dispose();
    super.dispose();
  }

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
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (int index = 0;
                          index < Mocks.listAccount.length;
                          index++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              handleAccount(Account(
                                accountId: Mocks.listAccount[index].accountId,
                                accountName:
                                    Mocks.listAccount[index].accountName,
                                balance: Mocks.listAccount[index].balance,
                                createDate: Mocks.listAccount[index].createDate,
                                updatePlanDate:
                                    Mocks.listAccount[index].updatePlanDate,
                                colorIndex: 0,
                              ));
                            },
                            child: AccountCard(
                                isSelected: this._account?.accountName ==
                                        Mocks.listAccount[index].accountName
                                    ? true
                                    : false,
                                account: Mocks.listAccount[index]),
                          ),
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
                        print(_titleController.text),
                        print(_dateController.text),
                        print(_remarkController.text),
                        print(_amountController.text),
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
