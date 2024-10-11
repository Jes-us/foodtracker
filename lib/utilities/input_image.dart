import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
export 'package:foodtracker/core/utils/background_image.dart';

class InputImage extends StatefulWidget {
  InputImage({super.key, required fromCamera});

  final bool fromCamera = false;
  File? _selectedIImage;
  get selectedImage => _selectedIImage;
  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  void _captureImage(bool imageType) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: imageType ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 600);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      widget._selectedIImage = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  highlightColor: Colors.transparent,
                  child: IconButton(
                    visualDensity: VisualDensity.comfortable,
                    onPressed: () {
                      _captureImage(true);
                    },
                    iconSize: 50,
                    icon: const Icon(
                      Icons.photo_camera,
                      color: Color(0xFfF05833),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);

    if (widget._selectedIImage != null) {
      content = Image.file(widget._selectedIImage!,
          fit: BoxFit.fill, width: double.infinity, height: double.infinity);
    }

    return Expanded(
      child: Container(
        //decoration: BoxDecoration(border: Border.all(width: 1)),
        //margin: EdgeInsets.all(),
        alignment: Alignment.center,
        child: content,
      ),
    );
  }
}
