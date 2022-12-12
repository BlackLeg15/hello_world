import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:poke_list/src/presenter/reactive/reactive_widget.dart';

class MobxReactiveWidget extends ReactiveWidget {
  const MobxReactiveWidget({super.key, required super.builder});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: builder);
  }
}
