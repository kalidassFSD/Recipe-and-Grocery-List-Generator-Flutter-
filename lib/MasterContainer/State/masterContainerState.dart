// master_container_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/Constants/Constants.dart';

class MasterContainerState {
  final ModuleKeys currentModule;

  MasterContainerState({required this.currentModule});

  MasterContainerState copyWith({ModuleKeys? currentModule}) {
    return MasterContainerState(
      currentModule: currentModule ?? this.currentModule,
    );
  }
}

class MasterContainerStateNotifier extends StateNotifier<MasterContainerState> {
  MasterContainerStateNotifier()
      : super(MasterContainerState(currentModule: ModuleKeys.homeScreen));

  void setModule(ModuleKeys module) {
    state = state.copyWith(currentModule: module);
  }


  String changeHeaderTextForScreen(){
    if(state.currentModule == ModuleKeys.groceryScreen){
      return "Grocery List";
    }
    return "" ;
  }

}

final masterContainerProvider = StateNotifierProvider<MasterContainerStateNotifier, MasterContainerState>(
  (ref) => MasterContainerStateNotifier(),
);
