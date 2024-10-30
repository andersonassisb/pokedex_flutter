import 'package:flutter/material.dart';
import 'package:pokedex_flutter/core/models/pokemon_model.dart';
import 'package:pokedex_flutter/data/repositories/storage_repository.dart';

import '../../core/services/api_service.dart';

class PokemonListViewModel extends ChangeNotifier {
  final ApiService apiService;
  final StorageRepository storageRepository;

  PokemonListViewModel({required this.apiService, required this.storageRepository});

  List<Pokemon> pokemons = [];
  bool isLoading = false;

  Future<void> fetchPokemons(Map<String, int>? options) async {
    final offset = options?['offset'] ?? 0;
    final limit = options?['limit'] ?? 10;

    isLoading = true;
    notifyListeners();

    try {
      final restoredPokemons = await storageRepository.restore();
      final bool alreadyExistsCachedPokemons = restoredPokemons != null;

      if( alreadyExistsCachedPokemons && restoredPokemons.length > offset) {
        pokemons.addAll(restoredPokemons);
      } else {
        final updatedOffset = alreadyExistsCachedPokemons ? offset + restoredPokemons.length : offset;
        final data = await apiService.getData('?offset=$updatedOffset&limit=$limit');
        final newPokemons = (data['results'] as List)
            .asMap()
            .map((index, pokemonJson) {
          final Map<String, dynamic> pokemonWithId = {
            'id': updatedOffset + index,
            ...pokemonJson
          };
          return MapEntry(index, Pokemon.fromJson(pokemonWithId));
        })
            .values
            .toList();
        pokemons.addAll(newPokemons);
        storageRepository.cache(pokemons);
      }
    } catch (e) {
      throw Exception('Pokémon loading failed: $e');
    } finally {
      isLoading = false;
    }

    notifyListeners();
  }
}