import 'package:core/core.dart';
import 'package:poke_list/src/presenter/stores/search_pokemon_store/search_pokemon_store.dart';


class PokeListController {
  final SearchPokemonStore searchPokemonStore;
  final AnalyticsService analyticsService;

  Future<void> screenOpened() async {
    final Map<String, Object?> parameters = {};
    parameters.addAll({'page_name': 'form'});
    await analyticsService.screenOpened(parameters);
  }

  Future<void> initPage() => searchPokemonStore.searchPokemon();

  PokeListController(this.searchPokemonStore, this.analyticsService);
}
