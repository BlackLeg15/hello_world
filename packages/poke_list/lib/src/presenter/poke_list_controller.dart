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

  Future<void> initPage() async {
    await searchPokemonStore.searchPokemon();
    // return searchPokemonUsecase(const SearchPokemonParams(name: 'ditto')).then((either) {
    //   either.fold(
    //     (error) {},
    //     (entity) {
    //       pokemonName = entity.name;
    //       pokemonId = entity.id;
    //       pokemonAbilities = entity.abilities;
    //     },
    //   );
    // });
  }

  PokeListController(this.searchPokemonStore, this.analyticsService);
}
