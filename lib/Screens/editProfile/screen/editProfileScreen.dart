// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:nurture/ReusableWidgets/CommonViews.dart';
// import 'package:nurture/Constants/Strings.dart';
// import 'package:nurture/Constants/constantAssets.dart';
// import 'package:nurture/ReusableWidgets/CustomDropdownButton2.dart';
// import 'package:nurture/Screens/editProfile/state/editProfileState.dart';
// import 'package:drop_down_search_field/drop_down_search_field.dart';

// class Editprofilescreen extends ConsumerStatefulWidget {
//   const Editprofilescreen({super.key});

//   @override
//   EditprofileScreenState createState() => EditprofileScreenState();
// }

// class EditprofileScreenState extends ConsumerState<Editprofilescreen> {
//   final List<String> selectRelationShipDropDownItems = ['Mother', 'Father'];

//   @override
//   Widget build(BuildContext context) {
//     final editprofileScreenState = ref.watch(editProfileScreenStateNotifier);
//     final notifier = ref.read(editProfileScreenStateNotifier.notifier);
//     return Padding(
//       padding: const EdgeInsets.only(left: 15.0, right: 15.0),
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(shape: BoxShape.circle),
//               child: SizedBox(
//                 height: 15.h,
//                 width: 25.w,
//                 child: GestureDetector(
//                   onTap: () async {
//                     File? image = await Commonviews.imagePickerPopup(context);
//                     editprofileScreenState.croppedImage = image;
//                                     },
//                   child: Stack(
//                     alignment: AlignmentDirectional(0.h, 0.w),
//                     children: [
//                       Positioned(
//                         top: 15,
//                         child: ClipOval(
//                           child:
//                               editprofileScreenState.croppedImage != null
//                                   ? Image.file(
//                                     editprofileScreenState.croppedImage!,
//                                     width: 24.w,
//                                     height: 12.h,
//                                     fit: BoxFit.cover,
//                                   )
//                                   : Image.asset(
//                                     ConstantAssets.defaultProfileIMage,
//                                     width: 24.w,
//                                     height: 12.h,
//                                   ),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: 0.h,
//                         right: 0.5.w,
//                         child: Image.asset(
//                           ConstantAssets.editProfileIcon,
//                           width: 8.w,
//                           height: 8.h,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             customTextFeidView(
//               context,
//               "Enter First Name",
//               ConstantStrings.firstNameTitle,
//               editprofileScreenState.firstNameTextFeildController,
//             ),
//             SizedBox(height: 2.h),
//             customTextFeidView(
//               context,
//               "Enter Last Name",
//               ConstantStrings.lastNameTitle,
//               editprofileScreenState.lastNameTextFeildController,
//             ),
//             SizedBox(height: 2.h),
//             customTextFeidView(
//               context,
//               "Enter email",
//               ConstantStrings.emailAddressTitle,
//               editprofileScreenState.emailTextFeildController,
//             ),
//             SizedBox(height: 2.h),
//             customTextFeidView(
//               context,
//               "Enter phone number",
//               ConstantStrings.phoneNumberTitle,
//               editprofileScreenState.phoneNumberTextFeildController,
//             ),
//             SizedBox(height: 2.h),
//             customTextFeidView(
//               context,
//               "Enter Address line 1",
//               ConstantStrings.adddressLine1Title,
//               editprofileScreenState.addressLine1TextFeildController,
//             ),
//             SizedBox(height: 2.h),
//             customTextFeidView(
//               context,
//               "Enter Address line 2",
//               ConstantStrings.adddressLine2Title,
//               editprofileScreenState.addressLine2TextFeildController,
//             ),
//             SizedBox(height: 2.h),
//             customTextFeidView(
//               context,
//               "Enter state",
//               ConstantStrings.stateTitle,
//               editprofileScreenState.stateTextFeildController,
//             ),
//             SizedBox(height: 2.h),
//             customTextFeidView(
//               context,
//               "Enter zipCode",
//               ConstantStrings.zipCodeTitle,
//               editprofileScreenState.zipCodeTextFeildController,
//             ),
//             SizedBox(height: 2.h),
//             customDropDownView(
//               context,
//               ConstantStrings.relationshipDropdownFeildTitle,
//               "Select Relationship",
//               selectRelationShipDropDownItems,
//             ),
//             SizedBox(height: 2.h),
//             customSearchableDropDownView(
//               context,
//               ConstantStrings.locationDropdownFeildTitle,
//               editprofileScreenState.selectLocationDropDownItems,
//               editprofileScreenState.locationTextFeildController,
//             ),

//             SizedBox(height: 2.h),
//             customDropDownView(
//               context,
//               ConstantStrings.facilityDropdownFeildTitle,
//               "Select Facility",
//               editprofileScreenState.selectFacilityDropDownItems,
//             ),
//             SizedBox(height: 2.h),
//             customDropDownView(
//               context,
//               ConstantStrings.physicianshipDropdownFeildTitle,
//               "Select Physician",
//               editprofileScreenState.selectPhysicianDropDownItems,
//             ),
//             SizedBox(height: 2.h),
//             SizedBox(
//               height: 8.h,
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   backgroundColor: Color.fromARGB(255, 0, 196, 239),
//                 ),
//                 onPressed: () {
//                   notifier.emptyValidation(context);
//                 },
//                 child: Text(
//                   'SAVE',
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 255, 255, 255),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget customTextFeidView(
//     BuildContext context,
//     String placeholderText,
//     String titleText,
//     TextEditingController controller,
//   ) {
//     return Container(
//       height: 9.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: const Color.fromARGB(255, 204, 204, 204),
//           width: 2,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 7, left: 15.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               titleText,
//               style: TextStyle(
//                 color: Color.fromARGB(255, 0, 196, 239),
//                 fontSize: 15,
//               ),
//             ),

//             SizedBox(
//               height: 5.h,
//               child: TextField(
//                 keyboardType:
//                     titleText == ConstantStrings.phoneNumberTitle
//                         ? TextInputType.numberWithOptions()
//                         : TextInputType.text,
//                 decoration: InputDecoration(
//                   hintText: placeholderText,
//                   hintStyle: TextStyle(
//                     fontSize: 18,
//                     color: const Color.fromARGB(255, 204, 204, 204),
//                   ),
//                   border: InputBorder.none,
//                   labelStyle: TextStyle(fontSize: 18),
//                 ),
//                 controller: controller,
//                 onChanged: (value) => {print('$titleText ===> $value')},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget customDropDownView(
//     BuildContext context,
//     String titleText,
//     String placeholderText,
//     List<String> dropDownItems,
//   ) {
//     final state = ref.watch(editProfileScreenStateNotifier);
//     final notifier = ref.read(editProfileScreenStateNotifier.notifier);

//     return Container(
//       height: 9.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: const Color.fromARGB(255, 204, 204, 204),
//           width: 2,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 7, left: 15.0),
//         child: Row(
//           children: [
//             SizedBox(
//               width: 75.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     titleText,
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 0, 196, 239),
//                       fontSize: 15,
//                     ),
//                   ),

//                   SizedBox(
//                     height: 5.h,
//                     child: CustomDropdownButton2(
//                       hint: placeholderText,

//                       value:
//                           titleText ==
//                                   ConstantStrings.relationshipDropdownFeildTitle
//                               ? state.selectedRelation
//                               : titleText ==
//                                   ConstantStrings.facilityDropdownFeildTitle
//                               ? state.selectedFacility
//                               : state.selectedPhysician,
//                       dropdownItems:
//                           titleText ==
//                                   ConstantStrings.relationshipDropdownFeildTitle
//                               ? selectRelationShipDropDownItems
//                               : titleText ==
//                                   ConstantStrings.facilityDropdownFeildTitle
//                               ? state.selectFacilityDropDownItems
//                               : state.selectPhysicianDropDownItems,
//                       onChanged: (value) {
//                         notifier.updateDropDownSelectedValue(
//                           value!,
//                           titleText,
//                           context,
//                         );
//                       },

//                       buttonHeight: 30,
//                       buttonWidth: 70.w,
//                       buttonDecoration: const BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(
//                             color: Colors.transparent,
//                             width: 1,
//                           ),
//                         ),
//                       ),
//                       buttonPadding: const EdgeInsets.only(left: 0, right: 0),

//                       iconEnabledColor: Colors.transparent,
//                       iconDisabledColor: Colors.transparent,
//                       dropdownWidth: 85.w,
//                       dropdownDecoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.grey.shade300),
//                       ),
//                       valueAlignment: Alignment.centerLeft,
//                       hintAlignment: Alignment.centerLeft,
//                       selectedItemBuilder: (context) {
//                         return dropDownItems.map((item) {
//                           return Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               item,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w400,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           );
//                         }).toList();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Image.asset(ConstantAssets.downArrow, width: 7.w, height: 7.h),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget customSearchableDropDownView(
//     BuildContext context,
//     String titleText,
//     List<String> dropDownItems,
//     TextEditingController controller,
//   ) {
//     final notifier = ref.read(editProfileScreenStateNotifier.notifier);
//     final editprofileScreenState = ref.watch(editProfileScreenStateNotifier);
//     return Container(
//       height: 9.h,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: const Color.fromARGB(255, 204, 204, 204),
//           width: 2,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(top: 7, left: 15.0),
//         child: Row(
//           children: [
//             SizedBox(
//               width: 75.w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     titleText,
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 0, 196, 239),
//                       fontSize: 15,
//                     ),
//                   ),

//                   SizedBox(
//                     height: 5.h,
//                     child: DropDownSearchField<String>(
//                       isMultiSelectDropdown: false,
//                       displayAllSuggestionWhenTap: false,
//                       textFieldConfiguration: TextFieldConfiguration(
//                         controller: controller,
//                         onChanged: (value) {
//                           notifier.nullCheckingLocation(value);
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Select Location",
//                           hintStyle: TextStyle(
//                             fontSize: 18,
//                             color: const Color.fromARGB(255, 204, 204, 204),
//                           ),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                       suggestionsCallback: (val) async {
//                         final results = notifier.dropDownItemsUpdation(
//                           titleText,
//                           context,
//                           val,
//                         );
//                         return results;
//                       },
//                       itemBuilder: (context, suggestion) {
//                         return ListTile(title: Text(suggestion));
//                       },
//                       onSuggestionSelected: (val) {
//                         controller.text = val;
//                         editprofileScreenState.copyWith(selectedLocation: val);
//                         print(
//                           "=====> $editprofileScreenState.selectedLocation",
//                         );
//                         notifier.facilityFetching(context, val);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SvgPicture.asset(
//               ConstantAssets.searchIcon,
//               width: 3.w,
//               height: 3.h,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
