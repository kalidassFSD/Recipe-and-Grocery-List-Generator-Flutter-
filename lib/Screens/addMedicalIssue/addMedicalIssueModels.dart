import 'package:uuid/uuid.dart';

class MedicalIssuePOSTModel {
  String mainProblem;
  String associatedProblem;
  bool isVitalSelected;
  bool isShareWithDoctor;
  List<Map<String, dynamic>> vitals;

  MedicalIssuePOSTModel({
    required this.mainProblem,
    required this.associatedProblem,
    required this.isVitalSelected,
    required this.isShareWithDoctor,
    required this.vitals,
  });

  Map<String, dynamic> toJson() {
    return {
      "member": "a6398b77-d15d-4ae8-946c-6584af5be241",
      "vitals": vitals,
      "add_vitals": isVitalSelected,
      "id": Uuid().v1(),
      "medical_conditions": isShareWithDoctor,
      "parent": "36213527-8d69-46f4-a368-0ba2727054ea",
      "main_problem": mainProblem,
      "associated_problem": associatedProblem,
    };
  }
}

class VitalModel {
  String id;
  String value;
  int category;

  VitalModel({
    required this.value,
    required this.id,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "value": value,
      "category": category,
    };
  }
}
