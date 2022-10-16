import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';

import '../domain/usecases/search_pokemon_usecase.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({super.key});

  @override
  State<PokeListPage> createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage> {
  late SearchPokemonUsecase usecase;

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

  @override
  Widget build(BuildContext context) {
    usecase = DependencyInjectionWidget.of(context)!.get<SearchPokemonUsecase>();
    initPage();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: $pokemonName',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
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
