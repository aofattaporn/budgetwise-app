import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MonthYearPicker {
  final DateTime initialDate;
  final void Function(DateTime)? onDateSelected;
  final WidgetBuilder? builder;

  MonthYearPicker._({
    required this.initialDate,
    this.onDateSelected,
    this.builder,
  });

  void chooseDate(BuildContext context) async {
    DateTime? selectedDate;
    DateTime tempPickedDate = initialDate;
    selectedDate = await showModalBottomSheet<DateTime>(
      context: context,
      builder: builder ??
          (BuildContext builder) {
            return SizedBox(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: Column(
                children: [
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.monthYear,
                      initialDateTime: initialDate,
                      minimumDate: DateTime(2000),
                      maximumDate: DateTime(2101),
                      onDateTimeChanged: (DateTime newDate) {
                        tempPickedDate = newDate;
                      },
                    ),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () {
                      Navigator.of(context).pop(tempPickedDate);
                    },
                  ),
                ],
              ),
            );
          },
    );
    if (selectedDate != null) {
      onDateSelected?.call(selectedDate);
    }
  }
}

class MonthYearPickerBuilder {
  DateTime? _initialDate;
  void Function(DateTime)? _onDateSelected;
  WidgetBuilder? _builder;

  MonthYearPickerBuilder setInitialDate(DateTime initialDate) {
    _initialDate = initialDate;
    return this;
  }

  MonthYearPickerBuilder setOnDateSelected(
      void Function(DateTime) onDateSelected) {
    _onDateSelected = onDateSelected;
    return this;
  }

  MonthYearPickerBuilder setBuilder(WidgetBuilder builder) {
    _builder = builder;
    return this;
  }

  MonthYearPicker build() {
    if (_initialDate == null) {
      throw ArgumentError('Initial date must be provided');
    }
    return MonthYearPicker._(
      initialDate: _initialDate!,
      onDateSelected: _onDateSelected,
      builder: _builder,
    );
  }
}
