import 'package:flutter/material.dart';
import 'package:pokedex_flutter/core/models/pokemon_model.dart';

abstract class Storage{
  Future<void> cache(List<Pokemon> pokemons) async {}
  Future<List<Pokemon>?> restore() async {
    return null;
  }
}
