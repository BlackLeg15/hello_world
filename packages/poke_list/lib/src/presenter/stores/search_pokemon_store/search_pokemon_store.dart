import 'package:dependencies/dependencies.dart';
import 'package:poke_list/src/domain/usecases/search_pokemon_usecase.dart';
import 'package:poke_list/src/presenter/view_model/search_pokemon_view_model.dart';

import '../../../domain/params/search_pokemon_params.dart';
part 'search_pokemon_store.g.dart';

class SearchPokemonStore = SearchPokemonStoreBase with _$SearchPokemonStore;

abstract class SearchPokemonStoreBase with Store {
  final SearchPokemonUsecase usecase;
  SearchPokemonStoreBase(this.usecase);

  @observable
  bool isLoading = false;

  @observable
  SearchPokemonViewModel searchPokemonViewModel = const SearchPokemonViewModel('', '', []);

  @action
  Future<void> searchPokemon() async {
    isLoading = true;
    final either = await usecase(const SearchPokemonParams(name: 'ditto'));
    either.fold(
      (error) {},
      (entity) {
        searchPokemonViewModel = searchPokemonViewModel.copyWith(
          pokemonName: entity.name,
          pokemonId: entity.id,
          pokemonAbilities: entity.abilities,
        );
      },
    );
    isLoading = false;
  }
}
