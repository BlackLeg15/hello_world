import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart' show Right;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_list/src/domain/entities/search_pokemon_entity.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/domain/usecases/search_pokemon_usecase.dart';
import 'package:poke_list/src/presenter/pages/form_controller.dart';
import 'package:poke_list/src/presenter/poke_list_controller.dart';
import 'package:poke_list/src/presenter/poke_list_page.dart';
import 'package:poke_list/src/presenter/stores/search_pokemon_store/search_pokemon_store.dart';

class AnalyticsServiceMock extends Mock implements AnalyticsService {}

class SearchPokemonUsecaseMock extends Mock implements SearchPokemonUsecase {}

void main() {
  late AnalyticsService analyticsService;
  late SearchPokemonUsecase usecase;
  late PokeListController controller;
  late SearchPokemonStore store;
  late FormController formController;

  setUpAll(() {
    registerFallbackValue(const SearchPokemonParams(name: 'ditto'));
  });

  setUp(() {
    analyticsService = AnalyticsServiceMock();
    usecase = SearchPokemonUsecaseMock();
    store = SearchPokemonStore(usecase);
    controller = PokeListController(store, analyticsService);
    formController = FormController();
  });

  testWidgets('Poke list page getting data correctly', (tester) async {
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
      //PokeListController: controller,
      //FormController: formController,
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

  testWidgets('Go to the form page and back', (tester) async {
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
      PokeListController: controller,
      FormController: formController,
    };
    await tester.pumpWidget(
      DependencyInjectionWidget(
        dependencies: dependencies,
        child: const MaterialApp(
          home: PokeListPage(),
        ),
      ),
    );

    await tester.pump();

    //Navegando para página de formulário
    final navigateWidget = find.byIcon(Icons.navigate_next_sharp);

    expect(navigateWidget, findsOneWidget);

    await tester.tap(find.byIcon(Icons.navigate_next_sharp));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Name: ditto'), findsNothing);

    final textFieldList = find.byType(TextField);

    expect(textFieldList, findsNWidgets(2));

    await tester.enterText(textFieldList.first, 'Adby');
    expect(formController.firstName, 'Adby');

    await tester.enterText(textFieldList.at(1), 'Santos');
    expect(formController.lastName, 'Santos');

    //Voltando da página de formulário
    final backButton = find.byType(BackButton);
    await tester.tap(backButton);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(formController.firstName, isEmpty);
    expect(formController.lastName, isEmpty);
    expect(find.text('Name: ditto'), findsOneWidget);
  });
}
