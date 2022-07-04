import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'selectcolor_state.dart';

class SelectcolorCubit extends Cubit<SelectcolorState> {
  final List colours;
  SelectcolorCubit(this.colours) : super(SelectcolorInitial(colours[0], 0));

  void OnColorClick(Map colour, int index) {
    emit(SelectcolorInitial(colour, index));
  }
}
