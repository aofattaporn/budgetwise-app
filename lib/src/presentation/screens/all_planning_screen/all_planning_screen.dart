import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/models/entity/planning_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPlanningScreen extends StatelessWidget {
  final Function(PlanEntity) onPlanningSelected;
  PlanEntity? planningVisit;

  AllPlanningScreen({
    required this.onPlanningSelected,
    required this.planningVisit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Planning'),
        leading: _buildBackButton(context),
      ),
      child: BlocBuilder<PlansBloc, PlansState>(
        builder: (context, state) {
          if (state is GetPlanSuccess) {
            return _buildPlanningList(context, state);
          } else {
            return _buildErrorMessage();
          }
        },
      ),
    );
  }

  // Back button widget for navigation
  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios_new),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  // Builds the list of plans when state is GetPlanSuccess
  Widget _buildPlanningList(BuildContext context, GetPlanSuccess state) {
    return SafeArea(
      child: Material(
        child: Column(
          children:
              state.plans.map((plan) => _buildPlanItem(context, plan)).toList(),
        ),
      ),
    );
  }

  // Builds each plan item
  Widget _buildPlanItem(BuildContext context, PlanEntity plan) {
    return InkWell(
      onTap: () => _onPlanSelected(plan, context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 20,
              ),
            ],
          ),
          child: Text(plan.name),
        ),
      ),
    );
  }

  // Handles plan selection and updates the planningVisit variable
  void _onPlanSelected(PlanEntity plan, BuildContext context) {
    planningVisit = plan;
    onPlanningSelected(plan);
    Navigator.pop(context);
  }

  // Builds the error message when the state is not GetPlanSuccess
  Widget _buildErrorMessage() {
    return Material(
      child: Center(
        child: Text("Can't get planning"),
      ),
    );
  }
}
