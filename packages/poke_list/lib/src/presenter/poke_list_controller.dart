import 'package:core/core.dart';
import 'package:poke_list/src/domain/usecases/search_pokemon_usecase.dart';

import '../domain/params/search_pokemon_params.dart';

class PokeListController {
  final SearchPokemonUsecase searchPokemonUsecase;
  final AnalyticsService analyticsService;

  String pokemonName = '';
  String pokemonId = '';
  List<String> pokemonAbilities = [];

  Future<void> screenOpened() async {
    final Map<String, Object?> parameters = {};
    parameters.addAll({'page_name': 'form'});
    await analyticsService.screenOpened(parameters);
  }

  Future<void> initPage() async {
    final either = await searchPokemonUsecase(const SearchPokemonParams(name: 'ditto'));
    either.fold(
      (error) {},
      (entity) {
        pokemonName = entity.name;
        pokemonId = entity.id;
        pokemonAbilities = entity.abilities;
      },
    );
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

  PokeListController(this.searchPokemonUsecase, this.analyticsService);
}
