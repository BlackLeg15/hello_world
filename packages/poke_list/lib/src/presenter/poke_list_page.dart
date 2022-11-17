import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:poke_list/src/presenter/pages/form_controller.dart';
import 'package:poke_list/src/presenter/pages/form_page.dart';
import 'package:poke_list/src/presenter/poke_list_controller.dart';
import 'package:poke_list/src/presenter/widgets/custom_text.dart';

class PokeListPage extends StatefulWidget {
  const PokeListPage({super.key});

  @override
  State<PokeListPage> createState() => _PokeListPageState();
}

class _PokeListPageState extends State<PokeListPage> {
  late PokeListController controller;
  ReactionDisposer? disposableReactionAutorun;
  ReactionDisposer? disposableReactionReaction;
  ReactionDisposer? disposableReactionWhen;

  void initReactions() {
    disposableReactionAutorun ??= autorun((_) {
      debugPrint('Autorun: ${controller.searchPokemonStore.isLoading}');
    });

    disposableReactionReaction ??= reaction<bool>((_) => controller.searchPokemonStore.isLoading, (isLoading) {
      debugPrint('Reaction: $isLoading');
    });

    disposableReactionWhen ??= when((_) => controller.searchPokemonStore.isLoading == true, () {
      debugPrint('When: isLoading == true');
    });
  }

  void waitForCompletion() async {
    await asyncWhen((_) => controller.searchPokemonStore.isLoading == true);
  }

  @override
  void didChangeDependencies() {
    controller = DependencyInjectionWidget.of(context)!.get();
    controller.screenOpened();
    initReactions();
    initPage();
    super.didChangeDependencies();
  }

  void initPage() {
    controller.initPage();
  }

  @override
  void dispose() {
    disposableReactionAutorun?.call();
    disposableReactionReaction?.call();
    disposableReactionWhen?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translations = DependencyInjectionWidget.of(context)!.get<Translations>();
    final store = controller.searchPokemonStore;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Observer(
          builder: (context) {
            if (store.isLoading) {
              return const CircularProgressIndicator();
            }
            final pokemon = store.searchPokemonViewModel;
            final pokemonName = pokemon.pokemonName;
            final pokemonId = pokemon.pokemonId;
            final pokemonAbilities = pokemon.pokemonAbilities;
            return Column(
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
                Text('List of abilities and ${translations.helloWorld}'),
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
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final formController = DependencyInjectionWidget.of(context)!.get<FormController>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormPage(
                formController: formController,
              ),
            ),
          );
        },
        child: const Icon(Icons.navigate_next_sharp),
      ),
    );
  }
}
