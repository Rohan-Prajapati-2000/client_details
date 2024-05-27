import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/constants/sizes.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(List<Uint8List?>) onImageSelected;

  ImagePickerWidget({Key? key, required this.onImageSelected}) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  List<Uint8List?> selectedImageBytesList = [];

  Future<void> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null && images.isNotEmpty) {
      selectedImageBytesList = await Future.wait(images.map((image) => image.readAsBytes()));
      widget.onImageSelected(selectedImageBytesList);
      setState(() {});
    }
  }

  void removeImage(int index) {
    setState(() {
      selectedImageBytesList.removeAt(index);
      widget.onImageSelected(selectedImageBytesList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 10,
          children: selectedImageBytesList.asMap().entries.map((entry) {
            int index = entry.key;
            Uint8List? imageBytes = entry.value;

            return Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SSizes.borderRadiusMd),
                    image: DecorationImage(
                      image: MemoryImage(imageBytes!),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => removeImage(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        SizedBox(height: SSizes.spaceBtwItems),
        GestureDetector(
          onTap: pickImages,
          child: DottedBorder(
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
                  Text('Select Images'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
