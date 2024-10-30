class Pokemon {
  final int id;
  final String name;
  final String url;

  const Pokemon({required this.id, required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> data) {
    return Pokemon(id: data['id'], name: data['name'], url: data['url']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
    };
  }
}