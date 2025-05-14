
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/MasterContainer/State/masterContainerState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../Constants/constantAssets.dart';


class Commonviews {

  static Widget header(BuildContext context,String headerTitle, WidgetRef ref){
          final notifier = ref.read(masterContainerProvider.notifier);
          

    return Container(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
           Image.asset(ConstantAssets.headerBg, width: double.infinity,height:14.h, fit: BoxFit.fill,),
           Padding(padding: EdgeInsets.only(top: 3.h,bottom: 2.h,left:1.h,right: 1.h),
           child: Row(
              children: [
                IconButton(onPressed: (){  notifier.setModule(ModuleKeys.homeScreen); }, icon: Image.asset(ConstantAssets.headerBackIcon,width: 7.w,height: 7.h)),
                Spacer(),
                Text(headerTitle , style: TextStyle(fontSize:20 ,fontWeight: FontWeight.bold , color: Colors.white)),
                Spacer(),
                IconButton(onPressed: (){}, icon: Image.asset(ConstantAssets.headerMenuIcon,width: 7.w,height: 7.h))
              ] ,
           ), 
          ),  
        ]
      ) 
      );
  }




static Future<File?> imagePickerPopup(BuildContext context) async {
  final ImagePicker picker = ImagePicker();

  Future<File?> pickAndCropImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
       
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );
      if (croppedFile != null) {
        return File(croppedFile.path);
      }
    }
    return null;
  }

  return await showDialog<File?>(
    context: context,
    barrierColor: Color.fromRGBO(153, 238, 255, 0.8),
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Color.fromARGB(255, 41, 64, 102),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Open Form", style: TextStyle(fontSize: 20, color: Colors.white)),
            SizedBox(height: 10),
            Divider(color: Colors.white, thickness: 2),
            SizedBox(height: 10),
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                final cropped = await pickAndCropImage(ImageSource.camera);
                Navigator.pop(context, cropped);
              },
              child: Image.asset(ConstantAssets.cameraIcon, width: 50, height: 50),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                final cropped = await pickAndCropImage(ImageSource.gallery);
                Navigator.pop(context, cropped);
              },
              child: Image.asset(ConstantAssets.galleryIcon, width: 50, height: 50),
            ),
          ],
        ),
      ),
    ),
  );
}


}
// import 'package:flutter/material.dart';
// import 'package:search_map_location/search_map_location.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: Text('Location Search')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SearchLocation(
//             apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
//             onSelected: (Place place) {
//               print('Selected Place: ${place.description}');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
