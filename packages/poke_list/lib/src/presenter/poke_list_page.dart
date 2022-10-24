import 'package:core/core.dart';
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

  @override
  void didChangeDependencies() {
    controller = DependencyInjectionWidget.of(context)!.get();
    controller.screenOpened();
    initPage();
    super.didChangeDependencies();
  }

  void initPage() {
    controller.initPage().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonName = controller.pokemonName;
    final pokemonId = controller.pokemonId;
    final pokemonAbilities = controller.pokemonAbilities;
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
