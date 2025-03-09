import 'package:budget_wise/src/constant/style/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;
  final String label;

  const DatePicker({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    required this.label,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  void _showCupertinoDatePicker(BuildContext context) {
    DateTime tempDate = _selectedDate ?? DateTime.now(); // Fallback to today

    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 300,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = tempDate;
                      });
                      widget.onDateSelected(_selectedDate!);
                      Navigator.pop(context);
                    },
                    child: const Text("Done", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime:
                      _selectedDate ?? DateTime.now(), // Fallback value
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    tempDate = newDate;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCupertinoDatePicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "${widget.label}: ",
                  style: TextStyles.size14w500, // Style for the label
                ),
                Text(
                  _selectedDate != null
                      ? DateFormat("dd MMM yyyy").format(_selectedDate!)
                      : "-",
                  style: TextStyles
                      .size12w500Primary, // Style for the value (change as needed)
                ),
              ],
            ),
            const Icon(CupertinoIcons.calendar),
          ],
        ),
      ),
    );
  }
}
