import 'package:bloc_practice/bloc/image_picker/image_picker_event.dart';
import 'package:bloc_practice/bloc/image_picker/image_picker_state.dart';
import 'package:bloc_practice/utils/image_picker_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  final ImagePickerUtils image;

  ImagePickerBloc(this.image) : super(const ImagePickerState()) {
    on<CameraCapture>(_cameraCapture);
    on<GalleryImagePicker>(_galleryImagePicker);
  }

  void _cameraCapture(
    CameraCapture event,
    Emitter<ImagePickerState> emit,
  ) async {
    XFile? file = await image.cameraCapture();
    emit(state.copyWith(file: file));
  }

  void _galleryImagePicker(
    GalleryImagePicker event,
    Emitter<ImagePickerState> emit,
  ) async {
    XFile? file = await image.pickImageFromGallery();
    emit(state.copyWith(file: file));
  }
}
