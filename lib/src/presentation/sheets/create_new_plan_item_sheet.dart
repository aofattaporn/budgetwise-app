// import 'package:budget_wise/src/core/constant/business_constant.dart';
// import 'package:budget_wise/src/core/constant/common_constant.dart';
// import 'package:budget_wise/src/domain/models/plan_item_dto.dart';
// import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
// import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
// import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_state.dart';
// import 'package:budget_wise/src/presentation/common/custom_common_component.dart';
// import 'package:budget_wise/src/presentation/common/custum_common_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:budget_wise/src/presentation/theme/app_colors.dart';
// import 'package:budget_wise/src/presentation/theme/app_padding.dart';
// import 'package:budget_wise/src/presentation/theme/app_text_style.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CreateNewPlanItemSheet extends StatefulWidget {
//   final String? id;
//   final PlanItemDto? planItemDto;
//   final int planId;

//   const CreateNewPlanItemSheet(
//       {super.key, required this.planId, this.planItemDto, this.id});

//   @override
//   State<CreateNewPlanItemSheet> createState() => _CreateNewPlanItemSheetState();
// }

// class _CreateNewPlanItemSheetState extends State<CreateNewPlanItemSheet> {
//   final String kTitle = "Create New Plan Item";
//   final String kDesc =
//       "Add a new item to your plan to better organize your budget.";

//   late int segmentSelecting;
//   late String iconName;
//   final TextEditingController planNameController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     if (widget.planItemDto == null) {
//       iconName = CommonConstant.empty;
//       segmentSelecting = CommonConstant.number_0;
//     } else {
//       final dto = widget.planItemDto!;

//       planNameController.text = dto.title;
//       amountController.text = dto.planAmount.toStringAsFixed(0);
//       segmentSelecting = getSegmentKeyFromCategory(dto.category);
//       iconName = dto.iconName;
//     }

//     amountController.addListener(_onFormChanged);
//     planNameController.addListener(_onFormChanged);
//   }

//   @override
//   void dispose() {
//     amountController.dispose();
//     planNameController.dispose();
//     super.dispose();
//   }

//   void _onFormChanged() {
//     setState(() {});
//   }

//   void handleSetIcon(String icon) {
//     setState(() {
//       iconName = icon;
//     });
//   }

//   void handleSetSegmmentSelect(int segmentId) {
//     setState(() {
//       segmentSelecting = segmentId;
//     });
//   }

//   bool _isFillNotCompletly() {
//     final amountText = amountController.text.trim();
//     final nameText = planNameController.text.trim();
//     final double amount = double.tryParse(amountText) ?? 0;

//     return amount <= 0 || nameText.isEmpty;
//   }

//   int getSegmentKeyFromCategory(String category) {
//     switch (category) {
//       case BusinessConstant.expensePlanCategory:
//         return 0;
//       case BusinessConstant.savingPlanCategory:
//         return 1;
//       default:
//         return 0;
//     }
//   }

//   String getCategoryFromSegmentKey(int key) {
//     switch (key) {
//       case 0:
//         return BusinessConstant.expensePlanCategory;
//       case 1:
//         return BusinessConstant.savingPlanCategory;
//       default:
//         return BusinessConstant.otherPlanCategory;
//     }
//   }

//   void saveNewPlanning(BuildContext context) {
//     final planDto = PlanItemDto(
//       planId: widget.planId,
//       title: planNameController.text.trim(),
//       planAmount: double.parse(amountController.text),
//       category: getCategoryFromSegmentKey(segmentSelecting),
//       iconName: iconName,
//     );
//     if (widget.planItemDto != null && widget.id != null) {
//       context.read<PlanItemBloc>().add(
//           UpdatePlanItemById(planItemId: widget.id!, planItemDto: planDto));
//     } else {
//       context.read<PlanItemBloc>().add(AddPlanItemEvent(planItemDto: planDto));
//     }

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<PlanItemBloc, PlanItemState>(
//       listener: (context, state) {
//         if (state is PlanItemIsOvering) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.message),
//               backgroundColor: Colors.redAccent,
//               duration: const Duration(seconds: 3),
//             ),
//           );

//           context.read<PlanItemBloc>().add(FetchPlanItemEvent(widget.planId));
//         }
//       },
//       child: Padding(
//         padding: AppPadding.allxxl,
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             spacing: 16,
//             children: [
//               _buildTiltleVreateNewPlan(),
//               _buildCreatePlanAction(),
//               const Spacer(),
//               CustomCommonWidget.commonElevatedBtn(
//                 label: widget.planItemDto == null
//                     ? CommonConstant.save
//                     : CommonConstant.update,
//                 onPressed: () => saveNewPlanning(context),
//                 isDisable: _isFillNotCompletly(),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Column _buildTiltleVreateNewPlan() {
//     return Column(
//       spacing: 8,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(
//           kTitle,
//           style: AppTextStyles.headlineSmall,
//         ),
//         Text(
//           kDesc,
//           style: AppTextStyles.bodySmall.copyWith(
//             color: AppColors.grayLight,
//           ),
//         ),
//         const Divider(
//           color: Colors.grey,
//           thickness: 1,
//           height: 1,
//         ),
//       ],
//     );
//   }

//   Column _buildCreatePlanAction() {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       spacing: 16,
//       children: [
//         CustomCommonWidget.segmentControl(
//           segmentOptions: BusinessConstant.segmentOptions,
//           initialSelectedIndex: segmentSelecting,
//           handleSelectSegment: handleSetSegmmentSelect,
//         ),
//         CustomCommonComponent.labelledIconRow(
//             iconData: iconName, handleSelectIcon: handleSetIcon),
//         CustomCommonComponent.labelledTextFieldRow(
//             label: "Plan Name",
//             textEditingController: planNameController,
//             placeHolder: "Ex. Retirement Plan"),
//         CustomCommonComponent.labelledTextFieldRow(
//             label: "Aount Limit",
//             textEditingController: amountController,
//             placeHolder: "Ex. 500",
//             isNumberOnly: true),
//       ],
//     );
//   }
// }
