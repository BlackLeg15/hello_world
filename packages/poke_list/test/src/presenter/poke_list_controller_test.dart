import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_list/src/domain/usecases/search_pokemon_usecase.dart';
import 'package:poke_list/src/presenter/poke_list_controller.dart';

class AnalyticsServiceMock extends Mock implements AnalyticsService {}

class SearchPokemonUsecaseMock extends Mock implements SearchPokemonUsecase {}

void main() {
  late PokeListController controller;
  late SearchPokemonUsecase usecase;
  late AnalyticsService analyticsService;

  setUp(() {
    usecase = SearchPokemonUsecaseMock();
    analyticsService = AnalyticsServiceMock();
    controller = PokeListController(usecase, analyticsService);
  });

  group('Poke List Controller', () {
    test('Initial state', () {
      expect(controller.pokemonAbilities.isEmpty, isTrue);
      expect(controller.pokemonId.isEmpty, isTrue);
      expect(controller.pokemonName.isEmpty, isTrue);
    });
    test('After changing name, only name will change', () {
      controller.pokemonName = 'ditto';
      expect(controller.pokemonAbilities.isEmpty, isTrue);
      expect(controller.pokemonId.isEmpty, isTrue);
      expect(controller.pokemonName.isNotEmpty, isTrue);
    });
    test('screenOpened()', () async {
      when(
        () => analyticsService.screenOpened(any()),
      ).thenAnswer((invocation) async {
        return null;
      });
      await controller.screenOpened();
      expect(controller.pokemonAbilities.isEmpty, isTrue);
      expect(controller.pokemonId.isEmpty, isTrue);
      expect(controller.pokemonName.isEmpty, isTrue);
      verify(
        () => analyticsService.screenOpened(any()),
      ).called(1);
    });
  });
}
