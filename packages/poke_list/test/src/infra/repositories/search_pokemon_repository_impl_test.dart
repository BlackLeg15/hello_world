import 'package:dependencies/dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_list/src/domain/entities/search_pokemon_entity.dart';
import 'package:poke_list/src/domain/errors/search_pokemon_errors.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/infra/datasources/search_pokemon_datasource.dart';
import 'package:poke_list/src/infra/repositories/search_pokemon_repository_impl.dart';

class SearchPokemonDatasourceMock extends Mock implements SearchPokemonDatasource {}

void main() {
  late SearchPokemonRepositoryImpl repositoryImpl;
  late SearchPokemonDatasource datasource;
  const searchPokemonEntity = SearchPokemonEntity(id: '0', name: 'ditto', abilities: []);
  const dummyParams = SearchPokemonParams(name: 'pokemon');

  setUpAll(() {
    registerFallbackValue(const SearchPokemonParams(name: 'ditto'));
  });

  setUp(() {
    datasource = SearchPokemonDatasourceMock();
    repositoryImpl = SearchPokemonRepositoryImpl(datasource);
  });

  group('Search Pokemon', () {
    test('working correctly', () {
      when(
        () => datasource(any()),
      ).thenAnswer(
        (invocation) async => const Right(searchPokemonEntity),
      );

      final futureResult = repositoryImpl(dummyParams);

      expect(futureResult, completion(isA<Right>()));
    });
    test('working correctly with exceptions', () async {
      when(
        () => datasource(any()),
      ).thenAnswer(
        (invocation) async => const Left(SearchPokemonNotFoundError('Não foi possível encontrar')),
      );

      final eitherResult = await repositoryImpl(dummyParams);

      late SearchPokemonError error;

      eitherResult.fold((resultError) {
        error = resultError;
      }, (entity) {});

      expect(error, isA<SearchPokemonNotFoundError>());
      expect(error.message, 'Não foi possível encontrar');
      verify(
        () => datasource(any()),
      ).called(1);
    });

    test('working correctly when datasource throws an exception', () {
      when(
        () => datasource(any()),
      ).thenThrow(Exception());

      final futureResult = repositoryImpl(dummyParams);

      expect(futureResult, completion(isA<Left>()));
    });
  });
}
