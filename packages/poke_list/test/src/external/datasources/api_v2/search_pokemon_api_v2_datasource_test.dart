import 'dart:convert';

import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_list/src/domain/entities/search_pokemon_entity.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/external/datasources/api_v2/search_pokemon_api_v2_datasource.dart';
import 'package:poke_list/src/external/datasources/api_v2/search_pokemon_api_v2_mapper.dart';

import 'api_result/api_result.dart';

class HttpServiceMock extends Mock implements HttpService {}

void main() {
  late HttpService service;
  SearchPokemonApiV2Mapper mapper;
  late SearchPokemonApiV2Datasouce datasource;

  setUpAll(() {
    service = HttpServiceMock();
    mapper = SearchPokemonApiV2Mapper();
    datasource = SearchPokemonApiV2Datasouce(service, mapper);
  });

  test(
    'search pokemon working correctly',
    () async {
      when(
        () => service.get(
          path: any(named: 'path'),
        ),
      ).thenAnswer(
        (_) async => HttpResponse(
          message: '',
          statusCode: 200,
          data: jsonDecode(apiResult),
        ),
      );

      final result = await datasource(const SearchPokemonParams(name: 'ditto'));

      late SearchPokemonEntity entity;

      result.fold((error) {}, (resultEntity) {
        entity = resultEntity;
      });

      expect(entity.abilities.contains('limber'), isTrue);

      expect(entity.abilities.contains('imposter'), isTrue);

      expect(entity.name, 'ditto');

      expect(entity.id, '132');
    },
  );
}
