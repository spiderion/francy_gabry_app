class Opponent {
  final String name;
  final String id;
  int points;
  static const id_key = "id";
  static const name_key = "name";
  static const points_key = "points";

  Opponent(this.id, this.name, this.points);

  Map<String, dynamic> toJson({bool isStoreLocal = false}) => {name_key: name, points_key: points};

  @override
  Opponent.fromJson(Map<String, dynamic>? json)
      : id = (json ?? {})[id_key],
        name = (json ?? {})[name_key],
        points = (json ?? {})[points_key];
}
