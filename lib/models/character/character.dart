import 'package:json_annotation/json_annotation.dart';

part "character.g.dart";

enum CharacterStatus {
  @JsonValue('Alive')
  alive,
  @JsonValue('Dead')
  dead,
  @JsonValue('Unknown')
  unknown,
}

enum CharacterGender {
  @JsonValue("Male")
  male,
  @JsonValue("Female")
  female,
  @JsonValue("Genderless")
  genderless,
  @JsonValue('Unknown')
  unknown,
}

enum CharacterSpecies {
  @JsonValue('Human')
  human,
  @JsonValue('Alien')
  alien,
  other,
}

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final CharacterStatus status;

  @CharacterSpeciesConverter()
  final CharacterSpecies species;
  final String type;
  final CharacterGender gender;
  final Origin origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: Origin.fromJson(json['origin']),
      location: Location.fromJson(json['location']),
      image: json['image'],
      episode: List<String>.from(json['episode']),
      url: json['url'],
      created: DateTime.parse(json['created']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status,
    'species': species,
    'type': type,
    'gender': gender,
    'origin': origin.toJson(),
    'location': location.toJson(),
    'image': image,
    'episode': episode,
    'url': url,
    'created': created.toIso8601String(),
  };
}

class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});

  factory Origin.fromJson(Map<String, dynamic> json) {
    return Origin(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(name: json['name'], url: json['url']);
  }

  Map<String, dynamic> toJson() => {'name': name, 'url': url};
}

class CharacterSpeciesConverter
    implements JsonConverter<CharacterSpecies, String> {
  const CharacterSpeciesConverter();

  @override
  CharacterSpecies fromJson(String json) {
    switch (json) {
      case "Human":
        return CharacterSpecies.human;
      case "Alien":
        return CharacterSpecies.alien;
      default:
        return CharacterSpecies.other;
    }
  }

  @override
  String toJson(CharacterSpecies object) {
    return object.name;
  }
}
