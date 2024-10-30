import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/api_service.dart';
import 'package:pokedex_flutter/ui/views/pokemon_list_view.dart';
import 'package:pokedex_flutter/core/database/shared_preferences.dart';
import 'package:pokedex_flutter/data/repositories/storage_repository.dart';

import 'package:pokedex_flutter/ui/viewmodels/pokemon_list_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => const ApiService('https://pokeapi.co/api/v2/pokemon')),
        Provider(create: (_) => StorageRepository(storage: SharedPreferencesStore())),
        ChangeNotifierProvider(create: (context) => PokemonListViewModel(apiService: context.read<ApiService>(), storageRepository: context.read<StorageRepository>())),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PokemonListView(title: 'Pokédex'),
    );
  }
}