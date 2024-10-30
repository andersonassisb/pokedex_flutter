import 'package:flutter/material.dart';
import 'package:pokedex_flutter/ui/widgets/pokemon_list_widget.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return const PokemonListWidget();
  }
}