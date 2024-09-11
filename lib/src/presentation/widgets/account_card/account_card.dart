import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/presentation/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccountCard extends StatefulWidget {
  final bool? isHanlder;
  final bool? isSelected;
  final bool? fullsize;
  final Account account;

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
  bool _isLoading = false;

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Proceed with destructive action?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: _isLoading,
      child: Container(
        height: widget.fullsize == true ? 150 : 120,
        width: widget.fullsize == true
            ? MediaQuery.sizeOf(context).width * 0.9
            : 240,
        // margin: const EdgeInsets.only(left: 5, right: 36, bottom: 20, top: 0),
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
                if (widget.isHanlder ==
                    true) // Show this only if isHandler is true
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Handle edit button press
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 224, 223, 0.1),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () {
                          // Handle delete button press
                          _showAlertDialog(context);
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(255, 224, 223, 0.1),
                          ),
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            Text(
              "Last Operated",
              style: TextStyle(
                  fontSize: 10,
                  color: widget.isSelected == true || widget.isSelected == null
                      ? Colors.white
                      : const Color.fromRGBO(192, 192, 192, 1)),
            ),
            Text(
              "Wed Sep 4 / 2024",
              style: TextStyle(
                  fontSize: 10,
                  color: widget.isSelected == true || widget.isSelected == null
                      ? Colors.white
                      : const Color.fromRGBO(192, 192, 192, 1)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                      text: '${widget.account.balance.toString()} ',
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
    );
  }
}
