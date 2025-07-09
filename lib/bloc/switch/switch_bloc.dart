import 'package:bloc_practice/bloc/switch/switch_event.dart';
import 'package:bloc_practice/bloc/switch/switch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(SwitchState()) {
    on<EnableOrDisableNotifications>(_enableOrDisableNotifications);
    on<SliderEvent>(_sliderEvent);
  }

  void _enableOrDisableNotifications(
    EnableOrDisableNotifications event,
    Emitter<SwitchState> emit,
  ) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _sliderEvent(SliderEvent event, Emitter<SwitchState> emit) {
    emit(state.copyWith(slider: event.slider));
  }
}
