import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericSheet extends StatelessWidget {
  final List<Widget> widgets;
  final String title;
  const GenericSheet({super.key, required this.widgets, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: const Icon(CupertinoIcons.back),
            middle: Text(title),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            ),
          )),
    );
  }
}
