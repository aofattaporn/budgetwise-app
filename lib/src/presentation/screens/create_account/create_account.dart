import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/models/entity/budget_account_entity.dart';
import 'package:budget_wise/src/models/color_gradients.dart';
import 'package:budget_wise/src/presentation/constant/colors.dart';
import 'package:budget_wise/src/presentation/ui/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/ui/generic_column.dart';
import 'package:budget_wise/src/presentation/ui/generic_btn.dart';
import 'package:budget_wise/src/presentation/ui/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccount extends StatefulWidget {
  final BudgetAccountEntity? account;
  final TextEditingController titleController;
  final TextEditingController amountController;

  CreateAccount({super.key, this.account})
      : titleController = TextEditingController(
            text: account != null ? account.accountName : ''),
        amountController = TextEditingController(
            text: account != null ? account.balance.toString() : '');

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  ColorGradients? selectedColorGradient;
  int? selectedColorGradient2;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with account data if in edit mode
    if (widget.account != null) {
      selectedColorGradient2 = widget.account!.colorIndex;
      selectedColorGradient =
          ColorConstants.colorGradients[selectedColorGradient2!];
    }

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
  Widget build(BuildContext context) {
    // Check if this is edit mode or create mode
    final bool isEditMode = widget.account != null;

    return BlocListener<AccountBloc, AccountState>(
      listener: (context, AccountState state) {
        if (state is CreateAccountSuccess || state is UpdateAccountSuccess) {
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
                    account: BudgetAccountEntity(
                      accountId: isEditMode
                          ? widget.account!.accountId
                          : DateTime.now().millisecondsSinceEpoch,
                      accountName: widget.titleController.text,
                      balance:
                          double.tryParse(widget.amountController.text) ?? 0.0,
                      createDate: isEditMode
                          ? widget.account!.createDate
                          : DateTime.now(),
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
                    disable: false,
                    title: isEditMode ? "Update Account" : "Create Account",
                    onPressed: () {
                      if (isEditMode) {
                        context.read<AccountBloc>().add(UpdateAccountByIdEvent(
                                account: BudgetAccountEntity(
                              accountId: widget.account!.accountId,
                              accountName: widget.titleController.text,
                              balance: double.tryParse(
                                      widget.amountController.text) ??
                                  0.0,
                              colorIndex: selectedColorGradient2 ?? 0,
                              createDate: widget.account!.createDate,
                              updatePlanDate: DateTime.now(),
                            )));
                      } else {
                        context.read<AccountBloc>().add(CreateAccountEvent(
                            account: BudgetAccountEntity.forCreation(
                                accountName: widget.titleController.text,
                                balance: double.tryParse(
                                        widget.amountController.text) ??
                                    0.0,
                                colorIndex: selectedColorGradient2 ?? 0)));
                      }
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
