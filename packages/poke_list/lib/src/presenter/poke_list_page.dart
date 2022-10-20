import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/presenter/widgets/custom_text.dart';

import '../domain/usecases/search_pokemon_usecase.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({super.key});

  @override
  State<PokeListPage> createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage> {
  late SearchPokemonUsecase usecase;
  late AnalyticsService analyticsService;

  String pokemonName = '';
  String pokemonId = '';
  List<String> pokemonAbilities = [];

  void initPage() {
    usecase(const SearchPokemonParams(name: 'ditto')).then((either) {
      either.fold(
        (error) {
          debugPrint(error.toString());
        },
        (entity) {
          if (mounted) {
            screenOpened();
            setState(() {
              pokemonName = entity.name;
              pokemonId = entity.id;
              pokemonAbilities = entity.abilities;
            });
          }
        },
      );
    });
  }

  void screenOpened() {
    final Map<String, Object?> parameters = {};
    parameters.addAll({'page_name': 'form'});
    analyticsService.screenOpened(parameters);
  }

  @override
  Widget build(BuildContext context) {
    final dependencyInjector = DependencyInjectionWidget.of(context)!;
    usecase = dependencyInjector.get();
    analyticsService = dependencyInjector.get();

    if (pokemonName.isEmpty) initPage();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: 'Name: $pokemonName',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            Text(
              'ID: $pokemonId',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            const Text('List of abilities'),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: pokemonAbilities.length,
                itemBuilder: (context, index) {
                  return Text(
                    pokemonAbilities[index],
                    textAlign: TextAlign.center,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
