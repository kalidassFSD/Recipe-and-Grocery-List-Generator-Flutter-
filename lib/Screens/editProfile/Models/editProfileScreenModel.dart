class Prediction {
  final String description;
  final String placeId;

  Prediction({required this.description, required this.placeId});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}

class Facility {
  final String id;
  final String name;

  Facility({required this.id, required this.name});

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(id: json['id'], name: json['name']);
  }
}

class Physicians {
  final String firstName;
  final String lastName;
  final String specialist;

  Physicians({
    required this.firstName,
    required this.lastName,
    required this.specialist,
  });

  factory Physicians.fromJson(Map<String, dynamic> json) {
    return Physicians(
      firstName: json['first_name'],
      lastName: json['last_name'],
      specialist: json['specialist'],
    );
  }
}
