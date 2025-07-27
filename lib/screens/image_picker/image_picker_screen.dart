import 'dart:io';

import 'package:bloc_practice/bloc/image_picker/image_picker_bloc.dart';
import 'package:bloc_practice/bloc/image_picker/image_picker_event.dart';
import 'package:bloc_practice/bloc/image_picker/image_picker_state.dart';
import 'package:bloc_practice/utils/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  late ImagePickerBloc _imagePickerBloc;

  @override
  void initState() {
    _imagePickerBloc = ImagePickerBloc(ImagePickerUtils());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _imagePickerBloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Image Picker')),
        body: BlocBuilder<ImagePickerBloc, ImagePickerState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<ImagePickerBloc>().add(CameraCapture());
                      },
                      child: CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.camera, color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        context.read<ImagePickerBloc>().add(
                          GalleryImagePicker(),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        child: Icon(Icons.photo, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                state.file != null
                    ? Image.file(
                      File(state.file!.path.toString()),
                      height: 400,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                    : SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }
}
