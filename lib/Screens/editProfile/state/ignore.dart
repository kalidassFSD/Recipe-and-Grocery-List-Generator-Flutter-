// File? _croppedImage;

// Widget build(BuildContext context) {
//   return Container(
//     decoration: BoxDecoration(shape: BoxShape.circle),
//     child: SizedBox(
//       height: 15.h,
//       width: 25.w,
//       child: GestureDetector(
//         onTap: () async {
//           File? image = await Commonviews.imagePickerPopup(context);
//           if (image != null) {
//             setState(() {
//               _croppedImage = image;
//             });
//           }
//         },
//         child: Stack(
//           alignment: AlignmentDirectional(0.h, 0.w),
//           children: [
//             Positioned(
//               top: 15,
//               child: _croppedImage != null
//                   ? ClipOval(
//                       child: Image.file(
//                         _croppedImage!,
//                         width: 24.w,
//                         height: 12.h,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : Image.asset(
//                       ConstantAssets.defaultProfileIMage,
//                       width: 24.w,
//                       height: 12.h,
//                     ),
//             ),
//             Positioned(
//               bottom: 0.h,
//               right: 0.5.w,
//               child: Image.asset(
//                 ConstantAssets.editProfileIcon,
//                 width: 8.w,
//                 height: 8.h,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
