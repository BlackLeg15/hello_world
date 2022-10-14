import 'package:poke_list/src/domain/entities/search_pokemon_entity.dart';

class SearchPokemonApiV2Mapper {
  SearchPokemonEntity fromMap(Map<String, dynamic> data) {
    final id = data['id'].toString();

    final name = data['species']['name'];

    final abilityList = data['abilities'] as List;

    final abilities = abilityList.map((e) => e['ability']['name'] as String).toList();

    final pokemon = SearchPokemonEntity(id: id, name: name, abilities: abilities);
    return pokemon;
  }
}
