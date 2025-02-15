import 'package:flutter/material.dart';

sealed class NavigateScreenEvent {
  final BuildContext context;
  NavigateScreenEvent({required this.context});
}

final class PushNamedNavigateEvent extends NavigateScreenEvent {
  final RouteSettings settings;
  PushNamedNavigateEvent({required super.context, required this.settings});
}
