import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:poke_list/src/presenter/pages/form_controller.dart';
import 'package:poke_list/src/presenter/poke_list_controller.dart';
import 'package:poke_list/src/presenter/reactive/reactive_provider.dart';
import 'package:poke_list/src/presenter/stores/search_pokemon_store/search_pokemon_store.dart';
import 'package:uno_http_service/uno_http_service.dart';

import '../domain/usecases/search_pokemon_usecase_impl.dart';
import '../external/datasources/api_v2/search_pokemon_api_v2_datasource.dart';
import '../external/datasources/api_v2/search_pokemon_api_v2_mapper.dart';
import '../infra/repositories/search_pokemon_repository_impl.dart';
import 'poke_list_page.dart';
import 'reactive/mobx/mobx_reactive_provider.dart';

class PokeListFeature extends Feature {
  @override
  Map<Type, Object> dependencies({DependencyInjectionWidget? injector}) {
    final analyticsService = injector?.get<AnalyticsService>();
    if (analyticsService == null) {
      throw Exception();
    }
    final httpClient = UnoHttpClient();
    final mapper = SearchPokemonApiV2Mapper();
    final datasouce = SearchPokemonApiV2Datasouce(
      httpClient,
      mapper,
      analyticsService,
    );
    final repository = SearchPokemonRepositoryImpl(datasouce);
    final usecase = SearchPokemonUsecaseImpl(repository);
    final store = SearchPokemonStore(usecase);
    final controller = PokeListController(store, analyticsService);
    final formController = FormController();
    const reactiveProvider = MobxReactiveProvider();
    return <Type, Object>{
      PokeListController: controller,
      FormController: formController,
      ReactiveProvider: reactiveProvider,
    };
  }

  @override
  final Widget child = const PokeListPage();

  const PokeListFeature({super.key});
}
