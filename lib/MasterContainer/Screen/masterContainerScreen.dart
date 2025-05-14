// master_container_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants/Constants.dart';
import 'package:flutter_application_1/MasterContainer/State/masterContainerState.dart';
import 'package:flutter_application_1/ReusableWidgets/CommonViews.dart';
import 'package:flutter_application_1/Screens/GroceryList/Screen/GroceryListScreen.dart';
import 'package:flutter_application_1/Screens/HomePage/Screen/HomePageScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MasterContainerScreen extends ConsumerWidget {
  const MasterContainerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final masterContainerScreenState = ref.watch(masterContainerProvider);
final notifier = ref.read(masterContainerProvider.notifier);
    return SafeArea(
      top: false,
      bottom: false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Commonviews.header(context,notifier.changeHeaderTextForScreen(), ref),
              Expanded(child: _getChildContainer(masterContainerScreenState.currentModule)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getChildContainer(ModuleKeys module) {
    switch (module) {
      case ModuleKeys.groceryScreen:
        return GroceryListScreen();
      case ModuleKeys.homeScreen:
        return HomeScreen();
      default:
        return Container();
    }
  }
}
