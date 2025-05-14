import 'package:flutter/material.dart';
import 'dart:io';

class Constants {}

class ConstantURLs {
 
}

bool get isIpad {
  return Platform.isIOS;
}

class ScreenSize {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenMaxLength(BuildContext context) =>
      screenWidth(context) > screenHeight(context)
          ? screenWidth(context)
          : screenHeight(context);

  static double screenMinLength(BuildContext context) =>
      screenWidth(context) < screenHeight(context)
          ? screenWidth(context)
          : screenHeight(context);
}

enum ModuleKeys { groceryScreen,recpieScreen,homeScreen }

enum ModuleScreenKeys { add }

enum PopupTypes { bluetoothPopUp }

enum PopupAction { show, hide }
