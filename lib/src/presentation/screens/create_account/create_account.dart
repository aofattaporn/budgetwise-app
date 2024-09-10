import 'package:budget_wise/src/data/models/Account.dart';
import 'package:budget_wise/src/data/models/color_gradients.dart';
import 'package:budget_wise/src/mock/mock_accounts_data.dart';
import 'package:budget_wise/src/presentation/utils/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/utils/generic_column.dart';
import 'package:budget_wise/src/presentation/utils/generic_create_btn.dart';
import 'package:budget_wise/src/presentation/utils/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/AccountCard/account_card.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;

  CreateAccount({super.key})
      : titleController = TextEditingController(),
        amountController = TextEditingController();

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  ColorGradients? selectedColorGradient;

  @override
  void initState() {
    super.initState();
    widget.titleController.addListener(_onTextChanged);
    widget.amountController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.titleController.removeListener(_onTextChanged);
    widget.amountController.removeListener(_onTextChanged);
    widget.titleController.dispose();
    widget.amountController.dispose();
    super.dispose();
  }

  void _onTextChanged() => setState(() {});

  void _onColorSelected(int index) {
    setState(() {
      selectedColorGradient = Mocks().colorGradients[index];
    });
  }

  Widget _buildColorOption(int index) {
    final gradient = Mocks().colorGradients[index];
    return GestureDetector(
      onTap: () => _onColorSelected(index),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 48,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                colors: [gradient.startColor, gradient.endColor]),
          ),
        ),
      ),
    );
  }

  Widget _buildColorSelectionRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            List.generate(Mocks().colorGradients.length, _buildColorOption),
      ),
    );
  }

  Color _getSelectedStartColor() {
    return selectedColorGradient?.startColor ??
        const Color.fromARGB(255, 29, 28, 30);
  }

  Color _getSelectedEndColor() {
    return selectedColorGradient?.endColor ??
        const Color.fromARGB(255, 29, 28, 30);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      padding: const EdgeInsets.only(top: 60),
      color: const Color.fromRGBO(250, 250, 250, 1),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GenericColumn(
                genericWidgets: [
                  AccountCard(
                    fullsize: true,
                    isSelected: selectedColorGradient != null,
                    account: Account(
                      widget.titleController.text,
                      double.tryParse(widget.amountController.text) ?? 0.0,
                      DateTime.now(),
                      _getSelectedStartColor(),
                      _getSelectedEndColor(),
                    ),
                  ),
                  GenericRow(
                    genericWidgets: [
                      GenericInputField(
                        labelText: "Account name",
                        controller: widget.titleController,
                      ),
                      GenericInputField(
                        labelText: "Amounts",
                        isOnlyNumber: true,
                        suffixText: "B",
                        controller: widget.amountController,
                      ),
                    ],
                    gapSize: 16,
                  ),
                ],
                gapSize: 16,
              ),
              _buildColorSelectionRow(),
              const Spacer(),
              GenericCreateBTN(title: "create account", onPressed: () => {}),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
