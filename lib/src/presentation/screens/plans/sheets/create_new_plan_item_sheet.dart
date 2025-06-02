import 'package:budget_wise/features/plan/data/models/plan_item_dto.dart';
import 'package:budget_wise/features/plan/data/models/plan_item_insert_dto.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
import 'package:budget_wise/src/presentation/common/custom_common_dailog.dart';
import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
import 'package:budget_wise/src/presentation/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrEditPlanItemSheet extends StatefulWidget {
  final String planId;
  final PlanItemDto? planItemDto;

  const CreateOrEditPlanItemSheet({
    super.key,
    required this.planId,
    this.planItemDto,
  });

  @override
  State<CreateOrEditPlanItemSheet> createState() =>
      _CreateOrEditPlanItemSheetState();
}

class _CreateOrEditPlanItemSheetState extends State<CreateOrEditPlanItemSheet> {
  late TextEditingController planNameController;
  late TextEditingController amountController;

  String selectedType = 'expense';
  String? selectedIcon;

  final List<String> types = ['expense', 'saving'];
  final List<String> iconOptions = ['🛒', '💰', '🍔', '🚗', '🏠'];

  bool get isFormValid =>
      planNameController.text.isNotEmpty &&
      amountController.text.isNotEmpty &&
      selectedIcon != null;

  bool get isEdit => widget.planItemDto != null;

  @override
  void initState() {
    super.initState();
    final item = widget.planItemDto;
    planNameController = TextEditingController(text: item?.name ?? '');
    amountController =
        TextEditingController(text: item?.amountLimit.toString() ?? '');
    selectedType = item?.type ?? 'expense';
    selectedIcon = item?.iconName;
  }

  @override
  void dispose() {
    planNameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _onSubmitPressed() {
    if (!isFormValid) return;

    if (isEdit) {
      final updated = widget.planItemDto!.copyWith(
        name: planNameController.text,
        amountLimit: double.parse(amountController.text),
        type: selectedType,
        iconName: selectedIcon,
      );

      context.read<PlanItemBloc>().add(UpdatePlanItem(updated));
    } else {
      final newItem = PlanItemInsertDto(
        planId: widget.planId,
        name: planNameController.text,
        amountLimit: double.parse(amountController.text),
        type: selectedType,
        iconName: selectedIcon,
      );
      context.read<PlanItemBloc>().add(CreatePlanItem(newItem));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: types.map((type) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ChoiceChip(
                        label: Text(
                          type[0].toUpperCase() + type.substring(1),
                          style: TextStyle(
                            color: selectedType == type
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        selected: selectedType == type,
                        onSelected: (_) => setState(() => selectedType = type),
                        selectedColor: Theme.of(context).primaryColor,
                        backgroundColor: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (isEdit)
                  GestureDetector(
                    onTap: () {
                      CustomCommonDialog().confirmDeleteDialog(
                        context,
                        title: "Delete Plan Item",
                        message:
                            "Are you sure you want to delete this plan item? This action cannot be undone.",
                        onConfirm: () {
                          context.read<PlanItemBloc>().add(DeletePlanItem(
                              widget.planItemDto!.id, widget.planId));

                          Navigator.pop(context);
                        },
                      );
                    },
                    child: CommonWidget.boxIcon(
                      iconData: Icons.delete,
                    ),
                  )
              ],
            ),
            const SizedBox(height: 12),

            // Icon Picker
            Wrap(
              spacing: 12,
              children: iconOptions.map((icon) {
                final isSelected = selectedIcon == icon;
                return GestureDetector(
                  onTap: () => setState(() => selectedIcon = icon),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade200,
                    child: Text(icon, style: const TextStyle(fontSize: 20)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),

            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: planNameController,
              label: "Plan Item",
            ),
            const SizedBox(height: 12),

            CustomCommonComponent.labelledTextFieldRow(
              textEditingController: amountController,
              label: "Amount",
              isNumberOnly: true,
            ),
            const Spacer(),
            CustomCommonWidget.commonElevatedBtn(
              isDisable: !isFormValid,
              label: isEdit ? "Update Plan Item" : "Create Plan Item",
              onPressed: _onSubmitPressed,
            ),
          ],
        ),
      ),
    );
  }
}

extension on PlanItemDto {
  PlanItemDto copyWith({
    String? name,
    double? amountLimit,
    String? type,
    String? iconName,
  }) {
    return PlanItemDto(
      id: id,
      planId: planId,
      name: name ?? this.name,
      amountLimit: amountLimit ?? this.amountLimit,
      type: type ?? this.type,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
