import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/pokemon_list_viewmodel.dart';
import '../viewmodels/pokemon_offset_viewmodel.dart';

class PokemonListWidget extends StatefulWidget {
  const PokemonListWidget({super.key});

  @override
  State<PokemonListWidget> createState() => _PokemonListWidgetState();
}

class _PokemonListWidgetState extends State<PokemonListWidget> {
  final PokemonOffsetViewModel pokemonOffsetViewModel = PokemonOffsetViewModel();

  @override
  void initState() {
    super.initState();
    final listViewModel = context.read<PokemonListViewModel>();
    _fetchPokemons(listViewModel);
  }

  void _fetchPokemons(PokemonListViewModel listViewModel) {
    listViewModel.fetchPokemons({'offset': pokemonOffsetViewModel.offset, 'limit': pokemonOffsetViewModel.limit});
    pokemonOffsetViewModel.increaseOffset();
  }

  void _loadMore() {
    final listViewModel = context.read<PokemonListViewModel>();
    setState(() {
      _fetchPokemons(listViewModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemonListViewModel = context.watch<PokemonListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokémon"),
      ),
      body: pokemonListViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: pokemonListViewModel.pokemons.length,
        itemBuilder: (context, index) {
          final user = pokemonListViewModel.pokemons[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text('#${user.id}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadMore,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
