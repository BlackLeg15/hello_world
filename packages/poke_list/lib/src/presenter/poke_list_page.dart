import 'package:flutter/material.dart';
import 'package:poke_list/src/domain/params/search_pokemon_params.dart';
import 'package:poke_list/src/domain/repositories/search_pokemon_repository.dart';
import 'package:poke_list/src/domain/usecases/search_pokemon_usecase_impl.dart';
import 'package:poke_list/src/external/datasources/api_v2/search_pokemon_api_v2_datasource.dart';
import 'package:poke_list/src/external/datasources/api_v2/search_pokemon_api_v2_mapper.dart';
import 'package:uno_http_service/uno_http_service.dart';

import '../domain/usecases/search_pokemon_usecase.dart';
import '../infra/datasources/search_pokemon_datasource.dart';
import '../infra/repositories/search_pokemon_repository_impl.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({super.key});

  @override
  State<PokeListPage> createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage> {
  late SearchPokemonUsecase usecase;
  late SearchPokemonRepository repository;
  late SearchPokemonDatasource datasouce;
  late UnoHttpClient httpClient;
  late SearchPokemonApiV2Mapper mapper;

  String pokemonName = '';
  String pokemonId = '';
  List<String> pokemonAbilities = [];

  @override
  void initState() {
    httpClient = UnoHttpClient();
    mapper = SearchPokemonApiV2Mapper();
    datasouce = SearchPokemonApiV2Datasouce(httpClient, mapper);
    repository = SearchPokemonRepositoryImpl(datasouce);
    usecase = SearchPokemonUsecaseImpl(repository);

    super.initState();
  }

  void initPage() {
    usecase(const SearchPokemonParams(name: 'ditto')).then((either) {
      either.fold(
        (error) {
          debugPrint(error.toString());
        },
        (entity) {
          setState(() {
            pokemonName = entity.name;
            pokemonId = entity.id;
            pokemonAbilities = entity.abilities;
          });
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
