import 'package:equatable/equatable.dart';

abstract class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object?> get props => [];
}

class EnableOrDisableNotifications extends SwitchEvent {}

class SliderEvent extends SwitchEvent {
  final double slider;
  const SliderEvent({required this.slider});

  @override
  List<Object?> get props => [slider];
}
