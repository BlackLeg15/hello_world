import 'package:poke_list/src/domain/entities/search_pokemon_entity.dart';
import 'package:poke_list/src/domain/errors/search_pokemon_errors.dart';

class SearchPokemonApiV2Mapper {
  SearchPokemonEntity fromMap(Map<String, dynamic> data) {
    final id = data['id'].toString();

    final species = data['species'];

    var name = '';

    try {
      name = species['name'];
    } catch (e) {
      throw (const SearchPokemonMapperError('Campo species.name não foi encontrado'));
    }

    var abilities = <String>[];

    try {
      final abilityList = data['abilities'] as List;
      abilities = abilityList.map((e) => e['ability']['name'] as String).toList();
    } catch (e) {
      throw const SearchPokemonMapperError('Campo abilities não foi encontrado');
    }

    final pokemon = SearchPokemonEntity(id: id, name: name, abilities: abilities);
    return pokemon;
  }
}
