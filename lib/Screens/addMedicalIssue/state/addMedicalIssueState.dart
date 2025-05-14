// import 'dart:convert';
// import 'package:uuid/uuid.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:native_ios_dialog/native_ios_dialog.dart';
// import 'package:http/http.dart' as http;
// import 'package:nurture/Screens/addMedicalIssue/addMedicalIssueModels.dart';

// enum ToggleType { vital, shareWithDoctor }

// class VitalEntry {
//   final String id;
//   final String? selectedVital;
//   final String value;

//   VitalEntry({required this.id, this.selectedVital, this.value = ''});

//   VitalEntry copyWith({String? id, String? selectedVital, String? value}) {
//     return VitalEntry(
//       id: id ?? this.id,
//       selectedVital: selectedVital ?? this.selectedVital,
//       value: value ?? this.value,
//     );
//   }
// }

// class addMedicalIssueState {
//   final TextEditingController mainProblemController;
//   final TextEditingController associatedProblemController;
//   final bool? isVitalSelected;
//   final bool? isShareWithDoctor;
//   final String? selectedVital;
//   final List<VitalEntry> vitalEntries;
//   final TextEditingController unitValueCOntroller;

//   addMedicalIssueState({
//     required this.mainProblemController,
//     required this.associatedProblemController,
//     required this.isVitalSelected,
//     required this.isShareWithDoctor,
//     required this.selectedVital,
//     required this.vitalEntries,
//     required this.unitValueCOntroller,
//   });

//   addMedicalIssueState copyWith({
//     TextEditingController? mainProblemController,
//     TextEditingController? associatedProblemController,
//     bool? isVitalSelected,
//     bool? isShareWithDoctor,
//     String? selectedVital,
//     List<VitalEntry>? vitalEntries,
//     TextEditingController? unitValueCOntroller,
//   }) {
//     return addMedicalIssueState(
//       mainProblemController:
//           mainProblemController ?? this.mainProblemController,
//       associatedProblemController:
//           associatedProblemController ?? this.associatedProblemController,
//       isVitalSelected: isVitalSelected ?? this.isVitalSelected,
//       isShareWithDoctor: isShareWithDoctor ?? this.isShareWithDoctor,
//       selectedVital: selectedVital ?? this.selectedVital,
//       vitalEntries: vitalEntries ?? this.vitalEntries,
//       unitValueCOntroller: unitValueCOntroller ?? this.unitValueCOntroller,
//     );
//   }
// }

// class addMedicalIssueStateNotifier extends StateNotifier<addMedicalIssueState> {
//   addMedicalIssueStateNotifier()
//     : super(
//         addMedicalIssueState(
//           mainProblemController: TextEditingController(),
//           associatedProblemController: TextEditingController(),
//           isVitalSelected: null,
//           isShareWithDoctor: null,
//           selectedVital: null,
//           vitalEntries: [VitalEntry(id: const Uuid().v1())],
//           unitValueCOntroller: TextEditingController(),
//         ),
//       );
//   var myDictionary = [{}];

//   final uuid = Uuid();

//   void addVitalEntry(List<String> allVitals) {
//     if (state.vitalEntries.length < allVitals.length) {
//       final updatedList = [...state.vitalEntries, VitalEntry(id: uuid.v1())];
//       state = state.copyWith(vitalEntries: updatedList);
//     }
//   }

//   void toggleSelection(ToggleType type, bool value) {
//     switch (type) {
//       case ToggleType.vital:
//         if (value == true && state.isVitalSelected != true) {
//           // Reset the vital entries list
//           state = state.copyWith(
//             isVitalSelected: value,
//             vitalEntries: [VitalEntry(id: '')],
//           );
//         } else {
//           state = state.copyWith(isVitalSelected: value);
//         }
//         break;
//       case ToggleType.shareWithDoctor:
//         state = state.copyWith(isShareWithDoctor: value);
//         break;
//     }
//   }

//   void setSelectedVital(String? vital) {
//     state = state.copyWith(selectedVital: vital);
//   }

//   void updateVital(int index, String? newVital) {
//     final updatedList = [...state.vitalEntries];
//     updatedList[index] = updatedList[index].copyWith(selectedVital: newVital);
//     state = state.copyWith(vitalEntries: updatedList);
//     print(state.vitalEntries);
//   }

//   void updateVitalValue(int index, String newValue) {
//     final updatedList = [...state.vitalEntries];
//     updatedList[index] = updatedList[index].copyWith(value: newValue);
//     state = state.copyWith(vitalEntries: updatedList);
//   }

//   void addVitalEntry1(List<String> allVitals) {
//     if (state.vitalEntries.length < allVitals.length) {
//       final updatedList = [...state.vitalEntries, VitalEntry(id: '')];
//       state = state.copyWith(vitalEntries: updatedList);
//     }
//   }

//   void removeVitalEntry(int index) {
//     final updatedList = [...state.vitalEntries]..removeAt(index);
//     state = state.copyWith(vitalEntries: updatedList);
//   }

//   List<String> getAvailableVitals(List<String> allVitals, int index) {
//     final currentSelected = state.vitalEntries[index].selectedVital;

//     //  selected vitals except the recent
//     final selectedByOthers =
//         state.vitalEntries
//             .asMap()
//             .entries
//             .where((entry) => entry.key != index)
//             .map((entry) => entry.value.selectedVital)
//             .whereType<String>()
//             .toSet();

//     // Filter available vitals
//     final available =
//         allVitals.where((vital) => !selectedByOthers.contains(vital)).toList();

//     //
//     if (currentSelected != null && !available.contains(currentSelected)) {
//       available.insert(0, currentSelected);
//     }

//     return available;
//   }

//   bool isFieldEmpty(TextEditingController controller) {
//     return controller.text.trim().isEmpty;
//   }

//   emptyValidation(BuildContext context) {
//     final isMainProblemEmpty = isFieldEmpty(state.mainProblemController);
//     final isAssociatedProblemEmpty = isFieldEmpty(
//       state.associatedProblemController,
//     );
//     if (isMainProblemEmpty) {
//       alertFunction(context, "Enter Main Problem");
//     } else if (isAssociatedProblemEmpty) {
//       alertFunction(context, "Enter Associated Problem");
//     } else if (state.isVitalSelected == null) {
//       alertFunction(context, "Choose Add Vitals");
//     } else if (state.isVitalSelected == true && state.selectedVital == null) {
//       alertFunction(context, "Select Vitals");
//     } else if (state.isShareWithDoctor == null) {
//       alertFunction(
//         context,
//         "Choose do you want to share  child medical condition with doctor",
//       );
//     } else {
//       print("All fields are valid. Submitting...");
//       // postMedicalIssue(context, state.mainProblemController.value.text, state.associatedProblemController.value.text, state.isVitalSelected, state.isShareWithDoctor);
//       print(
//         state.vitalEntries
//             .where(
//               (entry) =>
//                   entry.selectedVital != null && entry.value.trim().isNotEmpty,
//             )
//             .map(
//               (entry) => {
//                 'id': Uuid().v1(),
//                 'category':
//                     entry.selectedVital == "Temperature"
//                         ? 3
//                         : entry.selectedVital == "Blood Glucose"
//                         ? 2
//                         : 1,
//                 'value': entry.value.trim(),
//               },
//             )
//             .toList(),
//       );
//     }
//   }

//   alertFunction(BuildContext context, String alertMessage) {
//     NativeIosDialog(
//       title: "",
//       message: alertMessage,
//       style: NativeIosDialogStyle.alert,
//       actions: [
//         NativeIosDialogAction(
//           text: "OK",
//           style: NativeIosDialogActionStyle.defaultStyle,
//           onPressed: () {},
//         ),
//       ],
//     ).show();
//   }

//   String getUnitFromVital(String? vital) {
//     switch (vital) {
//       case 'Temperature':
//         return '   °F   ';
//       case 'Blood Glucose':
//         return 'mg/dL';
//       case 'Heart Rate':
//         return '  bpm  ';
//       default:
//         return '   --   ';
//     }
//   }

//   List<Map<String, dynamic>> getVitalsAsMap() {
//     return state.vitalEntries
//         .where(
//           (entry) =>
//               entry.selectedVital != null && entry.value.trim().isNotEmpty,
//         )
//         .map(
//           (entry) => {
//             'id': Uuid().v1(),
//             'category':
//                 entry.selectedVital == "Temperature"
//                     ? 3
//                     : entry.selectedVital == "Blood Glucose"
//                     ? 2
//                     : 1,
//             'value': entry.value.trim(),
//           },
//         )
//         .toList();
//   }

//   void postMedicalIssue(
//     BuildContext context,
//     String mainProblem,
//     String associatedProblem,
//     bool? isisVitalSelected,
//     bool? isShareWithDoctor,
//   ) async {
//     final vitalsMap = getVitalsAsMap();
//     final model = MedicalIssuePOSTModel(
//       mainProblem: mainProblem,
//       associatedProblem: associatedProblem,
//       isVitalSelected: isisVitalSelected ?? false,
//       isShareWithDoctor: isisVitalSelected ?? false,
//       vitals: vitalsMap,
//     );
//     print(getVitalsAsMap());
//     final response = await http.post(
//       Uri.parse('http://nurturelife.io:5000/api/account/medical-issue/create'),
//       headers: {
//         'Authorization':
//             'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImZ1bGxOYW1lIjoiVmljdG9yIEVudnkiLCJwaG90byI6ImltYWdlczE3MzI1OTkyNDAyOTMuanBlZyIsIm1vYmlsZU51bWJlciI6Iis5MSA3MzA2MDQ1NzU1In0sImlkIjoiNzEyZDFlMTMtZTdjMi00OGYxLWJmN2MtZjQwMTliOGE2NWZiIiwidXNlcm5hbWUiOiJiYWxha3Jpc2huYW5AeW9wbWFpbC5jb20iLCJyb2xlIjoxLCJpYXQiOjE3NDY4NzgxOTIsImV4cCI6MTc0NjkwNjk5Mn0.n7z7YdwwXiTglaHx-NgkrGABz8jPcKX7IGdwSC145RU',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(model.toJson()),
//     );

//     if (response.statusCode == 200) {
//       alertFunction(context, " Data submitted successfully!");
//       print(" Data submitted successfully!");
//     } else {
//       print(" Failed: ${response.statusCode}");
//       alertFunction(context, " Failed: ${response.statusCode}");
//     }
//   }
// }

// final addMedicalIssueNotifier = StateNotifierProvider.autoDispose<
//   addMedicalIssueStateNotifier,
//   addMedicalIssueState
// >((ref) {
//   var notifier = addMedicalIssueStateNotifier();

//   return notifier;
// });
