import 'package:budget_wise/src/data/models/operation.dart';
import 'package:budget_wise/src/mock/mock_accounts_data.dart';
import 'package:budget_wise/src/presentation/widgets/AccountCard/AccountCard.dart';
import 'package:budget_wise/src/presentation/utils/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/utils/generic_column.dart';
import 'package:budget_wise/src/presentation/utils/generic_row_generic.dart';
import 'package:flutter/material.dart';

class CreateTransacction extends StatelessWidget {
  final Operation operation;

  final TextEditingController _titleController;
  final TextEditingController _ammountController;
  final TextEditingController _remarkController;
  final TextEditingController _dateController;

  CreateTransacction({super.key, required this.operation})
      : _ammountController = TextEditingController(),
        _dateController = TextEditingController(),
        _titleController = TextEditingController(),
        _remarkController = TextEditingController();

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
                          labelText: "title", controller: _titleController),
                      GenericInputField(
                          isDateFied: true,
                          labelText: "date",
                          suffixIcon: const Icon(Icons.date_range_outlined),
                          controller: _dateController)
                    ],
                    gapSize: 20,
                  ),
                  GenericRow(
                    genericWidgets: [
                      GenericInputField(
                          labelText: operation.name,
                          disable: true,
                          prefix: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              operation.icon,
                              const SizedBox(width: 8),
                              Text(operation.name),
                              const SizedBox(width: 12),
                            ],
                          ),
                          controller: _titleController),
                      GenericInputField(
                          isOnlyNumber: true,
                          labelText: "Ammounts",
                          suffixText: "B",
                          controller: _ammountController),
                    ],
                    gapSize: 20,
                  ),
                  GenericInputField(
                      hintText: "Enter your remark",
                      maxLines: 3,
                      minLines: 3,
                      controller: _remarkController),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      for (int index = 0;
                          index < Mocks.listAcount.length;
                          index++)
                        AccountCard(account: Mocks.listAcount[index]),
                    ]),
                  ),
                ],
                gapSize: 20,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding:
                          const EdgeInsets.all(0), // Remove default padding
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(
                                147, 121, 224, 1), // Start color (blue)
                            Color.fromRGBO(174, 120, 214, 1),
                            Color.fromRGBO(
                                215, 128, 225, 1), // End color (blue)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        constraints: const BoxConstraints(minHeight: 50),
                        alignment: Alignment.center,
                        child: const Text(
                          "Create Transaction",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
