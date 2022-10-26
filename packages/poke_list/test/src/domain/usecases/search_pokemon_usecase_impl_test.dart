import 'package:dependencies/dependencies.dart' show Right;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_list/src/domain/entities/search_pokemon_entity.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/domain/repositories/search_pokemon_repository.dart';
import 'package:poke_list/src/domain/usecases/search_pokemon_usecase_impl.dart';

class SearchPokemonRepositoryMock extends Mock implements SearchPokemonRepository {}

void main() {
  late SearchPokemonRepository repository;
  late SearchPokemonUsecaseImpl searchPokemonUsecaseImpl;

  setUp(() {
    repository = SearchPokemonRepositoryMock();
    searchPokemonUsecaseImpl = SearchPokemonUsecaseImpl(repository);
    registerFallbackValue(const SearchPokemonParams(name: 'whatever'));
  });

  group('Search Pokemon Usecase', () {
    test('working correctly', () async {
      when(() => repository(any())).thenAnswer(
        (invocation) async => const Right(
          SearchPokemonEntity(id: '0', name: 'any', abilities: []),
        ),
      );

      final result = await searchPokemonUsecaseImpl(const SearchPokemonParams(name: 'ditto'));

      expect(result, isA<Right>());
    });
  });
}
