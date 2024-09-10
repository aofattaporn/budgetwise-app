import 'package:budget_wise/src/data/models/Account.dart';
import 'package:budget_wise/src/presentation/utils/generic_Input_field.dart';
import 'package:budget_wise/src/presentation/utils/generic_column.dart';
import 'package:budget_wise/src/presentation/utils/generic_row_generic.dart';
import 'package:budget_wise/src/presentation/widgets/AccountCard/account_card.dart';
import 'package:flutter/material.dart';

class ColorGredients {
  Color color_start;
  Color color_end;

  ColorGredients(this.color_start, this.color_end);
}

class CreateAccount extends StatefulWidget {
  final TextEditingController _titleController;
  final TextEditingController _amountController;

  CreateAccount({super.key})
      : _titleController = TextEditingController(),
        _amountController = TextEditingController();

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  ColorGredients? colorGredients;

  List<ColorGredients> colors = [
    ColorGredients(
      Color.fromARGB(255, 82, 29, 125),
      Color.fromRGBO(108, 51, 163, 1),
    ),
    ColorGredients(
      const Color.fromRGBO(25, 23, 20, 1),
      const Color.fromRGBO(34, 52, 174, 1),
    ),
    ColorGredients(
      const Color.fromRGBO(0, 0, 0, 1),
      const Color.fromRGBO(22, 109, 59, 1),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Add listeners to update the UI when text changes
    widget._titleController.addListener(_onTextChanged);
    widget._amountController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    widget._titleController.removeListener(_onTextChanged);
    widget._amountController.removeListener(_onTextChanged);
    widget._titleController.dispose();
    widget._amountController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
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
              GenericColumn(genericWidgets: [
                AccountCard(
                  isSelected: false,
                  account: Account(
                    widget._titleController.text,
                    double.tryParse(widget._amountController.text) ?? 0.0,
                    DateTime.now(),
                    const Color.fromARGB(255, 29, 28, 30),
                    const Color.fromRGBO(108, 51, 163, 1),
                  ),
                ),
                GenericRow(genericWidgets: [
                  GenericInputField(
                    labelText: "Account name",
                    controller: widget._titleController,
                  ),
                  GenericInputField(
                    labelText: "Amounts",
                    isOnlyNumber: true,
                    suffixText: "B",
                    controller: widget._amountController,
                  )
                ], gapSize: 16)
              ], gapSize: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  for (int index = 0; index < colors.length; index++) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 48,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            gradient: LinearGradient(colors: [
                              colors[index].color_start,
                              colors[index].color_end,
                            ])),
                      ),
                    )
                  ],
                ]),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(147, 121, 224, 1),
                            Color.fromRGBO(174, 120, 214, 1),
                            Color.fromRGBO(215, 128, 225, 1),
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
