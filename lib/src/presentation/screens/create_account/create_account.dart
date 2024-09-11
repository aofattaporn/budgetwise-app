import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/data/models/color_gradients.dart';
import 'package:budget_wise/src/presentation/constant/colors.dart';
import 'package:budget_wise/src/presentation/utils/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/utils/generic_column.dart';
import 'package:budget_wise/src/presentation/utils/generic_create_btn.dart';
import 'package:budget_wise/src/presentation/utils/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  int? selectedColorGradient2;

  @override
  void initState() {
    super.initState();
    widget.titleController.addListener(_onTextChanged);
    widget.amountController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    widget.titleController.removeListener(_onTextChanged);
    widget.amountController.removeListener(_onTextChanged);
    widget.titleController.dispose();
    widget.amountController.dispose();
    super.dispose();
  }

  void _onColorSelected(int index) {
    setState(() {
      selectedColorGradient2 = index;
      selectedColorGradient = ColorConstants.colorGradients[index];
    });
  }

  Widget _buildColorOption(int index) {
    final gradient = ColorConstants.colorGradients[index];
    return GestureDetector(
      onTap: () => _onColorSelected(index),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 48,
          width: 48,
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
        children: List.generate(
            ColorConstants.colorGradients.length, _buildColorOption),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, AccountState state) {
        if (state is CreateAccountSuccess) {
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(24),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GenericColumn(
                gapSize: 16,
                genericWidgets: [
                  AccountCard(
                    fullsize: true,
                    isSelected: selectedColorGradient != null,
                    account: Account(
                      accountId: DateTime.now().millisecondsSinceEpoch,
                      accountName: widget.titleController.text, // Updated name
                      balance: double.tryParse(widget.amountController.text) ??
                          0.0, // Updated balance
                      createDate: DateTime.now(),
                      updatePlanDate: DateTime.now(),
                      colorIndex: selectedColorGradient2 ?? 0,
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
                  _buildColorSelectionRow(),
                  GenericCreateBTN(
                    title: "Create Account",
                    onPressed: () => {
                      context.read<AccountBloc>().add(CreateAccountEvent(
                          account: Account.forCreation(
                              accountName: widget.titleController.text,
                              balance: double.tryParse(
                                      widget.amountController.text) ??
                                  0.0,
                              colorIndex: selectedColorGradient2 ?? 0)))
                    },
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
