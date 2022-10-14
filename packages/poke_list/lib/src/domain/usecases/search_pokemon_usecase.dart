import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/domain/typedefs/search_pokemon_typedef.dart';

abstract class SearchPokemonUsecase {
  const SearchPokemonUsecase();

  SearchPokemonResult call(SearchPokemonParams params);
}
