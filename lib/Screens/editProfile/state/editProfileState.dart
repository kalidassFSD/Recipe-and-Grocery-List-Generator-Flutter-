// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:native_ios_dialog/native_ios_dialog.dart';
// import 'package:nurture/Screens/editProfile/Models/editProfileScreenModel.dart';
// import 'package:nurture/Screens/editProfile/Repository/editProfileScreenApi.dart';
// import 'package:nurture/Constants/Strings.dart';

// class EditProfileScreenState {
//   final TextEditingController firstNameTextFeildController;
//   final TextEditingController lastNameTextFeildController;
//   final TextEditingController emailTextFeildController;
//   final TextEditingController phoneNumberTextFeildController;
//   final TextEditingController addressLine1TextFeildController;
//   final TextEditingController addressLine2TextFeildController;
//   final TextEditingController stateTextFeildController;
//   final TextEditingController zipCodeTextFeildController;
//   final String? selectedRelation;
//   final String? selectedFacility;
//   final String? selectedPhysician;
//   final String? selectedLocation;
//   final TextEditingController locationTextFeildController;
//   File? croppedImage;
//   final List<String> selectLocationDropDownItems;
//   final List<String> selectFacilityDropDownItems;
//   final List<String> selectPhysicianDropDownItems;
//   List<String> facilityIds;

//   EditProfileScreenState({
//     required this.firstNameTextFeildController,
//     required this.lastNameTextFeildController,
//     required this.emailTextFeildController,
//     required this.phoneNumberTextFeildController,
//     required this.addressLine2TextFeildController,
//     required this.addressLine1TextFeildController,
//     required this.stateTextFeildController,
//     required this.zipCodeTextFeildController,
//     required this.selectedRelation,
//     required this.selectedLocation,
//     required this.selectedFacility,
//     required this.selectedPhysician,
//     required this.locationTextFeildController,
//     required this.croppedImage,
//     required this.selectLocationDropDownItems,
//     required this.selectFacilityDropDownItems,
//     required this.selectPhysicianDropDownItems,
//     required this.facilityIds,
//   });

//   EditProfileScreenState copyWith({
//     TextEditingController? firstNameTextFeildController,
//     TextEditingController? lastNameTextFeildController,
//     TextEditingController? phoneNumberTextFeildController,
//     TextEditingController? emailTextFeildController,
//     TextEditingController? addressLine2TextFeildController,
//     TextEditingController? addressLine1TextFeildController,
//     TextEditingController? stateTextFeildController,
//     TextEditingController? zipCodeTextFeildController,
//     String? selectedRelation,
//     String? selectedLocation,
//     String? selectedFacility,
//     String? selectedPhysician,
//     TextEditingController? locationTextFeildController,
//     File? croppedImage,
//     List<String>? selectLocationDropDownItems,
//     List<String>? selectFacilityDropDownItems,
//     List<String>? selectPhysicianDropDownItems,
//     List<String>? facilityIds,
//   }) {
//     return EditProfileScreenState(
//       firstNameTextFeildController:
//           firstNameTextFeildController ?? this.firstNameTextFeildController,
//       lastNameTextFeildController:
//           lastNameTextFeildController ?? this.lastNameTextFeildController,
//       emailTextFeildController:
//           emailTextFeildController ?? this.emailTextFeildController,
//       phoneNumberTextFeildController:
//           phoneNumberTextFeildController ?? this.phoneNumberTextFeildController,
//       addressLine1TextFeildController:
//           addressLine1TextFeildController ??
//           this.addressLine1TextFeildController,
//       addressLine2TextFeildController:
//           addressLine2TextFeildController ??
//           this.addressLine2TextFeildController,
//       stateTextFeildController:
//           stateTextFeildController ?? this.stateTextFeildController,
//       zipCodeTextFeildController:
//           zipCodeTextFeildController ?? this.zipCodeTextFeildController,
//       selectedRelation: selectedRelation ?? this.selectedRelation,
//       selectedLocation: selectedLocation ?? this.selectedLocation,
//       selectedFacility: selectedFacility ?? this.selectedFacility,
//       selectedPhysician: selectedPhysician ?? this.selectedPhysician,
//       locationTextFeildController:
//           locationTextFeildController ?? this.locationTextFeildController,
//       croppedImage: croppedImage ?? this.croppedImage,
//       selectLocationDropDownItems:
//           selectLocationDropDownItems ?? this.selectLocationDropDownItems,
//       selectFacilityDropDownItems:
//           selectFacilityDropDownItems ?? this.selectFacilityDropDownItems,
//       selectPhysicianDropDownItems:
//           selectPhysicianDropDownItems ?? this.selectPhysicianDropDownItems,
//       facilityIds: facilityIds ?? this.facilityIds,
//     );
//   }
// }

// class EditProfileScreenStateNotifier
//     extends StateNotifier<EditProfileScreenState> {
//   EditProfileScreenStateNotifier()
//     : super(
//         EditProfileScreenState(
//           firstNameTextFeildController: TextEditingController(),
//           lastNameTextFeildController: TextEditingController(),
//           emailTextFeildController: TextEditingController(),
//           phoneNumberTextFeildController: TextEditingController(),
//           addressLine1TextFeildController: TextEditingController(),
//           addressLine2TextFeildController: TextEditingController(),
//           stateTextFeildController: TextEditingController(),
//           zipCodeTextFeildController: TextEditingController(),
//           selectedRelation: null,
//           selectedLocation: null,
//           selectedFacility: null,
//           selectedPhysician: null,
//           locationTextFeildController: TextEditingController(),
//           croppedImage: null,
//           selectLocationDropDownItems: [],
//           selectFacilityDropDownItems: [],
//           selectPhysicianDropDownItems: [],
//           facilityIds: [],
//         ),
//       );

//   // updating the selected deopdown value in ui
//   Future<void> updateDropDownSelectedValue(
//     String val,
//     String titleText,
//     BuildContext context,
//   ) async {
//     if (titleText == ConstantStrings.relationshipDropdownFeildTitle) {
//       state = state.copyWith(selectedRelation: val);
//     } else if (titleText == ConstantStrings.facilityDropdownFeildTitle &&
//         (state.selectedLocation != null || state.selectedLocation != "")) {
//       state = state.copyWith(selectedFacility: val);
//       physicianFetching(context);
//     } else if (titleText == ConstantStrings.physicianshipDropdownFeildTitle &&
//         state.selectedFacility != null) {
//       state = state.copyWith(selectedPhysician: val);
//     }
//   }

//   void nullCheckingLocation(String val) {
//     if (val == "") {
//       state = state.copyWith(
//         selectedFacility: null,
//         selectedPhysician: null,
//         selectPhysicianDropDownItems: [],
//         selectFacilityDropDownItems: [],
//         selectedLocation: null,
//       );
//     }
//   }

//   // empty validation before submitting
//   emptyValidation(BuildContext context) {
//     if (state.firstNameTextFeildController.text.trim().isEmpty) {
//       alertFunction(context, "Enter FirstName");
//     } else if (state.lastNameTextFeildController.text.trim().isEmpty) {
//       alertFunction(context, "Enter FirstName");
//     } else if (state.emailTextFeildController.text.trim().isEmpty &&
//         state.phoneNumberTextFeildController.text.trim().isEmpty) {
//       alertFunction(
//         context,
//         state.emailTextFeildController.text.trim().isEmpty
//             ? "Enter Email"
//             : "Enter Phone Number",
//       );
//     } else if (state.emailTextFeildController.text.trim().isNotEmpty &&
//         emailValidation(state.emailTextFeildController.text)) {
//       alertFunction(context, "Enter valid Email");
//     } else if (state.selectedRelation == null) {
//       alertFunction(context, "Select Relationship");
//     } else {
//       alertFunction(context, "Profile Saved");
//     }
//   }

//   // ios native aler popUp
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

//   // email validation
//   bool emailValidation(String enteredEmail) {
//     final bool emailValid = RegExp(
//       "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*",
//     ).hasMatch(enteredEmail);
//     return emailValid;
//   }
//   // get api dropDown list Items updating from api response to ui

//   Future<List<String>> dropDownItemsUpdation(
//     String titleText,
//     BuildContext context,
//     String userInputText,
//   ) async {
//     if (titleText == ConstantStrings.locationDropdownFeildTitle) {
//       state = state.copyWith(
//         selectLocationDropDownItems: await Editprofilescreenapi()
//             .getLocationsFromApi(userInputText),
//       );
//       if (state.selectLocationDropDownItems.isEmpty) {
//         state = state.copyWith(
//           selectFacilityDropDownItems: [],
//           selectedFacility: null,
//         );
//       }
//     }
//     return state.selectLocationDropDownItems;
//   }

//   Future<List<String>> facilityFetching(
//     BuildContext context,
//     String selectedLocation,
//   ) async {
//     List<Facility> facilities = await Editprofilescreenapi().getFacilityFromApi(
//       selectedLocation,
//     );

//     List<String> facilityNames =
//         facilities.map((facility) => facility.name).toList();
//     List<String> facilityIds =
//         facilities.map((facility) => facility.id).toList();
//     if (facilityNames.isEmpty) {
//       alertFunction(context, "No Facility fonund");
//     } else {
//       state = state.copyWith(selectFacilityDropDownItems: facilityNames);
//       state = state.copyWith(selectedFacility: null);
//       state = state.copyWith(facilityIds: facilityIds);
//     }
//     print('Facility Names ==> $facilityNames');
//     print('Facility id ==> $facilityIds');

//     return state.selectFacilityDropDownItems;
//   }

//   physicianFetching(context) async {
//     List<Physicians> physicians = await Editprofilescreenapi()
//         .getPhysiciansFromApi(
//           state.facilityIds.elementAt(
//             state.selectFacilityDropDownItems.indexOf(state.selectedFacility!),
//           ),
//         );

//     List<String> physiciansNames = [];
//     physiciansNames =
//         physicians
//             .map(
//               (facility) =>
//                   "${facility.firstName} ${facility.lastName}  (${facility.specialist})",
//             )
//             .toList();
//     print("physiciansNames ==> $physiciansNames");

//     if (physiciansNames.isEmpty) {
//       alertFunction(context, "No Physicians found at this facility");
//       state = state.copyWith(selectPhysicianDropDownItems: null);
//     } else {
//       state = state.copyWith(selectPhysicianDropDownItems: physiciansNames);
//     }
//   }
// }

// final editProfileScreenStateNotifier = StateNotifierProvider.autoDispose<
//   EditProfileScreenStateNotifier,
//   EditProfileScreenState
// >((ref) {
//   var notifier = EditProfileScreenStateNotifier();
//   return notifier;
// });
