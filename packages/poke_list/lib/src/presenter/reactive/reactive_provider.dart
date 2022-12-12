import 'package:flutter/material.dart';
import 'package:poke_list/src/presenter/reactive/reactive_widget.dart';

abstract class ReactiveProvider {
  const ReactiveProvider();

  ReactiveWidget call({required WidgetBuilder builder});
}
