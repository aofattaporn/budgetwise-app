import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/presentation/constant/icons.dart';
import 'package:budget_wise/src/presentation/screens/create_plan_sheet/create_plan_sheet.dart';
import 'package:budget_wise/src/presentation/ui/generic_alert_dialog.dart';
import 'package:budget_wise/src/presentation/widgets/progress_bar/progress_bar.dart';
import 'package:budget_wise/src/utils/numbers_uti.dart';
import 'package:budget_wise/src/utils/strings_util.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/data/models/planning_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ui/generic_circle_icon.dart';

class PlanPocket extends StatefulWidget {
  final bool? isHandler;
  final Planning planning;
  final bool isFullSize;

  PlanPocket({
    required this.isFullSize,
    required this.planning,
    this.isHandler,
    super.key,
  });

  @override
  State<PlanPocket> createState() => _PlanPocketState();
}

class _PlanPocketState extends State<PlanPocket> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PlansBloc, PlansState>(
      listener: (BuildContext context, PlansState state) {
        if (state is DeletePlanSuccess) {
          Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        }
      },
      child: Container(
        height: 150,
        padding: EdgeInsets.all(12),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 15,
              offset: const Offset(3, 6),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: widget.isFullSize ? 58 : 36,
                  width: widget.isFullSize ? 58 : 36,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(240, 240, 240, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(IconConstants.icons[widget.planning.indexIcon],
                      color: Colors.grey, size: widget.isFullSize ? 32 : 20),
                ),
                const SizedBox(width: 10),

                // Wrap the Column in Flexible to prevent overflow
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.planning.name,
                        style: TextStyle(
                          fontSize: widget.isFullSize ? 20 : 14,
                          fontWeight:
                              widget.isFullSize ? FontWeight.bold : null,
                        ),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                      ),
                      Text(
                        widget.planning.accountName ?? "",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                if (widget.isHandler == true) Spacer(),
                if (widget.isHandler == true) _rowHandlerCard(context),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text.rich(
                    TextSpan(
                      text:
                          '${Strings.normalizeNumber(widget.planning.usage.toString())}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              '/ ${Strings.normalizeNumber(widget.planning.limit.toString())} B',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ProgressBar(
                  // convert percentage -> normalize [0, 1]
                  progress: Numbers.calPercentage(
                          widget.planning.usage ?? 0, widget.planning.limit) /
                      100,
                  isFullSize: false,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _rowHandlerCard(BuildContext context) {
    final String confirmDelete = "Confirm Deletion";
    final String confirmDeleteDesc = "Proceed with destructive action?";

    void showEditPlanning() {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CreatePlanSheet(
              existingPlan: widget.planning,
              isEdit: true,
              monthYear: widget.planning.month!);
        },
      );
    }

    void showDeleteDialog() {
      AlertDialogUtils.showAlertDialog(
          context: context,
          title: confirmDelete,
          content: confirmDeleteDesc,
          onConfirm: () => {
                context
                    .read<PlansBloc>()
                    .add(DeletePlanEvent(planId: widget.planning.planId ?? -1))
              },
          onCancel: () {});
    }

    return Row(
      children: [
        GenericCircleIcons(customIcon: Icons.edit, onhandle: showEditPlanning),
        const SizedBox(width: 12),
        GenericCircleIcons(customIcon: Icons.delete, onhandle: showDeleteDialog)
      ],
    );
  }
}
