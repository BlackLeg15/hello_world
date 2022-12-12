import 'package:flutter/widgets.dart';
import 'package:poke_list/src/presenter/reactive/reactive_provider.dart';
import 'package:poke_list/src/presenter/reactive/reactive_widget.dart';

import 'mobx_reactive_widget.dart';

class MobxReactiveProvider extends ReactiveProvider {
  const MobxReactiveProvider();

  @override
  ReactiveWidget call({required WidgetBuilder builder}) {
    return MobxReactiveWidget(builder: builder);
  }
}
