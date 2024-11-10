import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/models/entity/budget_account_entity.dart';
import 'package:budget_wise/src/presentation/constant/colors.dart';
import 'package:budget_wise/src/presentation/screens/account_details/create_account/create_account.dart';
import 'package:budget_wise/src/presentation/ui/generic_alert_dialog.dart';
import 'package:budget_wise/src/presentation/ui/generic_circle_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccountCard extends StatefulWidget {
  final bool? isHanlder;
  final bool? isSelected;
  final bool? fullsize;
  final BudgetAccountEntity account;

  const AccountCard({
    super.key,
    this.isHanlder,
    this.isSelected,
    this.fullsize,
    required this.account,
  });

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  // late Account selectedAccount;
  bool _isLoading = false;

  String formatNumber(String rawNumber) {
    String cleanedValue = rawNumber.replaceAll(RegExp(r'[^\d.]'), '');

    if (cleanedValue.isEmpty || cleanedValue == '.') return '';
    List<String> parts = cleanedValue.split('.');
    final NumberFormat formatter = NumberFormat('#,###');
    String formattedIntegerPart = formatter.format(int.parse(parts[0]));
    if (parts.length > 1) {
      String decimalPart = parts[1];
      return '$formattedIntegerPart.$decimalPart';
    }

    return formattedIntegerPart;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (BuildContext context, AccountState state) {
        if (state is UpdateAccountSuccess) {}
      },
      child: Skeletonizer(
        enabled: _isLoading,
        child: Container(
          height: widget.fullsize == true ? 150 : 120,
          width: widget.fullsize == true
              ? MediaQuery.sizeOf(context).width * 0.9
              : 240,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: const Alignment(0.8, 1),
                colors:
                    ((widget.isSelected == true || widget.isSelected == null) &&
                            !_isLoading)
                        ? [
                            ColorConstants
                                .colorGradients[widget.account.colorIndex]
                                .startColor,
                            ColorConstants
                                .colorGradients[widget.account.colorIndex]
                                .endColor,
                          ]
                        : [
                            const Color.fromRGBO(250, 240, 240, 1),
                            const Color.fromRGBO(225, 234, 238, 1)
                          ]),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: (widget.isSelected == true || widget.isSelected == null)
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.grey.withOpacity(0),
                spreadRadius: 5,
                blurRadius: 12,
                offset: const Offset(3, 6),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.account.accountName.isEmpty
                        ? "Account Name"
                        : widget.account.accountName,
                    style: TextStyle(
                      fontSize: widget.fullsize == true ? 18 : null,
                      fontWeight: FontWeight.bold,
                      color:
                          widget.isSelected == true || widget.isSelected == null
                              ? Colors.white
                              : const Color.fromRGBO(192, 192, 192, 1),
                    ),
                  ),

                  // Conditional display of the operation buttons based on widget.isHandler
                  if (widget.isHanlder == true) _rowHandlerCard(context),
                ],
              ),
              Text(
                "Last Operated",
                style: TextStyle(
                    fontSize: 10,
                    color:
                        widget.isSelected == true || widget.isSelected == null
                            ? Colors.white
                            : const Color.fromRGBO(192, 192, 192, 1)),
              ),
              Text(
                "Wed Sep 4 / 2024",
                style: TextStyle(
                    fontSize: 10,
                    color:
                        widget.isSelected == true || widget.isSelected == null
                            ? Colors.white
                            : const Color.fromRGBO(192, 192, 192, 1)),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                        text:
                            '${formatNumber(widget.account.balance.toString())}',
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.isSelected == true ||
                                  widget.isSelected == null
                              ? Colors.white
                              : const Color.fromRGBO(192, 192, 192, 1),
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'B',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _rowHandlerCard(BuildContext context) {
    final String confirmDelete = "Confirm Deletion";
    final String confirmDeleteDesc = "Proceed with destructive action?";

    return Row(
      children: [
        GenericCircleIcons(
            isDarkTheme: true,
            customIcon: Icons.edit,
            onhandle: () => {
                  showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return CreateAccount(account: widget.account);
                    },
                  )
                }),
        const SizedBox(
          width: 12,
        ),
        GenericCircleIcons(
            isDarkTheme: true,
            customIcon: Icons.delete,
            onhandle: () => {
                  AlertDialogUtils.showAlertDialog(
                      context: context,
                      title: confirmDelete,
                      content: confirmDeleteDesc,
                      onConfirm: () => {
                            context.read<AccountBloc>().add(
                                DeleteAccountsByIdEvent(
                                    accountId: widget.account.accountId ?? -1))
                          },
                      onCancel: () {
                        Navigator.pop(context);
                      })
                })
      ],
    );
  }
}
