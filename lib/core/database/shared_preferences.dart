import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokedex_flutter/core/models/storage_model.dart';

import '../models/pokemon_model.dart';

class SharedPreferencesStore extends Storage {
  SharedPreferencesStore();

  @override
  Future<void> cache(List<Pokemon> pokemons) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(pokemons.map((pokemon) => pokemon.toJson()).toList());
    await prefs.setString('cachedPokemons', jsonString);
  }

  @override
  Future<List<Pokemon>?> restore() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('cachedPokemons');
    if (jsonString != null) {
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((pokemonJson) => Pokemon.fromJson(pokemonJson)).toList();
    }
    return null;
  }
}