import 'package:flutter/material.dart';

abstract class ReactiveWidget extends StatelessWidget {
  final WidgetBuilder builder;

  const ReactiveWidget({super.key, required this.builder});
}
