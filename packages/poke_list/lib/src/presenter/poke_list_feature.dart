import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:uno_http_service/uno_http_service.dart';

import '../domain/usecases/search_pokemon_usecase_impl.dart';
import '../external/datasources/api_v2/search_pokemon_api_v2_datasource.dart';
import '../external/datasources/api_v2/search_pokemon_api_v2_mapper.dart';
import '../infra/repositories/search_pokemon_repository_impl.dart';
import 'poke_list_page.dart';

class PokeListFeature extends Feature {
  @override
  List<Object> get dependencies {
    final httpClient = UnoHttpClient();
    final mapper = SearchPokemonApiV2Mapper();
    final datasouce = SearchPokemonApiV2Datasouce(httpClient, mapper);
    final repository = SearchPokemonRepositoryImpl(datasouce);
    final usecase = SearchPokemonUsecaseImpl(repository);
    return <Object>[usecase];
  }

  @override
  final Widget child = const PokeListPage();

  const PokeListFeature({super.key});
}
