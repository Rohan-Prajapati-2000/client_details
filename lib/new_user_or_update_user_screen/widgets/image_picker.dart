import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/constants/sizes.dart';

class ImagePickerWidget extends StatefulWidget {
  ImagePickerWidget({
    super.key,
  });

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? selectedImageFile;
  Uint8List? selectedImageBytes;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImageFile = File(image.path);
      selectedImageBytes = await image.readAsBytes();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => pickImage(),
          child: selectedImageBytes != null
              ? Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SSizes.borderRadiusMd),
              image: DecorationImage(
                image: MemoryImage(selectedImageBytes!),
                fit: BoxFit.cover,
              ),
            ),
          )
              : DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(SSizes.borderRadiusMd),
            dashPattern: [6, 3],
            color: Colors.black,
            child: Container(
              height: 100,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image),
                  Text('Select Image'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
