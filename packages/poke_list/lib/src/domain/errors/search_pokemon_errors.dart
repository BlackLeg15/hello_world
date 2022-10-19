abstract class SearchPokemonError {
  final String message;

  const SearchPokemonError(this.message);

  @override
  String toString() => message;
}

class SearchPokemonNotFoundError extends SearchPokemonError {
  const SearchPokemonNotFoundError(super.message);
}

class SearchPokemonUnknownError extends SearchPokemonError {
  const SearchPokemonUnknownError(super.message);
}

class SearchPokemonMapperError extends SearchPokemonError {
  const SearchPokemonMapperError(super.message);
}
