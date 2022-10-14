import 'package:poke_list/src/domain/entities/search_pokemon_entity.dart';
import 'package:poke_list/src/domain/errors/search_pokemon_errors.dart';
import 'package:dependencies/dependencies.dart';

typedef SearchPokemonResult = Future<Either<SearchPokemonError, SearchPokemonEntity>>;
