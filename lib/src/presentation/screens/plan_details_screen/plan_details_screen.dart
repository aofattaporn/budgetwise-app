import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/data/models/planning_model.dart';
import 'package:budget_wise/src/presentation/widgets/plan_pocket/plan_pocket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansDetailsScreenDetails extends StatefulWidget {
  final Planning planning;
  const PlansDetailsScreenDetails({super.key, required this.planning});

  @override
  State<PlansDetailsScreenDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<PlansDetailsScreenDetails> {
  late Planning planning;

  @override
  void initState() {
    super.initState();
    planning = widget.planning;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (BuildContext context, AccountState state) {},
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Account Details'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        child: SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Planning Pocket
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: PlanPocket(
                      isFullSize: true,
                      planning: planning,
                      isHandler: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
