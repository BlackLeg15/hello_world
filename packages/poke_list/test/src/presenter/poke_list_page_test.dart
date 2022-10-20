import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_list/src/domain/entities/search_pokemon_entity.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/domain/usecases/search_pokemon_usecase.dart';
import 'package:poke_list/src/presenter/poke_list_page.dart';

class AnalyticsServiceMock extends Mock implements AnalyticsService {}

class SearchPokemonUsecaseMock extends Mock implements SearchPokemonUsecase {}

void main() {
  late AnalyticsService analyticsService;
  late SearchPokemonUsecase usecase;

  setUpAll(() {
    analyticsService = AnalyticsServiceMock();
    usecase = SearchPokemonUsecaseMock();
    registerFallbackValue(const SearchPokemonParams(name: 'ditto'));
  });

  testWidgets('poke list page ...', (tester) async {
    when(
      () => usecase(any()),
    ).thenAnswer(
      (invocation) async => const Right(
        SearchPokemonEntity(abilities: [], id: '0', name: 'ditto'),
      ),
    );
    when(
      () => analyticsService.screenOpened(any()),
    ).thenAnswer((invocation) async => null);

    final dependencies = <Type, Object>{
      AnalyticsService: analyticsService,
      SearchPokemonUsecase: usecase,
    };
    await tester.pumpWidget(
      DependencyInjectionWidget(
        dependencies: dependencies,
        child: const MaterialApp(
          home: PokeListPage(),
        ),
      ),
    );

    expect(find.text('Name: ditto'), findsNothing);

    await tester.pump();

    expect(find.text('Name: ditto'), findsOneWidget);
  });
}
