// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';

// import '../state/addMedicalIssueState.dart';

// class addMedicalIssueScreen extends ConsumerStatefulWidget {
//   const addMedicalIssueScreen({super.key});
//   @override
//   addMedicalIssueState createState() => addMedicalIssueState();
// }

// class addMedicalIssueState extends ConsumerState<addMedicalIssueScreen> {
//   String? selectedVit;
//   final List<String> allVitals = ['Heart Rate', 'Blood Glucose', 'Temperature'];
  
//   static var unitValueCOntroller;
  

//   @override
//   Widget build(BuildContext context) {
//     var addMedicalIssueState = ref.watch(addMedicalIssueNotifier);
//     final state = ref.watch(addMedicalIssueNotifier);
//     final notifier = ref.read(addMedicalIssueNotifier.notifier);

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: SingleChildScrollView(
//           reverse: true,
//           child: Container(
//             child: Column(
//               children: [
//                 customTextFeildView(
//                   "Main Problem",
//                   "Enter Main Problem",
//                   addMedicalIssueState.mainProblemController,
//                   context,
//                 ),

//                 SizedBox(height: 1.h),

//                 customTextFeildView(
//                   "Associated Problem",
//                   "Enter Associated Problem",
//                   addMedicalIssueState.associatedProblemController,
//                   context,
//                 ),

//                 SizedBox(height: 1.h),

//                 Container(
//                   height: 70,

//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Color.fromARGB(184, 237, 237, 237),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 10, left: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Add Vitals",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Color.fromARGB(255, 2, 3, 3),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: 2, bottom: 3, left: 0),
//                           child: SizedBox(
//                             height: 30,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 customToggleButton(
//                                   label: "Yes",
//                                   image: ConstantAssets.selectedGreenIcon,
//                                   ref: ref,
//                                   isYesButton: true,
//                                   toggleType: ToggleType.vital,
//                                 ),
//                                 customToggleButton(
//                                   label: "No",
//                                   image: ConstantAssets.selectedRedIcon,
//                                   ref: ref,
//                                   isYesButton: false,
//                                   toggleType: ToggleType.vital,
//                                 ),

//                                 Spacer(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 1.h),

//                 Visibility(
//                   visible: addMedicalIssueState.isVitalSelected ?? false,
//                   child: Container(
//                     child: Column(
//                       children: [
//                         ...state.vitalEntries.asMap().entries.map((entry) {
//                           final index = entry.key;
//                           return Column(
//                             children: [
//                               customAddVitalView(
//                                 context,
//                                 ref,
//                                 index,
//                                 allVitals,
//                               ), // Pass `items` as list of all vitals
//                               SizedBox(height: 1.h),
//                             ],
//                           );
//                         }),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 1.h),

//                 Container(
//                   height: 95,

//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Color.fromARGB(184, 237, 237, 237),
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 10, left: 20),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 5),
//                           child: Text(
//                             "Would you like to share the medical condition of the child with doctor?",
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Color.fromARGB(255, 2, 3, 3),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5, bottom: 3),
//                           child: SizedBox(
//                             height: 30,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 customToggleButton(
//                                   label: "Yes",
//                                   image: ConstantAssets.selectedGreenIcon,
//                                   ref: ref,
//                                   isYesButton: true,
//                                   toggleType: ToggleType.shareWithDoctor,
//                                 ),
//                                 customToggleButton(
//                                   label: "No",
//                                   image: ConstantAssets.selectedRedIcon,
//                                   ref: ref,
//                                   isYesButton: false,
//                                   toggleType: ToggleType.shareWithDoctor,
//                                 ),

//                                 Spacer(),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 3.h),

//                 SizedBox(
//                   height: 8.h,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           15,
//                         ), // Set the radius here
//                       ),
//                       backgroundColor: Color.fromARGB(255, 0, 196, 239),
//                     ),
//                     onPressed: () {
//                       notifier.emptyValidation(context);
//                     },
//                     child: Text(
//                       'ADD',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   //MARK: CustomWidgets

//   // customTextfeildView with label and textFeild

//   Widget customTextFeildView(
//     String title,
//     String placeholder,
//     TextEditingController controller,
//     BuildContext context,
//   ) {
//     return Container(
//       height: 70,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: const Color.fromARGB(255, 204, 204, 204),
//           width: 2,
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.only(top: 7, left: 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Color.fromARGB(255, 0, 196, 239),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 3, bottom: 3),
//               child: SizedBox(
//                 height: 30,
//                 child: TextField(
//                    keyboardType : TextInputType.text,
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: placeholder,
//                     hintStyle: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500,
//                       color: Color.fromARGB(255, 197, 197, 197),
//                     ),
//                   ),
//                   controller: controller,
//                   onChanged: (value) {
//                     print("$title ===> $value");
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // For toggle button(image with text)

//   Widget customToggleButton({
//     required String label,
//     required String image,
//     required WidgetRef ref,
//     required bool isYesButton,
//     required ToggleType toggleType,
//   }) {
//     final state = ref.watch(addMedicalIssueNotifier);
//     final notifier = ref.read(addMedicalIssueNotifier.notifier);

//     bool? currentValue;
//     switch (toggleType) {
//       case ToggleType.vital:
//         currentValue = state.isVitalSelected;
//         break;
//       case ToggleType.shareWithDoctor:
//         currentValue = state.isShareWithDoctor;
//         break;
//     }

//     final bool shouldHighlight = currentValue == (isYesButton ? true : false);

//     return Row(
//       children: [
//         CupertinoButton(
//           padding: EdgeInsets.zero,
//           onPressed: () {
//             notifier.toggleSelection(toggleType, isYesButton);
//           },
//           child: Image.asset(
//             shouldHighlight ? image : ConstantAssets.greyCircleIcon,
//             width: 25,
//             height: 20,
//           ),
//         ),
//         Text(label, style: const TextStyle(fontSize: 18)),
//         SizedBox(width: 10),
//       ],
//     );
//   }

//   Widget customAddVitalView(
//     BuildContext context,
//     WidgetRef ref,
//     int index,
//     List<String> allVitals,
//   ) {
//     final state = ref.watch(addMedicalIssueNotifier);
//     final notifier = ref.read(addMedicalIssueNotifier.notifier);
//     final entry = state.vitalEntries[index];
//     final availableVitals = notifier.getAvailableVitals(allVitals, index);
  
//     final selectedVital = entry.selectedVital;
//     final unit = notifier.getUnitFromVital(selectedVital);
//     // final vitalEntries = state.vitalEntries;

//     bool isOnlyOne = state.vitalEntries.length == 1;
//     bool isLast = index == state.vitalEntries.length - 1;
//     bool allVitalsUsed = state.vitalEntries.length == allVitals.length;
//     print('---->  $selectedVital');
//     print("Dropdown items for index $index: $availableVitals");
//     print("Selected value: $selectedVital");

//     return Column(
//       children: [
//         Container(
//           height: 70,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: const Color.fromARGB(255, 204, 204, 204),
//               width: 2,
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(top: 7, left: 15),
//             child: Row(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Vitals",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Color.fromARGB(255, 0, 196, 239),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 3),
//                       child: SizedBox(
//                         height: 30,

//                         child: CustomDropdownButton2(
//                           hint: "Select Vital",

//                           value:
//                               selectedVital, // This should be the currently selected vital
//                           dropdownItems:
//                               availableVitals, // This should be the list without duplicates
//                           onChanged: (value) {
//                             notifier.updateVital(index, value);
//                           },

//                           buttonHeight: 30,
//                           buttonWidth: 70.w,
//                           buttonDecoration: const BoxDecoration(
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: Colors.transparent,
//                                 width: 1,
//                               ),
//                             ),
//                           ),
//                           buttonPadding: const EdgeInsets.only(
//                             left: 0,
//                             right: 0,
//                           ),

//                           iconSize: 0,
//                           iconEnabledColor: Colors.transparent,
//                           iconDisabledColor: Colors.transparent,
//                           dropdownWidth: 85.w,
//                           dropdownDecoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: Colors.grey.shade300),
//                           ),
//                           valueAlignment: Alignment.centerLeft,
//                           hintAlignment: Alignment.centerLeft,
//                           selectedItemBuilder: (context) {
//                             return availableVitals.map((item) {
//                               return Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   item,
//                                   style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               );
//                             }).toList();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.only(right:25.0),
//                   child: Image.asset(ConstantAssets.downArrow, width: 25),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         SizedBox(height: 1.h),
//         // unit + buttons view
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Flexible container with bordered input
//             Expanded(
//               child: Container(
//                 height: 70,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 204, 204, 204),
//                     width: 2,
//                   ),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   children: [
//                     // Flexible text input
//                     Expanded(
//                       child: TextField(
//                         keyboardType : TextInputType.number,
//                         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//                          controller: addMedicalIssueState.unitValueCOntroller,
//                           onChanged: (val) {notifier.updateVitalValue(index, val);},
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Enter Value",
//                           hintStyle: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Color.fromARGB(255, 197, 197, 197),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Divider
//                     Container(
//                       height: 70,
//                       width: 1,
//                       color: const Color.fromARGB(255, 197, 197, 197),
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                     ),
//                     // Unit text
//                     Text(
//                       unit,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                         color: Color.fromARGB(255, 0, 196, 239),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(width: 8),

//             // Bluetooth button (invisible for now)
//             Visibility(
//               visible: selectedVital == 'Temperature',
//               child: IconButton(
//                 onPressed: null,
//                 icon: Image.asset(
//                   ConstantAssets.bluetoothIcon,
//                   width: 60,
//                   height: 60,
//                 ),
//               ),
//             ),

//             // Add/Delete button
//             IconButton(
//               onPressed: () {
//                 if (allVitalsUsed) {
//                   if (!isOnlyOne) {
//                     notifier.removeVitalEntry(index);
//                   }
//                 } else {
//                   if (isLast) {
//                     final unitValue = state.vitalEntries[index].value.trim();
//                     if(selectedVital == null){
//                       notifier.alertFunction(
//                         context,
//                         "Select Vital.",
//                       );
//                       return;
//                     }
//                     else if (unitValue.isEmpty) {
//                       notifier.alertFunction(
//                         context,
//                         "Enter $selectedVital value.",
//                       );
//                       return;
//                     }

//                     notifier.addVitalEntry1(allVitals);
//                   } else {
//                     notifier.removeVitalEntry(index);
//                   }
//                 }
//               },
//               icon: Image.asset(
//                 allVitalsUsed || !isLast
//                     ? ConstantAssets.deleteIcon
//                     : ConstantAssets.addIcon,
//                 width: 60,
//                 height: 60,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
