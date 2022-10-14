import 'package:dependencies/dependencies.dart';
import 'package:poke_list/src/domain/errors/search_pokemon_errors.dart';
import 'package:poke_list/src/domain/typedefs/search_pokemon_typedef.dart';

import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/infra/datasources/search_pokemon_datasource.dart';

import '../../domain/repositories/search_pokemon_repository.dart';

class SearchPokemonRepositoryImpl extends SearchPokemonRepository {
  final SearchPokemonDatasource _datasource;

  const SearchPokemonRepositoryImpl(this._datasource);

  @override
  SearchPokemonResult call(SearchPokemonParams params) async {
    try {
      final result = await _datasource(params);
      return result;
    } catch (e) {
      return const Left(SearchPokemonUnknownError('Não foi possível encontrar o pokémon'));
    }
  }
}
