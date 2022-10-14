import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/domain/typedefs/search_pokemon_typedef.dart';

abstract class SearchPokemonDatasource {
  const SearchPokemonDatasource();

  SearchPokemonResult call(SearchPokemonParams params);
}
