import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:poke_list/src/domain/errors/search_pokemon_errors.dart';
import 'package:poke_list/src/domain/typedefs/search_pokemon_typedef.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/external/datasources/api_v2/search_pokemon_api_v2_mapper.dart';
import 'package:poke_list/src/infra/datasources/search_pokemon_datasource.dart';

class SearchPokemonApiV2Datasouce extends SearchPokemonDatasource {
  final HttpService httpService;
  final SearchPokemonApiV2Mapper mapper;

  const SearchPokemonApiV2Datasouce(this.httpService, this.mapper);

  @override
  SearchPokemonResult call(SearchPokemonParams params) async {
    const baseUrl = 'https://pokeapi.co/api/v2/';
    final pokemonName = params.name;

    try {
      final result = await httpService.get(path: '${baseUrl}pokemon/$pokemonName');
      final data = result.data;
      if (data != null) {
        final mapResult = mapper.fromMap(result.data);
        return Right(mapResult);
      }
      return const Left(SearchPokemonNotFoundError('Resposta inválida'));
    } catch (e) {
      return const Left(SearchPokemonNotFoundError('Não foi possível encontrar o pokémon'));
    }
  }
}
