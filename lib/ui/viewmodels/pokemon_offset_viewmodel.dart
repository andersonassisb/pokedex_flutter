class PokemonOffsetViewModel {
  final int _limit = 10;
  int _offset = 0;

  int get offset => _offset;
  int get limit => _limit;

  int increaseOffset() {
    return _offset += _limit;
  }
}