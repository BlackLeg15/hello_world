import 'package:flutter/material.dart';
import 'package:hello_world/app/features/home/widgets/stateful_widget_with_global_key.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: const StatefulWidgetWithGlobalKey());
  }
}
