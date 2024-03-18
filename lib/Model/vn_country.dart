class City {
  final String id;
  final String name;
  final List<District> districts;

  City({required this.id, required this.name, required this.districts});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['Id'],
      name: json['Name'],
      districts: (json['Districts'] as List<dynamic>)
          .map((districtJson) => District.fromJson(districtJson))
          .toList(),
    );
  }
}

class District {
  final String id;
  final String name;
  final List<Ward> wards;

  District({required this.id, required this.name, required this.wards});

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['Id'],
      name: json['Name'],
      wards: (json['Wards'] as List<dynamic>)
          .map((wardJson) => Ward.fromJson(wardJson))
          .toList(),
    );
  }
}

class Ward {
  final String id;
  final String name;
  final String level;

  Ward({required this.id, required this.name, required this.level});

  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(
      id: json['Id'],
      name: json['Name'],
      level: json['Level'],
    );
  }
}