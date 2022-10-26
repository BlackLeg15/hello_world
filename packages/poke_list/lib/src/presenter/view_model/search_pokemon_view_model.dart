import 'package:equatable/equatable.dart';

class SearchPokemonViewModel extends Equatable {
  final String pokemonName;
  final String pokemonId;
  final List<String> pokemonAbilities;

  const SearchPokemonViewModel(this.pokemonName, this.pokemonId, this.pokemonAbilities);

  @override
  List<Object?> get props => [pokemonId, pokemonName, pokemonAbilities];

  SearchPokemonViewModel copyWith({
    String? pokemonName,
    String? pokemonId,
    List<String>? pokemonAbilities,
  }) {
    return SearchPokemonViewModel(
      pokemonName ?? this.pokemonName,
      pokemonId ?? this.pokemonId,
      pokemonAbilities ?? this.pokemonAbilities,
    );
  }
}
