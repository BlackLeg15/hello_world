import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_list/src/domain/usecases/search_pokemon_usecase.dart';
import 'package:poke_list/src/presenter/poke_list_controller.dart';
import 'package:poke_list/src/presenter/stores/search_pokemon_store/search_pokemon_store.dart';

class AnalyticsServiceMock extends Mock implements AnalyticsService {}

class SearchPokemonUsecaseMock extends Mock implements SearchPokemonUsecase {}

class SearchPokemonStoreMock extends Mock implements SearchPokemonStore {}

void main() {
  late PokeListController controller;
  late AnalyticsService analyticsService;
  late SearchPokemonStore store;

  setUp(() {
    analyticsService = AnalyticsServiceMock();
    store = SearchPokemonStoreMock();
    controller = PokeListController(store, analyticsService);
  });

  group('Poke List Controller', () {
    test('screenOpened()', () async {
      when(
        () => analyticsService.screenOpened(any()),
      ).thenAnswer((invocation) async {
        return null;
      });
      await controller.screenOpened();
      verify(
        () => analyticsService.screenOpened(any()),
      ).called(1);
    });
  });
}
