import 'package:flutter/material.dart';
import 'package:flutter_application_1/MasterContainer/Screen/masterContainerScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

void main() {
      runApp(ProviderScope(
      child: FlutterSizer(builder: (context, orientation, screenType) {
    return const MyApp();
  })));
  
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
   return MaterialApp(
    debugShowCheckedModeBanner : false,
      home:MasterContainerScreen(),
    );
}
}
// AIzaSyAi_N1J9j9G6cLP_U4gg6wv7_Dik1Gl3nA



